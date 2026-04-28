# TODO - 회원가입 (join.jsp) 완성

## 현재 상태
기본 흐름(폼 → fe_hotel Controller → be_hotel API → Oracle DB)은 구현 완료.
아이디/닉네임 중복확인, 이메일 인증, 비밀번호 확인 등 클라이언트 검증 동작함.

---

## 해야 할 일

### 1. 보안 (Critical)
- [x] **비밀번호 암호화** — BCryptPasswordEncoder 적용 완료
  - 회원가입: `BCrypt.encode()` 후 DB 저장
  - 로그인: ID로 조회 후 `BCrypt.matches()` 비교
  - 회원수정: 비밀번호 변경 시 암호화
  - 회원삭제: BCrypt 비밀번호 검증 후 삭제
  - 수정 파일: `pom.xml`, `MemberServiceImpl.java`, `MemberMapper.java`, `MemberMapper.xml`

### 2. 서버 사이드 검증 (High)
- [x] **입력값 검증** — Bean Validation(JSR 380) 적용 완료
  - `spring-boot-starter-validation` 의존성 추가
  - MemberVO, HotelVO, RelyVO, PayRservationVO에 검증 어노테이션 추가
  - MemberVO는 ValidationGroups(Join/Login/Update/Delete)로 상황별 검증 분리
  - Controller에 `@Valid`/`@Validated` 적용 (Member, Admin, Detail, Reservation)
  - `GlobalExceptionHandler`로 통일된 에러 응답 (`{ success: false, errors: [...] }`)
  - 수정 파일: `pom.xml`, `MemberVO.java`, `HotelVO.java`, `RelyVO.java`, `PayRservationVO.java`, `MemberApiController.java`, `AdminApiController.java`, `DetailApiController.java`, `ReservationApiController.java`, `GlobalExceptionHandler.java`(신규), `ValidationGroups.java`(신규)

### 3. 에러 처리 (High)
- [x] **검증 에러 처리** — `GlobalExceptionHandler`에서 `MethodArgumentNotValidException`, `HttpMessageNotReadableException` 처리 완료
- [x] **기타 예외 처리 추가**
  - 이메일 발송 실패 시 로깅 + 500 에러 응답 반환 (`MemberApiController.mailCheck`)
  - 중복 키 DB 에러 → `DuplicateKeyException` 처리 (409 Conflict)
  - 일반 예외 → `Exception` 핸들러 추가 (500, 에러 메시지 포함)
  - 수정 파일: `MemberApiController.java`, `GlobalExceptionHandler.java`

### 4. 이메일 설정 불일치 (Medium)
- [x] **발신자 주소 통일** — `app.mail.from-address` 프로퍼티 추가, `@Value`로 주입
  - `application.properties`에 `app.mail.from-address=byungjinan7@gmail.com` 추가
  - `MemberApiController.java`에서 하드코딩 제거, `mailFromAddress` 필드로 교체

### 5. DB 스키마 (Medium)
- [ ] **NAVERLOGIN 컬럼 누락**
  - `MemberMapper.xml`에서 `naverLogin` 컬럼 참조하지만 테이블에 없음
  - `ALTER TABLE member ADD naverLogin VARCHAR2(100)` 실행 또는 SQL 수정
  - 관련 파일: `MemberMapper.xml` (line 61, 68, 75), `hotel.sql`

### 6. 가입 완료 후 처리 (Medium)
- [ ] **가입 성공 페이지/리다이렉트**
  - 현재 POST /member/join 후 처리 확인 필요
  - 성공 시 로그인 페이지로 리다이렉트 + 성공 메시지 (SweetAlert2)

### 7. 트랜잭션 (Low)
- [ ] **@Transactional 적용**
  - `MemberServiceImpl.memberJoin()` 메서드에 트랜잭션 어노테이션 추가

### 8. 기타 개선
- [ ] 비밀번호 강도 검증 (최소 길이, 특수문자 등)
- [ ] 아이디/닉네임 입력 규칙 (길이, 허용 문자)
- [ ] 회원가입 완료 후 자동 로그인 또는 환영 이메일

---

## 관련 파일

| 파일 | 위치 |
|------|------|
| join.jsp | `fe_hotel/src/main/webapp/WEB-INF/views/member/join.jsp` |
| FE MemberController | `fe_hotel/src/main/java/org/zerock/controller/MemberController.java` |
| BE MemberApiController | `be_hotel/src/main/java/org/zerock/controller/MemberApiController.java` |
| MemberServiceImpl | `be_hotel/src/main/java/org/zerock/service/MemberServiceImpl.java` |
| MemberMapper.xml | `be_hotel/src/main/resources/org/zerock/mapper/MemberMapper.xml` |
| MemberVO (BE) | `be_hotel/src/main/java/org/zerock/domain/MemberVO.java` |
| MemberVO (FE) | `fe_hotel/src/main/java/org/zerock/domain/MemberVO.java` |
| DB 스키마 | `fe_hotel/src/main/webapp/resources/hotel.sql` |
| application.properties | `be_hotel/src/main/resources/application.properties` |
