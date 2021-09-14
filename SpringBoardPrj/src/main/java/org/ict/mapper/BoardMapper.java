package org.ict.mapper;



import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.ict.domain.BoardVO;

public interface BoardMapper {
	// @Select("SELECT * FROM board_tbl WHERE bno <= 3")	// SELECT * FROM board_tbl WHERE ROWNUM <= 3 ORDER BY bno
	public List<BoardVO> getList();
	
	// BoardVO를 매개로 insert 정보를 전달받음
	public void insert(BoardVO vo);
	
	public BoardVO getContent(Long bno);
}
