drop table review;
drop table hotel_image;
drop table admin;
drop table room_image;
drop table reservation;
drop table hotel_room;
drop table wishList;
drop table place;
drop table member;
drop table hotel;
--drop table realhotel;

drop sequence member_seq;
drop sequence hotel_seq;
drop sequence hotel_room_seq;
drop sequence review_seq;
drop sequence hotel_image_seq;
drop sequence room_image_seq;
drop sequence reservation_seq;
drop sequence wishList_seq;
drop sequence place_seq;
--drop sequence realhotel_seq;







--open api table

Create table realhotel (
    realhotelno INTEGER null, --진짜 호텔번호
    state VARCHAR2(300), --시군명
    realhotelname VARCHAR2(1000) null, --사업자명
    wstroom VARCHAR2(1000)  null, --양실수
    korroom VARCHAR2(1000)  null, --한실수
    roadaddr VARCHAR2(1000)  null, --소재지지번주소
    lotnoaddr VARCHAR2(1000)  null, --소재지도로명주소
    lat VARCHAR2(1000)  null, --wgs84위도
    logt VARCHAR2(1000)  null, --wgs84경도
    hotelcondition VARCHAR2 (300)
 );
 ALTER TABLE realhotel ADD CONSTRAINT PK_realhotel PRIMARY KEY (realhotelno);
create sequence realhotel_seq increment by 1 start with 1 minvalue 1 maxvalue 9999 nocycle nocache noorder;


-- 숙소
CREATE TABLE hotel (
	hotelNo         INTEGER        NULL, -- 숙소번호
    realhotelNo      INTEGER       null, -- api숙소 번호
	hotelName       VARCHAR2(1000) NULL, -- 숙소 이름
	mainAddress     VARCHAR2(30)   NULL, -- 대표주소
	address         VARCHAR2(500)  NULL, -- 상세주소
	hotelPhoneNo    VARCHAR2(100)  NULL, -- 대표전화번호 
    hotelRegistDate  DATE          default sysdate,  -- 등록날짜
    hotelFileName   VARCHAR2(200)   NULL ,      --파일이름
	buffet          CHARACTER(1)  default 'f',     -- 조식
	swim            CHARACTER(1)  default 'f',     -- 수영장
	golf            CHARACTER(1)  default 'f',     -- 골프장
	pet             CHARACTER(1)  default 'f',     -- 반려동물동반가능
	restaurant      CHARACTER(1)  default 'f',     -- 레스토랑
	fitness         CHARACTER(1)  default 'f',     -- 피트니스
	parking         CHARACTER(1)  default 'f',     -- 주차
	wifi            CHARACTER(1)  default 'f',     -- 와이파이
	kitchen         CHARACTER(1)  default 'f',     -- 주방
	smoke           CHARACTER(1)  default 'f'   -- 흡연실보유
	
    
    
);
create sequence hotel_seq start with 1 increment by 1 ;
ALTER TABLE hotel ADD CONSTRAINT PK_hotel PRIMARY KEY (hotelNo);
alter table hotel add constraint fk_hotel foreign key(realhotelNo) references realhotel(realhotelno);




-- 객실
CREATE TABLE hotel_room (
	roomNo         INTEGER       NULL, -- 객실ID
	hotelNo        INTEGER       NULL, -- 숙소번호
	roomName       VARCHAR2(50)  NULL, -- 객실 이름
	roomGuest      INTEGER       NULL, -- 이용인원 수
	roomPrice      VARCHAR2(100) NULL, -- 가격
	bedType        VARCHAR2(30)  NULL, -- 침대종류
	bedNo          VARCHAR2(100) NULL, -- 침대갯수
	infoRoom       VARCHAR2(1000) NULL, -- 그외정보
    checkInDate     DATE         NULL, --체크인 날짜
    checkOutDate    DATE         NULL, --체크아웃 날짜
	roomRegistDate  DATE        default sysdate  -- 등록날짜
);


create sequence hotel_room_seq start with 1 increment by 1 ;
ALTER TABLE hotel_room ADD CONSTRAINT PK_hotel_room PRIMARY KEY (roomNo);
alter table hotel_room add constraint FK_hotel_room foreign key(hotelNo) references hotel(hotelNo); 


-- 사용자
CREATE TABLE member (
	memberNo       INTEGER       NOT NULL, -- 사용자 번호
	memberId       VARCHAR2(30)  NOT NULL, -- 사용자 아이디
	memberPassword VARCHAR2(100) NOT NULL, -- 사용자 비밀번호
	memberName     VARCHAR2(20)  NOT NULL, -- 사용자 이름
	memberNickname VARCHAR2(20)  NOT NULL, -- 사용자 닉네임
	memberEmail    VARCHAR2(100) NULL,     -- 사용자 이메일
	memberPhoneNo  VARCHAR2(100) NULL,     -- 사용자 핸드폰 번호
	memberGender   CHARACTER(1)  NULL      -- 사용자 성별
);
create sequence member_seq start with 1 increment by 1 ;
ALTER TABLE member ADD CONSTRAINT PK_member PRIMARY KEY (memberNo);







-- 리뷰
CREATE TABLE review (
	reviewNo      INTEGER      NOT NULL, -- 리뷰ID
	memberNo        INTEGER    NULL,     -- 사용자 번호
	hotelNo       INTEGER      NOT NULL,     -- 숙소번호
	grade         number(2,1)  NOT NULL, -- 평점
	reviewContent VARCHAR2(500) NULL,     -- 리뷰내용
	report        CHARACTER(1) default 'f', -- 신고여부
	reviewDate     DATE        default sysdate      -- 리뷰등록날짜
);
create sequence review_seq start with 1 increment by 1 ;
ALTER TABLE review ADD CONSTRAINT PK_review PRIMARY KEY (reviewNo);
alter table review add constraint FK_review_hotel foreign key(hotelNo) references hotel(hotelNo);
alter table review add constraint FK_review_member foreign key(memberNo) references member(memberNo);




-- 관리자
CREATE TABLE admin (
	adminId       VARCHAR2(30)  NOT NULL, -- 관리자 아이디
	adminPassword VARCHAR2(100) NULL      -- 관리자 비밀번호
);
ALTER TABLE admin ADD CONSTRAINT PK_admin PRIMARY KEY (adminId);






-- 숙소이미지
CREATE TABLE hotel_image (
	hotelImageId  INTEGER       NULL, -- 숙소이미지번호
	hotelno       INTEGER       NULL, -- 숙소번호
	hotelFileName VARCHAR2(100)  NULL  -- 파일이름
);
create sequence hotel_image_seq start with 1 increment by 1 ;
ALTER TABLE hotel_image ADD CONSTRAINT PK_hotel_image PRIMARY KEY (hotelImageId);
alter table hotel_image add constraint fk_hotel_image foreign key(hotelNo) references hotel(hotelNo);
        
-- 객실이미지
CREATE TABLE room_image (
	roomImageId  INTEGER      NOT NULL, -- 객실이미지번호
    hotelno      INTEGER     NOT NULL, -- 객실ID  
	roomFileName VARCHAR2(300) NOT NULL  -- 파일이름
);
create sequence room_image_seq start with 1 increment by 1 ;
ALTER TABLE room_image ADD CONSTRAINT PK_room_image PRIMARY KEY (roomImageId);
alter table room_image add constraint fk_room_image foreign key(hotelno) references hotel(hotelno);

-- 예약현황
CREATE TABLE reservation(
	reservationNo INTEGER      NOT NULL, -- 예약번호
	memberNo      INTEGER      NOT NULL, -- 사용자 번호
    roomNo        INTEGER      NULL,      -- 객실ID
	realUser      VARCHAR2(20) NOT NULL, -- 투숙자
	checkInDate   DATE         NOT NULL, -- 체크인날짜
	checkOutDate  DATE         NOT NULL, -- 체크아웃날짜
	userAmount    INTEGER      NOT NULL, -- 인원수
    payment       VARCHAR2(50) NOT NULL --결제금액
);
create sequence reservation_seq start with 1 increment by 1 ;
ALTER TABLE reservation ADD CONSTRAINT PK_reservation PRIMARY KEY (reservationNo);
alter table reservation add constraint fk_order_user foreign key(memberNo) references member(memberNo);
alter table reservation add constraint fk_order_room foreign key(roomNo) references hotel_room(roomNo);

-- 찜한 숙소
CREATE TABLE wishList (
    wishListNo integer not null, --찜 번호
	memberNo  INTEGER NULL, -- 사용자 번호
	hotelNo INTEGER NULL  -- 숙소번호
);
create sequence wishList_seq start with 1 increment by 1 ;
ALTER TABLE wishList ADD CONSTRAINT PK_wishList PRIMARY KEY (wishListNo);
alter table wishList add constraint fk_wishList_member foreign key(memberNo) references member(memberNo);
alter table wishList add constraint fk_wishList_hotel foreign key(hotelNo) references hotel(hotelNo);

-- 주변시설
CREATE TABLE place (
	placeNo        INTEGER       NOT NULL, -- 시설번호
	placeName      VARCHAR2(100) NULL,     -- 시설이름
	placeAddress   VARCHAR2(500) NULL,     -- 주소
	placeOpenTime  VARCHAR2(50)  NULL,     -- 오픈시간
	placeCloseTime VARCHAR2(50)  NULL      -- 마감시간
);
create sequence place_seq start with 1 increment by 1 ;
ALTER TABLE place ADD CONSTRAINT PK_place PRIMARY KEY (placeNo);




--select t.* from (select i.hotelFileName,n.hotelname, r.grade,r.reviewContent, 
--r.reviewDate from hotel_image i, hotel n,review r where i.hotelNo = n.hotelNo and n.hotelNo=r.hotelNo order by r.grade desc) t where rownum<5;


----------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------(수원시)--------------------------------------------------------------------------------------------------------------

-----------------------------호텔명작프리미엄(1)-----------------------------------------------------------------------------------------
insert into hotel(hotelNo,realhotelno,hotelPhoneNo,hotelRegistDate,hotelFileName) values (hotel_seq.nextval,83,'010-3232-4234',sysdate,'/resources/hotel/file_repo/1/hotel1.jpg');
-------------------------------------------------------------------------------------------------------------------------------------------
insert into review(reviewNo,hotelno,grade,reviewContent,reviewDate) values(review_seq.nextval,1,3.5,'이호텔 아주 좋은것같아요!!!!',sysdate);


insert into hotel_room(roomNo,hotelno,bedno,roomprice,roomRegistDate) values (hotel_room_seq.nextval,1,3,'50,000',sysdate);

--------------드림팰리스(2)--------------------------------
insert into hotel(hotelNo,realhotelno,hotelPhoneNo,hotelRegistDate,hotelFileName) values (hotel_seq.nextval,85,'010-2311-2312',sysdate,'/resources/hotel/file_repo/1/hotel2.jpg');

insert into hotel_room(roomNo,hotelno,bedno,roomprice,roomRegistDate) values (hotel_room_seq.nextval,2,3,'65,000',sysdate);

insert into review(reviewNo,hotelno,grade,reviewContent,reviewDate) values(review_seq.nextval,2,4.5,'가족끼리 와서 좋은 시간보내고 가요~~',sysdate);

------유토피아호텔(3)---------------------------------------
insert into hotel(hotelNo,realhotelno,hotelPhoneNo,hotelRegistDate,hotelFileName) values (hotel_seq.nextval,97,'010-1322-5555',sysdate,'/resources/hotel/file_repo/1/hotel3.jpg');

insert into hotel_room(roomNo,roomName, hotelno,bedno,roomprice,roomRegistDate,checkInDate,checkOutDate,infoRoom,roomGuest,bedtype) values (hotel_room_seq.nextval,'Single Room',3,1,'35,000',sysdate,to_date('2022-07-23','yyyy-mm-dd'),to_date('2022-07-30','yyyy-mm-dd'),'주차, 커피,차, 무료 Wi-Fi, 식수/생수',2,'싱글사이즈');
insert into hotel_room(roomNo,roomName, hotelno,bedno,roomprice,roomRegistDate,checkInDate,checkOutDate,infoRoom,roomGuest,bedtype) values (hotel_room_seq.nextval,'double Room',3,2,'45,000',sysdate,to_date('2022-06-30','yyyy-mm-dd'),to_date('2022-07-05','yyyy-mm-dd'),'주차, 커피,차, 무료 Wi-Fi, 식수/생수',3,'퀸사이즈');

insert into review(reviewNo,hotelno,grade,reviewContent,reviewDate) values(review_seq.nextval,3,4,'좋은 시간 보내고 가요~~~',sysdate);
insert into review(reviewNo,memberNo,hotelno,grade,reviewContent,reviewDate) values(review_seq.nextval,1,3,4,'좋은 시간 보내고 가요~~~',sysdate);

----------------------------유토피아호텔 룸 사진-------------------------------------------------------------------
insert into room_image (roomImageId,hotelno,roomFileName) values(room_image_seq.nextval,3,'/resources/hotel/file_repo/3/수원유토피아모텔룸1.jpg');
insert into room_image (roomImageId,hotelno,roomFileName) values(room_image_seq.nextval,3,'/resources/hotel/file_repo/3/수원유토피아모텔룸2.jpg');
insert into room_image (roomImageId,hotelno,roomFileName) values(room_image_seq.nextval,3,'/resources/hotel/file_repo/3/수원유토피아모텔룸3.jpg');







---------------뉴엠호텔(New M----------------------------------------------
insert into hotel(hotelNo,realhotelno,hotelPhoneNo,hotelRegistDate,hotelFileName) values (hotel_seq.nextval,115,'010-1322-5555',sysdate,'/resources/hotel/file_repo/1/hotel4.jpg');
insert into hotel_room(roomNo,hotelno,bedno,roomprice,roomRegistDate) values (hotel_room_seq.nextval,4,3,'55,000',sysdate);

insert into review(reviewNo,hotelno,grade,reviewContent,reviewDate) values(review_seq.nextval,4,4,'반련강아지랑 가치 가서 와서 좋은 시간 보냈어요~~~',sysdate);



--------------------------------------------------(김포시)--------------------------------------------------------------------------------------------------------------
insert into hotel(hotelNo,realhotelno,hotelPhoneNo,hotelRegistDate,hotelFileName) values (hotel_seq.nextval,139,'010-2323-1212',sysdate,'/resources/hotel/file_repo/1/김포마리호텔.jpg');
insert into hotel_room(roomNo,hotelno,bedno,roomprice,roomRegistDate) values (hotel_room_seq.nextval,5,2,'57,000',sysdate);


insert into hotel(hotelNo,realhotelno,hotelPhoneNo,hotelRegistDate,hotelFileName) values (hotel_seq.nextval,152,'010-0513-2323',sysdate,'/resources/hotel/file_repo/1/김포루이호텔.jpg');
insert into hotel_room(roomNo,hotelno,bedno,roomprice,roomRegistDate) values (hotel_room_seq.nextval,6,2,'35,000',sysdate);


insert into hotel(hotelNo,realhotelno,hotelPhoneNo,hotelRegistDate,hotelFileName) values (hotel_seq.nextval,174,'010-0513-2323',sysdate,'/resources/hotel/file_repo/1/김포루브호텔.jpg');
insert into hotel_room(roomNo,hotelno,bedno,roomprice,roomRegistDate) values (hotel_room_seq.nextval,7,2,'35,000',sysdate);


insert into hotel(hotelNo,realhotelno,hotelPhoneNo,hotelRegistDate,hotelFileName) values (hotel_seq.nextval,51,'010-0513-2323',sysdate,'/resources/hotel/file_repo/1/김포체리호텔.jpg');
insert into hotel_room(roomNo,hotelno,bedno,roomprice,roomRegistDate) values (hotel_room_seq.nextval,8,3,'50,000',sysdate);



--------------------------------------------------(고양시)--------------------------------------------------------------------------------------------------------------

insert into hotel(hotelNo,realhotelno,hotelPhoneNo,hotelRegistDate,hotelFileName) values (hotel_seq.nextval,82,'010-0513-3123',sysdate,'/resources/hotel/file_repo/1/고양넘버25행신점.jpg');
insert into hotel_room(roomNo,hotelno,bedno,roomprice,roomRegistDate) values (hotel_room_seq.nextval,9,2,'65,000',sysdate);

insert into hotel(hotelNo,realhotelno,hotelPhoneNo,hotelRegistDate,hotelFileName) values (hotel_seq.nextval,92,'031-974-0008',sysdate,'/resources/hotel/file_repo/1/고양호텔사이버.jpg');
insert into hotel_room(roomNo,hotelno,bedno,roomprice,roomRegistDate) values (hotel_room_seq.nextval,10,1,'35,000',sysdate);


insert into hotel(hotelNo,realhotelno,hotelPhoneNo,hotelRegistDate,hotelFileName) values (hotel_seq.nextval,109,'031-974-0008',sysdate,'/resources/hotel/file_repo/1/고양마두라트리.jpg');
insert into hotel_room(roomNo,hotelno,bedno,roomprice,roomRegistDate) values (hotel_room_seq.nextval,11,2,'70,000',sysdate);





--------------------------------------------------(파주시)--------------------------------------------------------------------------------------------------------------
insert into hotel(hotelNo,realhotelno,hotelPhoneNo,hotelRegistDate,hotelFileName) values (hotel_seq.nextval,88,'031-974-0008',sysdate,'/resources/hotel/file_repo/1/파주호텔세띠앙.jpg');
insert into hotel_room(roomNo,hotelno,bedno,roomprice,roomRegistDate) values (hotel_room_seq.nextval,12,2,'65,000',sysdate);




    
    
 
select * from hotel_room;




commit;