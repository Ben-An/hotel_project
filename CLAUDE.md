# CLAUDE.md - AI 에이전트 필 수 규칙
 >이 파일은 모든 작업 전에 자동으로 읽힌다.
 >여기에 적힌 규칙은 선택이 아니라 **필수**다.

### 1단계: EXEC_PLAN 생성
- `bash scripts/start-task.sh <task-name> <type>' 실행.
- 이 스크립트가 EXEC_PLAN + worktree + 포트 + 로그 디렉터리를 한번에 
생성한다.

### 2단계 : worktree에서 구현
-생성된 worktree 디렉터리로 이동하여 작업한다.

### 3단계 : 테스트작성 (필수 -건너 뛸 수 없다)
- 구현한 기능에 대한 **단위 데스트를 반드시 작성 **한다.
- 테스트 파일 : `src\**\*.test.jsx` (vitest + React Testing Library)
- 테스트 기준 :
        - 새 기능 : 정상 동작 + 엣지 케이스 + props 검증
        - 버그 수정 : 재현 테스트(실패 > 수정 > 통과)
        - 리팩터링 : 기존 동작 보존 확인
        - `npm test` 가 통과하지 않으면 pre-commit 훅이 커밋을 차단한다.

## 4단계: 검증 실행 (필수 - 절대 건너 뛸 수 없다)
- 커밋전 `bash scripts\verify-task`를 실행하여 전체 검증 진행



