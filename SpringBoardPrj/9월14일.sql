/*
oracle은 auto_increment가 없으므로 board_num이라는 시퀀스를 만들면 처음에 0이 저장됨
이후 primary key 가 들어갈 자리에 board_num(시퀀스명).nextval이라고 기입하면
실행할 때마다 1씩 증가된 새로운 값을 그 위치에 넣어줌 
*/
CREATE SEQUENCE board_num;

CREATE TABLE board_tbl(
    bno number(10, 0),
    title varchar2(200) not null,
    content varchar2(2000) not null,
    writer varchar2(50) not null,
    regdate date default sysdate,
    updatedate date default sysdate
);

ALTER TABLE board_tbl ADD CONSTRAINT pk_board PRIMARY KEY(bno);

INSERT INTO board_tbl (bno, title, content, writer) VALUES (board_num.nextval, 'testtitle', 'testcontent', 'testwriter');

SELECT * FROM board_tbl ORDER BY bno DESC;
SELECT ROWNUM, bno, title FROM board_tbl;
commit; /* ���๮ �����ϰ� Ŀ���ؾ� �ݿ��� */

SELECT * FROM board_tbl where ROWNUM <= 3 ORDER BY bno;
SELECT content FROM board_tbl WHERE bno = 1;
UPDATE board_tbl SET title='UPDATE', content='UPDATE', writer='UPDATE', updatedate=SYSDATE WHERE bno=2;

CREATE TABLE reply_tbl(
    rno NUMBER(10, 0),
    bno NUMBER(10, 0) NOT NULL,
    reply VARCHAR2(1000) NOT NULL,
    replyer VARCHAR2(50) NOT NULL,
    replyDate DATE DEFAULT SYSDATE,
    updatedate DATE DEFAULT SYSDATE
);

SELECT * FROM board_tbl;
SELECT * FROM reply_tbl;
SELECT b.bno, b.title, b.content, b.writer, b.regdate, b.updatedate, r.rno, r.reply, r.replyer, r.replydate, r.updatedate 
FROM reply_tbl r FULL OUTER JOIN board_tbl b 
ON b.bno = r.bno ORDER BY b.bno DESC;

CREATE SEQUENCE reply_num;

ALTER TABLE reply_tbl ADD CONSTRAINT pk_reply PRIMARY KEY(rno);

ALTER TABLE reply_tbl ADD CONSTRAINT fk_reply 
FOREIGN KEY (bno) REFERENCES board_tbl(bno);
