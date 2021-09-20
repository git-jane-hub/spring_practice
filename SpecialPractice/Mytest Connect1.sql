CREATE SEQUENCE spe_num;

CREATE TABLE spe_tbl(
    bno number(10, 0),
    title varchar2(200) not null,
    content varchar2(2000) not null,
    writer varchar2(50) not null,
    regdate date default sysdate,
    updatedate date default sysdate
);

ALTER TABLE spe_tbl ADD CONSTRAINT pk_spe PRIMARY KEY(bno);

INSERT INTO spe_tbl (bno, title, content, writer) 
VALUES (spe_num.nextval, 'testtitle', 'testcontent', 'testwriter');

COMMIT;

SELECT * FROM spe_tbl;


select sequence_name, min_value, max_value, increment_by, last_number from user_sequences;

SELECT SEQUENCE_NAME, CACHE_SIZE FROM USER_SEQUENCES WHERE SEQUENCE_NAME = 'SPE_NUM';

ALTER SEQUENCE SPE_NUM NOCACHE;