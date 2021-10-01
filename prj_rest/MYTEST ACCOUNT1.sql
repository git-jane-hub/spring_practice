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