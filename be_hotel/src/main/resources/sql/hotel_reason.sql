-- 이 숙박시설을 좋아하는 이유 테이블
CREATE TABLE hotel_reason (
    reasonNo      NUMBER PRIMARY KEY,
    hotelNo       NUMBER NOT NULL,
    reasonTitle   VARCHAR2(200) NOT NULL,
    reasonContent VARCHAR2(1000),
    reasonImage   VARCHAR2(500),
    regDate       DATE DEFAULT SYSDATE,
    CONSTRAINT fk_hotel_reason_hotel FOREIGN KEY (hotelNo)
        REFERENCES hotel(hotelNo) ON DELETE CASCADE
);

CREATE SEQUENCE hotel_reason_seq START WITH 1 INCREMENT BY 1 NOCACHE;
