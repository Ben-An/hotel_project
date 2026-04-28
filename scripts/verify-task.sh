#!/bin/bash
# =============================================================
#  verify-task.sh — 작업 환경 상태를 검증
#
#  사용법: bash scripts/verify-task.sh <task-name>
#
#  검증 항목:
#    1) EXEC_PLAN  존재 여부
#    2) Worktree   존재 + 브랜치 상태
#    3) Port       할당 포트 사용 여부
#    4) Log dir    존재 여부
#    5) Build      BE/FE 빌드 성공 여부 (worktree 기준)
#    6) Playwright  E2E 테스트 (FE 서버 실행 중일 때)
#    7) Git        변경 파일 요약
# =============================================================
set -euo pipefail

# ── 색상 ──
RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'; YELLOW='\033[1;33m'; NC='\033[0m'
PASS="${GREEN}PASS${NC}"
FAIL="${RED}FAIL${NC}"
WARN="${YELLOW}WARN${NC}"

# ── 인자 검증 ──
if [ $# -lt 1 ]; then
  echo -e "${RED}사용법: bash scripts/verify-task.sh <task-name>${NC}"
  exit 1
fi

TASK_NAME="$1"

# ── 프로젝트 루트 ──
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$ROOT_DIR"

AGENTS_DIR="$ROOT_DIR/.claude/agents"
PLAN_FILE="$AGENTS_DIR/plans/${TASK_NAME}.md"
WORKTREE_DIR="$AGENTS_DIR/worktrees/$TASK_NAME"
LOG_DIR="$AGENTS_DIR/logs/$TASK_NAME"

TOTAL=0
PASSED=0
FAILED=0
WARNED=0

result() {
  local status=$1 label=$2 detail=$3
  TOTAL=$((TOTAL + 1))
  if [ "$status" = "pass" ]; then
    PASSED=$((PASSED + 1))
    echo -e "  [${PASS}] ${label} — ${detail}"
  elif [ "$status" = "warn" ]; then
    WARNED=$((WARNED + 1))
    echo -e "  [${WARN}] ${label} — ${detail}"
  else
    FAILED=$((FAILED + 1))
    echo -e "  [${FAIL}] ${label} — ${detail}"
  fi
}

echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}  작업 검증: ${YELLOW}${TASK_NAME}${NC}"
echo -e "${CYAN}========================================${NC}"
echo ""

# ── 1) EXEC_PLAN ──
echo -e "${CYAN}[1/7] EXEC_PLAN${NC}"
if [ -f "$PLAN_FILE" ]; then
  result "pass" "파일 존재" "$PLAN_FILE"
else
  result "fail" "파일 없음" "EXEC_PLAN이 생성되지 않았습니다 ($PLAN_FILE)"
fi
echo ""

# ── 2) Worktree ──
echo -e "${CYAN}[2/7] Worktree${NC}"
if [ -d "$WORKTREE_DIR" ]; then
  result "pass" "디렉터리 존재" "$WORKTREE_DIR"

  # 브랜치 확인
  wt_branch=$(git -C "$WORKTREE_DIR" branch --show-current 2>/dev/null || echo "unknown")
  result "pass" "브랜치" "$wt_branch"

  # master 대비 커밋 수
  ahead=$(git -C "$WORKTREE_DIR" rev-list master..HEAD --count 2>/dev/null || echo "?")
  behind=$(git -C "$WORKTREE_DIR" rev-list HEAD..master --count 2>/dev/null || echo "?")
  if [ "$behind" != "?" ] && [ "$behind" -gt 0 ]; then
    result "warn" "master 동기화" "ahead ${ahead}, behind ${behind} — rebase 필요"
  else
    result "pass" "master 동기화" "ahead ${ahead}, behind ${behind}"
  fi
else
  result "fail" "디렉터리 없음" "Worktree가 생성되지 않았습니다"
fi
echo ""

# ── 3) Port ──
echo -e "${CYAN}[3/7] Port${NC}"
if [ -f "$PLAN_FILE" ]; then
  BE_PORT=$(grep -oP 'PORT_BE=\K[0-9]+' "$PLAN_FILE" 2>/dev/null || echo "")
  FE_PORT=$(grep -oP 'PORT_FE=\K[0-9]+' "$PLAN_FILE" 2>/dev/null || echo "")

  if [ -n "$BE_PORT" ]; then
    if netstat -ano 2>/dev/null | grep -q ":${BE_PORT} " || ss -tlnp 2>/dev/null | grep -q ":${BE_PORT} "; then
      result "pass" "BE 포트 ${BE_PORT}" "사용 중 (서버 실행 중)"
    else
      result "warn" "BE 포트 ${BE_PORT}" "미사용 (서버 미실행)"
    fi
  else
    result "fail" "BE 포트" "EXEC_PLAN에 PORT_BE 설정 없음"
  fi

  if [ -n "$FE_PORT" ]; then
    if netstat -ano 2>/dev/null | grep -q ":${FE_PORT} " || ss -tlnp 2>/dev/null | grep -q ":${FE_PORT} "; then
      result "pass" "FE 포트 ${FE_PORT}" "사용 중 (서버 실행 중)"
    else
      result "warn" "FE 포트 ${FE_PORT}" "미사용 (서버 미실행)"
    fi
  else
    result "fail" "FE 포트" "EXEC_PLAN에 PORT_FE 설정 없음"
  fi
else
  result "fail" "포트 확인 불가" "EXEC_PLAN 파일 없음"
fi
echo ""

# ── 4) Log dir ──
echo -e "${CYAN}[4/7] Log 디렉터리${NC}"
if [ -d "$LOG_DIR" ]; then
  result "pass" "디렉터리 존재" "$LOG_DIR"
  log_files=$(find "$LOG_DIR" -type f 2>/dev/null | wc -l)
  if [ "$log_files" -gt 0 ]; then
    result "pass" "로그 파일" "${log_files}개 존재"
  else
    result "warn" "로그 파일" "아직 로그 없음"
  fi
else
  result "fail" "디렉터리 없음" "로그 디렉터리가 생성되지 않았습니다"
fi
echo ""

# ── 5) Build ──
echo -e "${CYAN}[5/7] Build${NC}"
if [ -d "$WORKTREE_DIR" ]; then
  # BE build
  if [ -d "$WORKTREE_DIR/be_hotel" ]; then
    echo -e "  ${YELLOW}BE 빌드 중...${NC}"
    if (cd "$WORKTREE_DIR/be_hotel" && "$ROOT_DIR/apache-maven-3.9.6/bin/mvn" clean package -DskipTests -q 2>&1) > /dev/null 2>&1; then
      result "pass" "BE 빌드" "SUCCESS"
    else
      result "fail" "BE 빌드" "FAILED — 로그 확인 필요"
    fi
  else
    result "fail" "BE 빌드" "be_hotel 디렉터리 없음"
  fi

  # FE build
  if [ -d "$WORKTREE_DIR/fe_hotel" ]; then
    echo -e "  ${YELLOW}FE 빌드 중...${NC}"
    if (cd "$WORKTREE_DIR/fe_hotel" && "$ROOT_DIR/apache-maven-3.9.6/bin/mvn" clean package -DskipTests -q 2>&1) > /dev/null 2>&1; then
      result "pass" "FE 빌드" "SUCCESS"
    else
      result "fail" "FE 빌드" "FAILED — 로그 확인 필요"
    fi
  else
    result "fail" "FE 빌드" "fe_hotel 디렉터리 없음"
  fi
else
  result "fail" "빌드 스킵" "Worktree 없어서 빌드 불가"
fi
echo ""

# ── 6) Playwright E2E ──
echo -e "${CYAN}[6/7] Playwright E2E${NC}"
if [ -f "$PLAN_FILE" ]; then
  PW_FE_PORT=$(grep -oP 'PORT_FE=\K[0-9]+' "$PLAN_FILE" 2>/dev/null || echo "")
else
  PW_FE_PORT=""
fi
PW_FE_PORT=${PW_FE_PORT:-8080}

if ! command -v npx &>/dev/null; then
  result "fail" "Playwright" "npx 명령어 없음 (Node.js 미설치)"
elif [ ! -f "$ROOT_DIR/playwright.config.js" ]; then
  result "fail" "Playwright" "playwright.config.js 없음"
elif [ ! -d "$ROOT_DIR/e2e" ]; then
  result "fail" "Playwright" "e2e/ 테스트 디렉터리 없음"
else
  # FE 서버 실행 중인지 확인
  fe_running=false
  if netstat -ano 2>/dev/null | grep -q ":${PW_FE_PORT} .*LISTENING"; then
    fe_running=true
  elif curl -s -o /dev/null -w "%{http_code}" "http://localhost:${PW_FE_PORT}" 2>/dev/null | grep -qE "^[23]"; then
    fe_running=true
  fi

  if [ "$fe_running" = true ]; then
    result "pass" "FE 서버" "포트 ${PW_FE_PORT} 실행 중"

    echo -e "  ${YELLOW}E2E 테스트 실행 중...${NC}"
    PW_LOG="$LOG_DIR/playwright.log"
    mkdir -p "$LOG_DIR"

    npx playwright test --config="$ROOT_DIR/playwright.config.js" --reporter=list 2>&1 | tee "$PW_LOG" | tail -5
    pw_exit=${PIPESTATUS[0]}

    # 결과 파싱
    pw_passed=$(grep -oP '\d+(?= passed)' "$PW_LOG" 2>/dev/null | tail -1 || true)
    pw_failed=$(grep -oP '\d+(?= failed)' "$PW_LOG" 2>/dev/null | tail -1 || true)
    pw_skipped=$(grep -oP '\d+(?= skipped)' "$PW_LOG" 2>/dev/null | tail -1 || true)
    pw_passed=${pw_passed:-0}
    pw_failed=${pw_failed:-0}
    pw_skipped=${pw_skipped:-0}

    if [ "$pw_exit" -eq 0 ]; then
      result "pass" "E2E 테스트" "${pw_passed} passed, ${pw_failed} failed, ${pw_skipped} skipped"
    else
      result "fail" "E2E 테스트" "${pw_passed} passed, ${pw_failed} failed — 로그: ${PW_LOG}"
    fi
  else
    result "warn" "FE 서버 미실행" "포트 ${PW_FE_PORT} — E2E 스킵 (서버 시작 후 재실행)"
  fi
fi
echo ""

# ── 7) Git 상태 ──
echo -e "${CYAN}[7/7] Git 상태${NC}"
if [ -d "$WORKTREE_DIR" ]; then
  changed=$(git -C "$WORKTREE_DIR" status --porcelain 2>/dev/null | wc -l)
  staged=$(git -C "$WORKTREE_DIR" diff --cached --name-only 2>/dev/null | wc -l)
  unstaged=$(git -C "$WORKTREE_DIR" diff --name-only 2>/dev/null | wc -l)
  untracked=$(git -C "$WORKTREE_DIR" ls-files --others --exclude-standard 2>/dev/null | wc -l)

  if [ "$changed" -eq 0 ]; then
    result "pass" "작업 디렉터리" "깨끗함 (변경 없음)"
  else
    result "warn" "작업 디렉터리" "변경 ${changed}개 (staged: ${staged}, unstaged: ${unstaged}, untracked: ${untracked})"
  fi

  # 변경 파일 목록 (있으면)
  if [ "$changed" -gt 0 ]; then
    echo -e "  ${CYAN}변경 파일:${NC}"
    git -C "$WORKTREE_DIR" status --porcelain 2>/dev/null | head -10 | while read line; do
      echo "    $line"
    done
    if [ "$changed" -gt 10 ]; then
      echo "    ... 외 $((changed - 10))개"
    fi
  fi
else
  result "fail" "Git 상태" "Worktree 없음"
fi

# ── 최종 요약 ──
echo ""
echo -e "${CYAN}========================================${NC}"
if [ "$FAILED" -eq 0 ]; then
  echo -e "${GREEN}  검증 완료: ${PASSED}/${TOTAL} PASS, ${WARNED} WARN, ${FAILED} FAIL${NC}"
else
  echo -e "${RED}  검증 완료: ${PASSED}/${TOTAL} PASS, ${WARNED} WARN, ${FAILED} FAIL${NC}"
fi
echo -e "${CYAN}========================================${NC}"

exit "$FAILED"
