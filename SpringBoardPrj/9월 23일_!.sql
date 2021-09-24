SELECT bno,title, content, writer, regdate, updatedate FROM (SELECT /*+ INDEX_DESC(boar_tbl pk_board)*/ rownum, * FROM board_tbl WHERE rownum <= 20) WHERE rownum > 10;
-- �������� ���� �������� rownum �� ���� rownum�� �ƴ�
SELECT ROWNUM, bt.* FROM (SELECT /*+ INDEX_DESC(board_tbl pk_board)*/ ROWNUM, board_tbl.* FROM board_tbl WHERE ROWNUM <= 20) bt WHERE ROWNUM <=10;

-- ROWNUM �� NUM�̶�� �̸����� ��Ī�� �ٿ��ְ� ������������ bt��� ��Ī�� �ٿ��� ����, ���� �ڿ� where ��(where rn > 10)�� ������� ����� 
SELECT ROWNUM, bt.* FROM (SELECT /*+ INDEX_DESC(board_tbl pk_board)*/ ROWNUM rn, board_tbl.* FROM board_tbl WHERE ROWNUM <= 20) bt WHERE rn > 10;

-- �������� ���Ѽ��� ���� ���ϰ� rownum <= 20, �� ���� ������ 
SELECT /*+ INDEX_DESC(board_tbl pk_board)*/ ROWNUM rn, board_tbl.* FROM board_tbl WHERE ROWNUM <= 20;
