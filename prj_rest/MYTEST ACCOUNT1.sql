CREATE TABLE reply_tbl(
    rno NUMBER(10, 0),
    bno NUMBER(10, 0) NOT NULL,
    reply VARCHAR2(1000) NOT NULL,
    replyer VARCHAR2(50) NOT NULL,
    replyDate DATE DEFAULT SYSDATE,
    updatedate DATE DEFAULT SYSDATE
);

CREATE SEQUENCE reply_num;

ALTER TABLE reply_tbl ADD CONSTRAINT pk_reply PRIMARY KEY(rno);

ALTER TABLE reply_tbl ADD CONSTRAINT fk_reply 
FOREIGN KEY (bno) REFERENCES board_tbl(bno);