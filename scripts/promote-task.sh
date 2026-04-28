#!/bin/bash
# =============================================================
#  promote-task.sh — worktree에서 검증된 작업을 master에 반영
#
#  사용법: bash scripts/promote-task.sh <task-name> [--auto]
#    task-name : start-task.sh 로 생성한 작업 이름
#    --auto    : 검증 통과 시 자동 merge 실행
#                (생략 시 머지 명령어만 출력하는 dry-run 모드)
#
#  단계:
#    1) verify-task.sh <task-name> 실행 — FAIL>0 이면 중단
#    2) 메인 repo가 master + clean 상태인지 확인
#    3) Merge preview (커밋/파일 변경 요약)
#    4) Dry-run: 명령어만 출력 / --auto: 실제 merge --no-ff
#    5) 성공 시 다음 단계(push, worktree 정리) 안내
# =============================================================
set -euo pipefail

# ── 색상 ──
RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'; YELLOW='\033[1;33m'; NC='\033[0m'

# ── 인자 파싱 ──
if [ $# -lt 1 ]; then
  echo -e "${RED}사용법: bash scripts/promote-task.sh <task-name> [--auto]${NC}"
  exit 1
fi

TASK_NAME="$1"
AUTO_MERGE=false
shift
for arg in "$@"; do
  case "$arg" in
    --auto) AUTO_MERGE=true ;;
    -h|--help)
      echo "사용법: bash scripts/promote-task.sh <task-name> [--auto]"
      echo "  --auto: 검증 통과 시 자동 merge (없으면 머지 명령어만 출력)"
      exit 0
      ;;
    *) echo -e "${RED}알 수 없는 옵션: $arg${NC}"; exit 1 ;;
  esac
done

# ── 프로젝트 루트 ──
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$ROOT_DIR"

WORKTREE_DIR="$ROOT_DIR/.claude/agents/worktrees/$TASK_NAME"

echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}  작업 반영 (Promote): ${YELLOW}${TASK_NAME}${NC}"
echo -e "${CYAN}========================================${NC}"
echo ""

# ── 0) Worktree / 브랜치 확인 ──
if [ ! -d "$WORKTREE_DIR" ]; then
  echo -e "${RED}[중단] Worktree 없음: $WORKTREE_DIR${NC}"
  echo -e "       먼저 'bash scripts/start-task.sh ${TASK_NAME} <type>' 실행 필요"
  exit 1
fi

BRANCH_NAME=$(git -C "$WORKTREE_DIR" branch --show-current 2>/dev/null || echo "")
if [ -z "$BRANCH_NAME" ]; then
  echo -e "${RED}[중단] Worktree 브랜치 확인 실패 — detached HEAD?${NC}"
  exit 1
fi
echo -e "  Worktree : ${WORKTREE_DIR}"
echo -e "  브랜치   : ${YELLOW}${BRANCH_NAME}${NC}"
echo ""

# ── 1) 검증 (verify-task.sh) ──
echo -e "${CYAN}── 1단계: 검증 ──${NC}"
if bash "$SCRIPT_DIR/verify-task.sh" "$TASK_NAME"; then
  echo ""
  echo -e "${GREEN}✔ 검증 통과 — 다음 단계로 진행${NC}"
else
  echo ""
  echo -e "${RED}[중단] 검증 실패 (FAIL > 0) — promote 불가${NC}"
  echo -e "       worktree에서 문제를 수정한 뒤 다시 시도하세요."
  exit 1
fi
echo ""

# ── 2) master 상태 확인 ──
echo -e "${CYAN}── 2단계: master 상태 확인 ──${NC}"
CURRENT_BRANCH=$(git -C "$ROOT_DIR" branch --show-current 2>/dev/null || echo "")
if [ "$CURRENT_BRANCH" != "master" ]; then
  echo -e "${RED}[중단] 메인 repo가 master 브랜치가 아님 (현재: ${CURRENT_BRANCH:-detached})${NC}"
  echo -e "       'cd ${ROOT_DIR} && git checkout master' 실행 후 재시도"
  exit 1
fi
echo -e "  현재 브랜치: master ✔"

UNCOMMITTED=$(git -C "$ROOT_DIR" status --porcelain 2>/dev/null | wc -l)
if [ "$UNCOMMITTED" -gt 0 ]; then
  echo -e "${YELLOW}  ⚠ master에 uncommitted 변경 ${UNCOMMITTED}개 — merge 충돌 위험${NC}"
  echo -e "${YELLOW}    먼저 정리 권장 (git stash / commit) 후 진행${NC}"
fi
echo ""

# ── 3) Merge preview ──
echo -e "${CYAN}── 3단계: Merge Preview ──${NC}"
COMMITS=$(git -C "$ROOT_DIR" rev-list "master..${BRANCH_NAME}" --count 2>/dev/null || echo "0")
BEHIND=$(git -C "$ROOT_DIR" rev-list "${BRANCH_NAME}..master" --count 2>/dev/null || echo "0")

echo -e "  반영될 커밋 (master..${BRANCH_NAME}): ${YELLOW}${COMMITS}${NC}개"
echo -e "  master가 앞선 커밋 (${BRANCH_NAME}..master): ${YELLOW}${BEHIND}${NC}개"

if [ "$COMMITS" -eq 0 ]; then
  echo ""
  echo -e "${YELLOW}[종료] master 대비 새 커밋이 없습니다 — promote할 내용 없음${NC}"
  exit 0
fi

if [ "$BEHIND" -gt 0 ]; then
  echo -e "${YELLOW}  ⚠ ${BRANCH_NAME}이(가) master에 ${BEHIND} 커밋 뒤처짐${NC}"
  echo -e "${YELLOW}    rebase 권장: cd ${WORKTREE_DIR} && git rebase master${NC}"
fi

echo ""
echo -e "  ${CYAN}커밋 목록:${NC}"
git -C "$ROOT_DIR" log "master..${BRANCH_NAME}" --oneline | head -20 | sed 's/^/    /'
if [ "$COMMITS" -gt 20 ]; then
  echo "    ... 외 $((COMMITS - 20))개"
fi

echo ""
echo -e "  ${CYAN}파일 변경 요약:${NC}"
git -C "$ROOT_DIR" diff "master..${BRANCH_NAME}" --stat | tail -20 | sed 's/^/    /'
echo ""

# ── 4) Merge 실행 또는 명령어 출력 ──
echo -e "${CYAN}── 4단계: Merge ──${NC}"
MERGE_MSG="Merge branch '${BRANCH_NAME}'"

if [ "$AUTO_MERGE" = false ]; then
  echo -e "${YELLOW}[Dry-run 모드] 실제 merge는 수행하지 않습니다.${NC}"
  echo ""
  echo -e "  실제 반영하려면 아래 명령을 실행하세요:"
  echo ""
  echo -e "    ${GREEN}cd ${ROOT_DIR}${NC}"
  echo -e "    ${GREEN}git merge --no-ff ${BRANCH_NAME} -m \"${MERGE_MSG}\"${NC}"
  echo ""
  echo -e "  또는 자동 merge: ${GREEN}bash scripts/promote-task.sh ${TASK_NAME} --auto${NC}"
  exit 0
fi

# --auto 모드
echo -e "${YELLOW}--auto 옵션 감지 — master에 merge 진행${NC}"
echo ""
if git -C "$ROOT_DIR" merge --no-ff "$BRANCH_NAME" -m "$MERGE_MSG"; then
  echo ""
  echo -e "${GREEN}========================================${NC}"
  echo -e "${GREEN}  Merge 성공!${NC}"
  echo -e "${GREEN}========================================${NC}"
  echo -e "  반영된 브랜치: ${BRANCH_NAME}"
  echo -e "  반영된 커밋  : ${COMMITS}개"
  echo ""
  echo -e "${YELLOW}다음 단계 (수동):${NC}"
  echo -e "  # 1) 원격 저장소로 push"
  echo -e "    ${GREEN}git push origin master${NC}"
  echo ""
  echo -e "  # 2) worktree 정리 (작업 완료 시)"
  echo -e "    ${GREEN}git worktree remove ${WORKTREE_DIR}${NC}"
  echo -e "    ${GREEN}git branch -d ${BRANCH_NAME}${NC}"
else
  echo ""
  echo -e "${RED}[중단] Merge 실패 — 충돌이 발생했을 수 있습니다.${NC}"
  echo -e "       'cd ${ROOT_DIR} && git status' 로 상태 확인 후 수동 해결"
  echo -e "       취소하려면: 'git merge --abort'"
  exit 1
fi
