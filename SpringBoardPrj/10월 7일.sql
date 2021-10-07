-- ����� ������ �Խñۿ� ǥ��
ALTER TABLE board_tbl ADD (replycount number DEFAULT 0);

-- ���� ����� ����ؼ� REPLYCOUNT�� �Է�
UPDATE board_tbl SET replycount = (SELECT COUNT(rno) FROM reply_tbl WHERE reply_tbl.bno = board_tbl.bno);
commit;

SELECT * FROM board_tbl ORDER BY bno DESC;
SELECT * FROM reply_tbl WHERE bno = 10781 order by rno desc;
SELECT * FROM board_tbl b FULL OUTER JOIN reply_tbl r ON b.bno = r.bno ORDER BY b.bno DESC;