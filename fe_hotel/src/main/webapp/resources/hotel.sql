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
    realhotelno INTEGER null, --��¥ ȣ�ڹ�ȣ
    state VARCHAR2(300), --�ñ���
    realhotelname VARCHAR2(1000) null, --����ڸ�
    wstroom VARCHAR2(1000)  null, --��Ǽ�
    korroom VARCHAR2(1000)  null, --�ѽǼ�
    roadaddr VARCHAR2(1000)  null, --�����������ּ�
    lotnoaddr VARCHAR2(1000)  null, --���������θ��ּ�
    lat VARCHAR2(1000)  null, --wgs84����
    logt VARCHAR2(1000)  null, --wgs84�浵
    hotelcondition VARCHAR2 (300)
 );
 ALTER TABLE realhotel ADD CONSTRAINT PK_realhotel PRIMARY KEY (realhotelno);
create sequence realhotel_seq increment by 1 start with 1 minvalue 1 maxvalue 9999 nocycle nocache noorder;


-- ����
CREATE TABLE hotel (
	hotelNo         INTEGER        NULL, -- ���ҹ�ȣ
    realhotelNo      INTEGER       null, -- api���� ��ȣ
	hotelName       VARCHAR2(1000) NULL, -- ���� �̸�
	mainAddress     VARCHAR2(30)   NULL, -- ��ǥ�ּ�
	address         VARCHAR2(500)  NULL, -- ���ּ�
	hotelPhoneNo    VARCHAR2(100)  NULL, -- ��ǥ��ȭ��ȣ 
    hotelRegistDate  DATE          default sysdate,  -- ��ϳ�¥
    hotelFileName   VARCHAR2(200)   NULL ,      --�����̸�
	buffet          CHARACTER(1)  default 'f',     -- ����
	swim            CHARACTER(1)  default 'f',     -- ������
	golf            CHARACTER(1)  default 'f',     -- ������
	pet             CHARACTER(1)  default 'f',     -- �ݷ��������ݰ���
	restaurant      CHARACTER(1)  default 'f',     -- �������
	fitness         CHARACTER(1)  default 'f',     -- ��Ʈ�Ͻ�
	parking         CHARACTER(1)  default 'f',     -- ����
	wifi            CHARACTER(1)  default 'f',     -- ��������
	kitchen         CHARACTER(1)  default 'f',     -- �ֹ�
	smoke           CHARACTER(1)  default 'f',   -- �����Ǻ���
	memberNo        INTEGER       NULL          -- ����ڹ�ȣ


);
create sequence hotel_seq start with 1 increment by 1 ;
ALTER TABLE hotel ADD CONSTRAINT PK_hotel PRIMARY KEY (hotelNo);
alter table hotel add constraint fk_hotel foreign key(realhotelNo) references realhotel(realhotelno);




-- ����
CREATE TABLE hotel_room (
	roomNo         INTEGER       NULL, -- ����ID
	hotelNo        INTEGER       NULL, -- ���ҹ�ȣ
	roomName       VARCHAR2(50)  NULL, -- ���� �̸�
	roomGuest      INTEGER       NULL, -- �̿��ο� ��
	roomPrice      VARCHAR2(100) NULL, -- ����
	bedType        VARCHAR2(30)  NULL, -- ħ������
	bedNo          VARCHAR2(100) NULL, -- ħ�밹��
	infoRoom       VARCHAR2(1000) NULL, -- �׿�����
    checkInDate     DATE         NULL, --üũ�� ��¥
    checkOutDate    DATE         NULL, --üũ�ƿ� ��¥
	roomRegistDate  DATE        default sysdate  -- ��ϳ�¥
);


create sequence hotel_room_seq start with 1 increment by 1 ;
ALTER TABLE hotel_room ADD CONSTRAINT PK_hotel_room PRIMARY KEY (roomNo);
alter table hotel_room add constraint FK_hotel_room foreign key(hotelNo) references hotel(hotelNo); 


-- �����
CREATE TABLE member (
	memberNo       INTEGER       NOT NULL, -- ����� ��ȣ
	memberId       VARCHAR2(30)  NOT NULL, -- ����� ���̵�
	memberPassword VARCHAR2(100) NOT NULL, -- ����� ��й�ȣ
	memberName     VARCHAR2(20)  NOT NULL, -- ����� �̸�
	memberNickname VARCHAR2(20)  NOT NULL, -- ����� �г���
	memberEmail    VARCHAR2(100) NULL,     -- ����� �̸���
	memberPhoneNo  VARCHAR2(100) NULL,     -- ����� �ڵ��� ��ȣ
	memberGender   CHARACTER(1)  NULL,     -- ����� ����
	memberRole     VARCHAR2(20)  DEFAULT 'USER',  -- ����: USER, ADMIN
	naverLogin     VARCHAR2(100) NULL             -- naver OAuth identifier
);
create sequence member_seq start with 1 increment by 1 ;
ALTER TABLE member ADD CONSTRAINT PK_member PRIMARY KEY (memberNo);







-- ����
CREATE TABLE review (
	reviewNo      INTEGER      NOT NULL, -- ����ID
	memberNo        INTEGER    NULL,     -- ����� ��ȣ
	hotelNo       INTEGER      NOT NULL,     -- ���ҹ�ȣ
	grade         number(2,1)  NOT NULL, -- ����
	reviewContent VARCHAR2(500) NULL,     -- ���䳻��
	report        CHARACTER(1) default 'f', -- �Ű�����
	reviewDate     DATE        default sysdate      -- �����ϳ�¥
);
create sequence review_seq start with 1 increment by 1 ;
ALTER TABLE review ADD CONSTRAINT PK_review PRIMARY KEY (reviewNo);
alter table review add constraint FK_review_hotel foreign key(hotelNo) references hotel(hotelNo);
alter table review add constraint FK_review_member foreign key(memberNo) references member(memberNo);




-- ������
CREATE TABLE admin (
	adminId       VARCHAR2(30)  NOT NULL, -- ������ ���̵�
	adminPassword VARCHAR2(100) NULL      -- ������ ��й�ȣ
);
ALTER TABLE admin ADD CONSTRAINT PK_admin PRIMARY KEY (adminId);






-- �����̹���
CREATE TABLE hotel_image (
	hotelImageId  INTEGER       NULL, -- �����̹�����ȣ
	hotelno       INTEGER       NULL, -- ���ҹ�ȣ
	hotelFileName VARCHAR2(100)  NULL  -- �����̸�
);
create sequence hotel_image_seq start with 1 increment by 1 ;
ALTER TABLE hotel_image ADD CONSTRAINT PK_hotel_image PRIMARY KEY (hotelImageId);
alter table hotel_image add constraint fk_hotel_image foreign key(hotelNo) references hotel(hotelNo);
        
-- �����̹���
CREATE TABLE room_image (
	roomImageId  INTEGER      NOT NULL, -- �����̹�����ȣ
    hotelno      INTEGER     NOT NULL, -- ����ID  
	roomFileName VARCHAR2(300) NOT NULL  -- �����̸�
);
create sequence room_image_seq start with 1 increment by 1 ;
ALTER TABLE room_image ADD CONSTRAINT PK_room_image PRIMARY KEY (roomImageId);
alter table room_image add constraint fk_room_image foreign key(hotelno) references hotel(hotelno);

-- ������Ȳ
CREATE TABLE reservation(
	reservationNo INTEGER      NOT NULL, -- �����ȣ
	memberNo      INTEGER      NOT NULL, -- ����� ��ȣ
    roomNo        INTEGER      NULL,      -- ����ID
	realUser      VARCHAR2(20) NOT NULL, -- ������
	checkInDate   DATE         NOT NULL, -- üũ�γ�¥
	checkOutDate  DATE         NOT NULL, -- üũ�ƿ���¥
	userAmount    INTEGER      NOT NULL, -- �ο���
    payment       VARCHAR2(50) NOT NULL --�����ݾ�
);
create sequence reservation_seq start with 1 increment by 1 ;
ALTER TABLE reservation ADD CONSTRAINT PK_reservation PRIMARY KEY (reservationNo);
alter table reservation add constraint fk_order_user foreign key(memberNo) references member(memberNo);
alter table reservation add constraint fk_order_room foreign key(roomNo) references hotel_room(roomNo);

-- ���� ����
CREATE TABLE wishList (
    wishListNo integer not null, --�� ��ȣ
	memberNo  INTEGER NULL, -- ����� ��ȣ
	hotelNo INTEGER NULL  -- ���ҹ�ȣ
);
create sequence wishList_seq start with 1 increment by 1 ;
ALTER TABLE wishList ADD CONSTRAINT PK_wishList PRIMARY KEY (wishListNo);
alter table wishList add constraint fk_wishList_member foreign key(memberNo) references member(memberNo);
alter table wishList add constraint fk_wishList_hotel foreign key(hotelNo) references hotel(hotelNo);

-- �ֺ��ü�
CREATE TABLE place (
	placeNo        INTEGER       NOT NULL, -- �ü���ȣ
	placeName      VARCHAR2(100) NULL,     -- �ü��̸�
	placeAddress   VARCHAR2(500) NULL,     -- �ּ�
	placeOpenTime  VARCHAR2(50)  NULL,     -- ���½ð�
	placeCloseTime VARCHAR2(50)  NULL      -- �����ð�
);
create sequence place_seq start with 1 increment by 1 ;
ALTER TABLE place ADD CONSTRAINT PK_place PRIMARY KEY (placeNo);




--select t.* from (select i.hotelFileName,n.hotelname, r.grade,r.reviewContent, 
--r.reviewDate from hotel_image i, hotel n,review r where i.hotelNo = n.hotelNo and n.hotelNo=r.hotelNo order by r.grade desc) t where rownum<5;


----------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------(������)--------------------------------------------------------------------------------------------------------------

-----------------------------ȣ�ڸ��������̾�(1)-----------------------------------------------------------------------------------------
insert into hotel(hotelNo,realhotelno,hotelPhoneNo,hotelRegistDate,hotelFileName) values (hotel_seq.nextval,83,'010-3232-4234',sysdate,'/resources/hotel/file_repo/1/hotel1.jpg');
-------------------------------------------------------------------------------------------------------------------------------------------
insert into review(reviewNo,hotelno,grade,reviewContent,reviewDate) values(review_seq.nextval,1,3.5,'��ȣ�� ���� �����Ͱ��ƿ�!!!!',sysdate);


insert into hotel_room(roomNo,hotelno,bedno,roomprice,roomRegistDate) values (hotel_room_seq.nextval,1,3,'50,000',sysdate);

--------------�帲�Ӹ���(2)--------------------------------
insert into hotel(hotelNo,realhotelno,hotelPhoneNo,hotelRegistDate,hotelFileName) values (hotel_seq.nextval,85,'010-2311-2312',sysdate,'/resources/hotel/file_repo/1/hotel2.jpg');

insert into hotel_room(roomNo,hotelno,bedno,roomprice,roomRegistDate) values (hotel_room_seq.nextval,2,3,'65,000',sysdate);

insert into review(reviewNo,hotelno,grade,reviewContent,reviewDate) values(review_seq.nextval,2,4.5,'�������� �ͼ� ���� �ð������� ����~~',sysdate);

------�����Ǿ�ȣ��(3)---------------------------------------
insert into hotel(hotelNo,realhotelno,hotelPhoneNo,hotelRegistDate,hotelFileName) values (hotel_seq.nextval,97,'010-1322-5555',sysdate,'/resources/hotel/file_repo/1/hotel3.jpg');

insert into hotel_room(roomNo,roomName, hotelno,bedno,roomprice,roomRegistDate,checkInDate,checkOutDate,infoRoom,roomGuest,bedtype) values (hotel_room_seq.nextval,'Single Room',3,1,'35,000',sysdate,to_date('2022-07-23','yyyy-mm-dd'),to_date('2022-07-30','yyyy-mm-dd'),'����, Ŀ��,��, ���� Wi-Fi, �ļ�/����',2,'�̱ۻ�����');
insert into hotel_room(roomNo,roomName, hotelno,bedno,roomprice,roomRegistDate,checkInDate,checkOutDate,infoRoom,roomGuest,bedtype) values (hotel_room_seq.nextval,'double Room',3,2,'45,000',sysdate,to_date('2022-06-30','yyyy-mm-dd'),to_date('2022-07-05','yyyy-mm-dd'),'����, Ŀ��,��, ���� Wi-Fi, �ļ�/����',3,'��������');

insert into review(reviewNo,hotelno,grade,reviewContent,reviewDate) values(review_seq.nextval,3,4,'���� �ð� ������ ����~~~',sysdate);
insert into review(reviewNo,memberNo,hotelno,grade,reviewContent,reviewDate) values(review_seq.nextval,1,3,4,'���� �ð� ������ ����~~~',sysdate);

----------------------------�����Ǿ�ȣ�� �� ����-------------------------------------------------------------------
insert into room_image (roomImageId,hotelno,roomFileName) values(room_image_seq.nextval,3,'/resources/hotel/file_repo/3/���������ǾƸ��ڷ�1.jpg');
insert into room_image (roomImageId,hotelno,roomFileName) values(room_image_seq.nextval,3,'/resources/hotel/file_repo/3/���������ǾƸ��ڷ�2.jpg');
insert into room_image (roomImageId,hotelno,roomFileName) values(room_image_seq.nextval,3,'/resources/hotel/file_repo/3/���������ǾƸ��ڷ�3.jpg');







---------------����ȣ��(New M----------------------------------------------
insert into hotel(hotelNo,realhotelno,hotelPhoneNo,hotelRegistDate,hotelFileName) values (hotel_seq.nextval,115,'010-1322-5555',sysdate,'/resources/hotel/file_repo/1/hotel4.jpg');
insert into hotel_room(roomNo,hotelno,bedno,roomprice,roomRegistDate) values (hotel_room_seq.nextval,4,3,'55,000',sysdate);

insert into review(reviewNo,hotelno,grade,reviewContent,reviewDate) values(review_seq.nextval,4,4,'�ݷð������� ��ġ ���� �ͼ� ���� �ð� ���¾��~~~',sysdate);



--------------------------------------------------(������)--------------------------------------------------------------------------------------------------------------
insert into hotel(hotelNo,realhotelno,hotelPhoneNo,hotelRegistDate,hotelFileName) values (hotel_seq.nextval,139,'010-2323-1212',sysdate,'/resources/hotel/file_repo/1/��������ȣ��.jpg');
insert into hotel_room(roomNo,hotelno,bedno,roomprice,roomRegistDate) values (hotel_room_seq.nextval,5,2,'57,000',sysdate);


insert into hotel(hotelNo,realhotelno,hotelPhoneNo,hotelRegistDate,hotelFileName) values (hotel_seq.nextval,152,'010-0513-2323',sysdate,'/resources/hotel/file_repo/1/��������ȣ��.jpg');
insert into hotel_room(roomNo,hotelno,bedno,roomprice,roomRegistDate) values (hotel_room_seq.nextval,6,2,'35,000',sysdate);


insert into hotel(hotelNo,realhotelno,hotelPhoneNo,hotelRegistDate,hotelFileName) values (hotel_seq.nextval,174,'010-0513-2323',sysdate,'/resources/hotel/file_repo/1/�������ȣ��.jpg');
insert into hotel_room(roomNo,hotelno,bedno,roomprice,roomRegistDate) values (hotel_room_seq.nextval,7,2,'35,000',sysdate);


insert into hotel(hotelNo,realhotelno,hotelPhoneNo,hotelRegistDate,hotelFileName) values (hotel_seq.nextval,51,'010-0513-2323',sysdate,'/resources/hotel/file_repo/1/����ü��ȣ��.jpg');
insert into hotel_room(roomNo,hotelno,bedno,roomprice,roomRegistDate) values (hotel_room_seq.nextval,8,3,'50,000',sysdate);



--------------------------------------------------(�����)--------------------------------------------------------------------------------------------------------------

insert into hotel(hotelNo,realhotelno,hotelPhoneNo,hotelRegistDate,hotelFileName) values (hotel_seq.nextval,82,'010-0513-3123',sysdate,'/resources/hotel/file_repo/1/����ѹ�25�����.jpg');
insert into hotel_room(roomNo,hotelno,bedno,roomprice,roomRegistDate) values (hotel_room_seq.nextval,9,2,'65,000',sysdate);

insert into hotel(hotelNo,realhotelno,hotelPhoneNo,hotelRegistDate,hotelFileName) values (hotel_seq.nextval,92,'031-974-0008',sysdate,'/resources/hotel/file_repo/1/����ȣ�ڻ��̹�.jpg');
insert into hotel_room(roomNo,hotelno,bedno,roomprice,roomRegistDate) values (hotel_room_seq.nextval,10,1,'35,000',sysdate);


insert into hotel(hotelNo,realhotelno,hotelPhoneNo,hotelRegistDate,hotelFileName) values (hotel_seq.nextval,109,'031-974-0008',sysdate,'/resources/hotel/file_repo/1/���縶�ζ�Ʈ��.jpg');
insert into hotel_room(roomNo,hotelno,bedno,roomprice,roomRegistDate) values (hotel_room_seq.nextval,11,2,'70,000',sysdate);





--------------------------------------------------(���ֽ�)--------------------------------------------------------------------------------------------------------------
insert into hotel(hotelNo,realhotelno,hotelPhoneNo,hotelRegistDate,hotelFileName) values (hotel_seq.nextval,88,'031-974-0008',sysdate,'/resources/hotel/file_repo/1/����ȣ�ڼ����.jpg');
insert into hotel_room(roomNo,hotelno,bedno,roomprice,roomRegistDate) values (hotel_room_seq.nextval,12,2,'65,000',sysdate);




    
    
 
select * from hotel_room;




commit;