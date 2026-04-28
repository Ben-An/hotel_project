# 심사숙소 - 기술 스택 정리

## Backend (be_hotel)

| 분류 | 기술 | 버전 |
|------|------|------|
| Framework | Spring Boot | 2.7.18 |
| Language | Java | 17 |
| WAS | Undertow (embedded) | - |
| ORM | MyBatis Spring Boot Starter | 2.3.1 |
| Database | Oracle XE (ojdbc8) | - |
| DB 로깅 | Log4jdbc-log4j2 | 1.16 |
| JSON/XML | Jackson (databind, dataformat-xml) | Spring Boot 관리 |
| 이미지 처리 | Thumbnailator | 0.4.8 |
| 메일 | Spring Boot Starter Mail | Spring Boot 관리 |
| OAuth | ScribeJava Core | 2.8.1 |
| 유틸리티 | Lombok | - |
| JSON 파싱 | JSON Simple | 1.1.1 |

## Frontend (fe_hotel)

| 분류 | 기술 | 버전 |
|------|------|------|
| Framework | Spring MVC | 5.0.7.RELEASE |
| Language | Java | 17 |
| View | JSP + JSTL | 1.2 |
| Servlet API | javax.servlet-api | 3.1.0 |
| JSON/XML | Jackson (databind, dataformat-xml) | 2.12.1 |
| HTTP 통신 | Spring RestTemplate | 5.0.7 |
| 유틸리티 | Lombok | 1.18.30 |

## Frontend 라이브러리 (CDN / 로컬)

| 라이브러리 | 버전 | 용도 |
|------------|------|------|
| jQuery | 3.6.0 | DOM 조작, AJAX |
| jQuery UI | 1.12.1 | Datepicker, Autocomplete |
| Bootstrap | 5 | 반응형 레이아웃, UI 컴포넌트 |
| Bootstrap Icons | 1.11.0 | 아이콘 |
| Font Awesome | 5.11.2 | 아이콘 |
| SweetAlert2 | v11 | 알림/확인 다이얼로그 |
| Google Fonts | Gowun Batang | 디스플레이 폰트 |

## 외부 API 연동

| 서비스 | 용도 |
|--------|------|
| Naver OAuth | 소셜 로그인 (ScribeJava) |
| Kakao Maps API | 지도 기반 숙소 검색/표시 |
| KakaoPay | 예약 결제 |
| Naver SMTP | 회원가입 이메일 인증 |

## 빌드 & 배포

| 도구 | 버전 | 용도 |
|------|------|------|
| Apache Maven | 3.9.6 | 빌드 도구 (프로젝트 내 번들) |
| Maven Compiler Plugin | 3.11.0 | Java 17 컴파일 |
| Maven War Plugin | 3.3.2 | WAR 패키징 (fe_hotel) |
| Tomcat | - | fe_hotel WAR 배포 (포트 8080) |
| Undertow | - | be_hotel 내장 서버 (포트 8081) |

## 디자인 시스템

| 항목 | 값 |
|------|-----|
| Primary Color | #E8985A |
| Primary Hover | #D4864A |
| Primary Light | #FDF5EF |
| 본문 폰트 | Pretendard, system fonts |
| 디스플레이 폰트 | Gowun Batang (serif) |
| CSS 구조 | variables.css (디자인 토큰) + style.css (공통) + 컴포넌트별 CSS |
