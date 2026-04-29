# hotel_project

Spring Boot 기반 백엔드 API와 Spring MVC/JSP 기반 프런트엔드로 구성된 호텔 예약 웹 애플리케이션.

## 아키텍처

```
hotel_project/
├── be_hotel/        # 백엔드 (Spring Boot 2.7 + Undertow + MyBatis + Oracle)
├── fe_hotel/        # 프런트엔드 (Spring MVC 5 + JSP, WAR 패키징)
├── tomcat/          # fe_hotel 배포용 Tomcat
├── e2e/             # Playwright E2E 테스트
└── scripts/         # 작업 자동화 스크립트
```

| 구분 | 기술 스택 |
|------|-----------|
| 백엔드 | Spring Boot 2.7.18, Undertow, MyBatis 2.3, Oracle JDBC, Spring Security Crypto, Spring Mail |
| 프런트엔드 | Spring MVC 5.0, JSP/JSTL, Jackson, RestTemplate |
| 빌드 | Maven 3.9, Java 17 |
| 인증 | BCrypt, Naver OAuth (scribejava) |
| 테스트 | Spring Boot Test, Playwright |

## 사전 요구사항

- JDK 17
- Maven 3.9+
- Oracle DB (be_hotel `application.properties`에 접속 정보 설정)
- Node.js (E2E 테스트 실행 시)

DB 접속 정보, 메일 계정 등 민감 설정은 환경변수로 관리합니다 (`.gitignore` 처리됨).


## 개발 워크플로

이 저장소는 worktree 기반 작업 흐름을 따릅니다 (`CLAUDE.md` 참고).

1. **작업 시작** — `bash scripts/start-task.sh <task-name> <type>`
   EXEC_PLAN, worktree, 포트, 로그 디렉터리를 한 번에 생성합니다.
2. **구현** — 생성된 worktree에서 작업.
3. **테스트 작성 (필수)** — 새 기능/버그 수정/리팩터링 모두 테스트 동반.
4. **검증** — 커밋 전 `bash scripts/verify-task.sh` 실행. pre-commit 훅이 통과 여부를 확인합니다.

## 디렉터리별 주요 파일

- `be_hotel/src/main/java/...` — REST 컨트롤러, 서비스, MyBatis 매퍼
- `fe_hotel/src/main/webapp/WEB-INF/views/` — JSP 뷰
- `scripts/start-task.sh` — 작업 초기 세팅
- `scripts/verify-task.sh` — 커밋 전 검증
- `scripts/promote-task.sh` — 작업 머지/정리
