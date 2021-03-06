/*
oracle은 auto_increment가 없으므로 board_num이라는 시퀀스를 만들면 처음에 0이 저장됨
이후 primary key 가 들어갈 자리에 board_num(시퀀스명).nextval이라고 기입하면
실행할 때마다 1씩 증가된 새로운 값을 그 위치에 넣어줌 
*/
CREATE SEQUENCE boardnum;

CREATE TABLE boardtbl(
    bno number(10, 0),
    title varchar2(200) not null,
    content varchar2(2000) not null,
    writer varchar2(50) not null,
    regdate date default sysdate,
    updatedate date default sysdate
);

ALTER TABLE boardtbl ADD CONSTRAINT pkboard PRIMARY KEY(bno);

INSERT INTO boardtbl (bno, title, content, writer) VALUES (board_num.nextval, 'title', 'content', 'writer');

SELECT * FROM boardtbl;

commit;

SELECT * FROM boardtbl where ROWNUM <= 3 ORDER BY bno;
SELECT content FROM boardtbl WHERE bno = 1;