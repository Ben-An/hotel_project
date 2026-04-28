#!/bin/bash
# =============================================================
#  start-task.sh — 새 작업 환경을 한번에 셋업
#
#  사용법: bash scripts/start-task.sh <task-name> <type>
#    task-name : 작업 이름 (예: hotel-image-upload)
#    type      : 브랜치 접두어 (feature | fix | refactor | hotfix)
#
#  생성물:
#    1) EXEC_PLAN  — .claude/agents/plans/<task-name>.md  (실행 계획 템플릿)
#    2) Worktree   — .claude/agents/worktrees/<task-name> (격리된 git worktree)
#    3) Port       — .claude/agents/plans/<task-name>.md 에 할당 포트 기록
#    4) Log dir    — .claude/agents/logs/<task-name>/     (BE·FE 로그 디렉터리)
# =============================================================
set -euo pipefail

# ── 색상 ──
RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'; YELLOW='\033[1;33m'; NC='\033[0m'

# ── 인자 검증 ──
if [ $# -lt 2 ]; then
  echo -e "${RED}사용법: bash scripts/start-task.sh <task-name> <type>${NC}"
  echo "  type: feature | fix | refactor | hotfix"
  exit 1
fi

TASK_NAME="$1"
TASK_TYPE="$2"
VALID_TYPES="feature fix refactor hotfix"

if ! echo "$VALID_TYPES" | grep -qw "$TASK_TYPE"; then
  echo -e "${RED}오류: type은 feature | fix | refactor | hotfix 중 하나여야 합니다.${NC}"
  exit 1
fi

# ── 프로젝트 루트 (scripts/ 의 상위) ──
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$ROOT_DIR"

BRANCH_NAME="${TASK_TYPE}/${TASK_NAME}"
WORKTREE_DIR="$ROOT_DIR/.claude/agents/worktrees/$TASK_NAME"
PLAN_DIR="$ROOT_DIR/.claude/agents/plans"
LOG_DIR="$ROOT_DIR/.claude/agents/logs/$TASK_NAME"

echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}  작업 환경 셋업: ${YELLOW}${TASK_NAME}${NC}"
echo -e "${CYAN}========================================${NC}"

# ── 1) 포트 할당 ──
# 기본 포트: BE=8082, FE(Tomcat)=8080
# worktree별로 충돌 방지: 기존 plans/*.md 에서 사용 중인 포트를 확인 후 다음 포트 할당
BASE_BE_PORT=8082
BASE_FE_PORT=8080

find_available_port() {
  local base=$1
  local port=$base
  # plans 디렉터리에서 이미 할당된 포트 수집
  local used_ports=""
  if [ -d "$PLAN_DIR" ]; then
    used_ports=$(grep -roh "PORT_[BF]E=\([0-9]*\)" "$PLAN_DIR" 2>/dev/null | grep -o '[0-9]*' || true)
  fi
  while echo "$used_ports" | grep -qw "$port" 2>/dev/null; do
    port=$((port + 10))
  done
  echo "$port"
}

BE_PORT=$(find_available_port $BASE_BE_PORT)
FE_PORT=$(find_available_port $BASE_FE_PORT)

echo -e "${GREEN}[1/4] 포트 할당${NC} — BE: ${BE_PORT}, FE: ${FE_PORT}"

# ── 2) EXEC_PLAN 생성 ──
mkdir -p "$PLAN_DIR"
PLAN_FILE="$PLAN_DIR/${TASK_NAME}.md"

if [ -f "$PLAN_FILE" ]; then
  echo -e "${YELLOW}[2/4] EXEC_PLAN 이미 존재${NC} — $PLAN_FILE"
else
  cat > "$PLAN_FILE" <<PLAN_EOF
# EXEC_PLAN: ${TASK_NAME}

## 개요
- **작업명**: ${TASK_NAME}
- **유형**: ${TASK_TYPE}
- **브랜치**: ${BRANCH_NAME}
- **생성일**: $(date '+%Y-%m-%d %H:%M')

## 포트 설정
- PORT_BE=${BE_PORT}
- PORT_FE=${FE_PORT}

## 구현 계획
1. [ ] 단계 1
2. [ ] 단계 2
3. [ ] 단계 3

## 영향 범위
- **BE 변경 파일**:
- **FE 변경 파일**:
- **DB 변경**:

## 로그 경로
- BE 로그: .claude/agents/logs/${TASK_NAME}/be.log
- FE 로그: .claude/agents/logs/${TASK_NAME}/fe.log

## 비고
PLAN_EOF
  echo -e "${GREEN}[2/4] EXEC_PLAN 생성${NC} — $PLAN_FILE"
fi

# ── 3) Git Worktree 생성 ──
if [ -d "$WORKTREE_DIR" ]; then
  echo -e "${YELLOW}[3/4] Worktree 이미 존재${NC} — $WORKTREE_DIR"
else
  # 브랜치가 없으면 새로 생성
  if git show-ref --verify --quiet "refs/heads/$BRANCH_NAME" 2>/dev/null; then
    git worktree add "$WORKTREE_DIR" "$BRANCH_NAME"
  else
    git worktree add -b "$BRANCH_NAME" "$WORKTREE_DIR" master
  fi
  echo -e "${GREEN}[3/4] Worktree 생성${NC} — $WORKTREE_DIR (branch: $BRANCH_NAME)"
fi

# ── 4) 로그 디렉터리 생성 ──
mkdir -p "$LOG_DIR"
echo -e "${GREEN}[4/4] 로그 디렉터리 생성${NC} — $LOG_DIR"

# ── 완료 요약 ──
echo ""
echo -e "${CYAN}========================================${NC}"
echo -e "${GREEN}  셋업 완료!${NC}"
echo -e "${CYAN}========================================${NC}"
echo -e "  EXEC_PLAN : ${PLAN_FILE}"
echo -e "  Worktree  : ${WORKTREE_DIR}"
echo -e "  Branch    : ${BRANCH_NAME}"
echo -e "  BE Port   : ${BE_PORT}"
echo -e "  FE Port   : ${FE_PORT}"
echo -e "  Logs      : ${LOG_DIR}"
echo ""
echo -e "${YELLOW}다음 단계:${NC}"
echo -e "  cd ${WORKTREE_DIR}"
echo -e "  # .claude/agents/plans/${TASK_NAME}.md 에서 작업 계획을 작성하세요"
echo -e "  # BE 실행: java -jar be_hotel/target/be_hotel-1.0.0.jar --server.port=${BE_PORT}"
echo -e "  # 로그 확인: tail -f .claude/agents/logs/${TASK_NAME}/be.log"
