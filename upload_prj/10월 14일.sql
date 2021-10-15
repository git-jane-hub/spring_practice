CREATE TABLE img_tbl(
    uuid VARCHAR2(100) NOT NULL,
    uploadPath VARCHAR2(200) NOT NULL,
    fileName VARCHAR2(100) NOT NULL,
    image CHAR(1) DEFAULT 'I',
    bno NUMBER(10, 0)
);

ALTER TABLE img_tbl ADD CONSTRAINT pk_img PRIMARY KEY (uuid);
ALTER TABLE img_tbl ADD CONSTRAINT fk_board_img FOREIGN KEY (bno) REFERENCES board_tbl(bno);

SELECT b.title, b.content, b.writer, b.regdate, b.updatedate, 
i.bno, i.uuid, i.uploadPath, i.fileName, i.image FROM board_tbl b 
FULL OUTER JOIN img_tbl i ON b.bno = i.bno ORDER BY b.bno DESC;
