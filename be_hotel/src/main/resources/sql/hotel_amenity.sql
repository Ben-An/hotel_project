-- 호텔 편의 시설/서비스 테이블
-- detail.jsp "인기 편의 시설/서비스" 및 "주요 편의 시설 및 서비스" 섹션 데이터 소스
CREATE TABLE hotel_amenity (
    amenityNo    NUMBER PRIMARY KEY,
    hotelNo      NUMBER NOT NULL,
    amenityName  VARCHAR2(100) NOT NULL,
    amenityIcon  VARCHAR2(100) NOT NULL,
    amenityType  VARCHAR2(20) DEFAULT 'POPULAR',
    amenityOrder NUMBER DEFAULT 0,
    regDate      DATE DEFAULT SYSDATE,
    CONSTRAINT fk_hotel_amenity_hotel FOREIGN KEY (hotelNo)
        REFERENCES hotel(hotelNo) ON DELETE CASCADE,
    CONSTRAINT ck_hotel_amenity_type CHECK (amenityType IN ('POPULAR', 'MAIN'))
);

CREATE SEQUENCE hotel_amenity_seq START WITH 1 INCREMENT BY 1 NOCACHE;

-- 기본 편의시설 데이터 시드 예시 (hotelNo=1 기준; 실제 호텔 ID 에 맞춰 수정)
-- POPULAR: detail.jsp 상단 섹션 (6개)
INSERT INTO hotel_amenity (amenityNo, hotelNo, amenityName, amenityIcon, amenityType, amenityOrder)
VALUES (hotel_amenity_seq.nextval, 1, '무료 WiFi', 'bi-wifi', 'POPULAR', 1);
INSERT INTO hotel_amenity (amenityNo, hotelNo, amenityName, amenityIcon, amenityType, amenityOrder)
VALUES (hotel_amenity_seq.nextval, 1, '에어컨', 'bi-snow', 'POPULAR', 2);
INSERT INTO hotel_amenity (amenityNo, hotelNo, amenityName, amenityIcon, amenityType, amenityOrder)
VALUES (hotel_amenity_seq.nextval, 1, '세탁 시설', 'bi-cup-hot', 'POPULAR', 3);
INSERT INTO hotel_amenity (amenityNo, hotelNo, amenityName, amenityIcon, amenityType, amenityOrder)
VALUES (hotel_amenity_seq.nextval, 1, '무료 주차', 'bi-p-circle', 'POPULAR', 4);
INSERT INTO hotel_amenity (amenityNo, hotelNo, amenityName, amenityIcon, amenityType, amenityOrder)
VALUES (hotel_amenity_seq.nextval, 1, '매일 24시간 운영 프론트데스크', 'bi-clock', 'POPULAR', 5);
INSERT INTO hotel_amenity (amenityNo, hotelNo, amenityName, amenityIcon, amenityType, amenityOrder)
VALUES (hotel_amenity_seq.nextval, 1, '금연', 'bi-shield-check', 'POPULAR', 6);

-- MAIN: detail.jsp "주요 편의 시설 및 서비스" 섹션
INSERT INTO hotel_amenity (amenityNo, hotelNo, amenityName, amenityIcon, amenityType, amenityOrder)
VALUES (hotel_amenity_seq.nextval, 1, '무료 WiFi', 'bi-check-lg', 'MAIN', 1);
INSERT INTO hotel_amenity (amenityNo, hotelNo, amenityName, amenityIcon, amenityType, amenityOrder)
VALUES (hotel_amenity_seq.nextval, 1, '여행 시설 가능', 'bi-check-lg', 'MAIN', 2);
INSERT INTO hotel_amenity (amenityNo, hotelNo, amenityName, amenityIcon, amenityType, amenityOrder)
VALUES (hotel_amenity_seq.nextval, 1, '무료 주차장', 'bi-check-lg', 'MAIN', 3);
INSERT INTO hotel_amenity (amenityNo, hotelNo, amenityName, amenityIcon, amenityType, amenityOrder)
VALUES (hotel_amenity_seq.nextval, 1, '비즈니스 센터', 'bi-check-lg', 'MAIN', 4);
INSERT INTO hotel_amenity (amenityNo, hotelNo, amenityName, amenityIcon, amenityType, amenityOrder)
VALUES (hotel_amenity_seq.nextval, 1, '6 개 회의실', 'bi-check-lg', 'MAIN', 5);
INSERT INTO hotel_amenity (amenityNo, hotelNo, amenityName, amenityIcon, amenityType, amenityOrder)
VALUES (hotel_amenity_seq.nextval, 1, '24시간 운영 프론트데스크', 'bi-check-lg', 'MAIN', 6);
INSERT INTO hotel_amenity (amenityNo, hotelNo, amenityName, amenityIcon, amenityType, amenityOrder)
VALUES (hotel_amenity_seq.nextval, 1, '에어컨', 'bi-check-lg', 'MAIN', 7);
INSERT INTO hotel_amenity (amenityNo, hotelNo, amenityName, amenityIcon, amenityType, amenityOrder)
VALUES (hotel_amenity_seq.nextval, 1, '매일 하우스키핑', 'bi-check-lg', 'MAIN', 8);
INSERT INTO hotel_amenity (amenityNo, hotelNo, amenityName, amenityIcon, amenityType, amenityOrder)
VALUES (hotel_amenity_seq.nextval, 1, '세탁 서비스', 'bi-check-lg', 'MAIN', 9);
INSERT INTO hotel_amenity (amenityNo, hotelNo, amenityName, amenityIcon, amenityType, amenityOrder)
VALUES (hotel_amenity_seq.nextval, 1, '룸 서비스, 에어컨 시설', 'bi-check-lg', 'MAIN', 10);
INSERT INTO hotel_amenity (amenityNo, hotelNo, amenityName, amenityIcon, amenityType, amenityOrder)
VALUES (hotel_amenity_seq.nextval, 1, '컨시어지 서비스', 'bi-check-lg', 'MAIN', 11);
INSERT INTO hotel_amenity (amenityNo, hotelNo, amenityName, amenityIcon, amenityType, amenityOrder)
VALUES (hotel_amenity_seq.nextval, 1, '드라이클리닝', 'bi-check-lg', 'MAIN', 12);

COMMIT;
