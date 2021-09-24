/* 오라클 쿼리문의 HINT는 조회 시 index라고 불리는 특수한 주소값을 조회하도록 옵션을 변경하는 것
HINT 구문은 아래처럼 주석처럼 작성하되, 여는 부분에 + 를 추가로 작성 */ 
SELECT 
/*+ INDEX_DESC(board_tbl pk_board) */
* FROM board_tbl;

SELECT * FROM board_tbl ORDER BY bno DESC;

-- 기존에 존재하는 데이터를 2배씩 늘려서 삽입해주는 쿼리문
INSERT INTO board_tbl(bno, title, content, writer) (SELECT board_num.nextval, title, content, writer FROM board_tbl);

SELECT ROWNUM, ROWID, bno FROM board_tbl;

SELECT bno,title, content, writer, regdate, updatedate FROM (SELECT /*+ INDEX_DESC(boar_tbl pk_board)*/ rownum, * FROM board_tbl WHERE rownum <= 20) WHERE rownum > 10;

-- 쿼리문과 서브 쿼리문의 rownum 은 같은 rownum이 아님

SELECT ROWNUM, bt.* FROM (SELECT /*+ INDEX_DESC(board_tbl pk_board)*/ ROWNUM, board_tbl.* FROM board_tbl WHERE ROWNUM <= 20) bt WHERE ROWNUM <=10;

-- ROWNUM 을 NUM이라는 이름으로 별칭을 붙여주고 서브쿼리문을 bt라는 별칭을 붙여서 저장, 가장 뒤에 where 절(where rn > 10)이 가장먼저 실행됨 

SELECT ROWNUM, bt.* FROM (SELECT /*+ INDEX_DESC(board_tbl pk_board)*/ ROWNUM rn, board_tbl.* FROM board_tbl WHERE ROWNUM <= 20) bt WHERE rn > 10;

-- 데이터의 상한선을 먼저 정하고 rownum <= 20, 그 범위 내에서 

SELECT /*+ INDEX_DESC(board_tbl pk_board)*/ ROWNUM rn, board_tbl.* FROM board_tbl WHERE ROWNUM <= 20;

/*복습*/
SELECT * FROM (SELECT ROWNUM AS rn, bt.* FROM (SELECT * FROM board_tbl ORDER BY bno DESC) bt WHERE ROWNUM <= 10) WHERE rn > 0;
SELECT * FROM (SELECT ROWNUM AS rn, bt.* FROM (SELECT * FROM board_tbl ORDER BY bno DESC) bt WHERE ROWNUM <= 10+10) WHERE rn > 10;
SELECT * FROM board_tbl ORDER BY bno DESC;

COMMIT;