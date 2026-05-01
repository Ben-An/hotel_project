-- member 테이블에 네이버 OAuth 식별자 컬럼 추가
-- 원인: MemberMapper.xml 의 naverConnectionCheck / userNaverLoginPro / setNaverConnection
--       SQL 이 naverLogin 컬럼을 사용하지만 DDL 에 컬럼이 없어
--       ORA-00904: "NAVERLOGIN": 부적합한 식별자 발생.
ALTER TABLE member ADD (naverLogin VARCHAR2(100) NULL);

-- 롤백:
-- ALTER TABLE member DROP COLUMN naverLogin;
