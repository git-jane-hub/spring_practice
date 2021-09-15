/*
oracle�� auto_increment�� �����Ƿ� board_num�̶�� �������� ����� ó���� 0�� �����
���� primary key �� �� �ڸ��� board_num(��������).nextval�̶�� �����ϸ�
������ ������ 1�� ������ ���ο� ���� �� ��ġ�� �־��� 
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