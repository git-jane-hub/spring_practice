/*
oracle�� auto_increment�� �����Ƿ� board_num�̶�� �������� ����� ó���� 0�� �����
���� primary key �� �� �ڸ��� board_num(��������).nextval�̶�� �����ϸ�
������ ������ 1�� ������ ���ο� ���� �� ��ġ�� �־��� 
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

SELECT * FROM board_tbl;

commit;

SELECT * FROM board_tbl where ROWNUM <= 3 ORDER BY bno;
SELECT content FROM board_tbl WHERE bno = 1;