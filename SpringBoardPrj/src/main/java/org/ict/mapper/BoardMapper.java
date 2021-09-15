package org.ict.mapper;



import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.ict.domain.BoardVO;
// 메서드 이름과 용도에 따른 리턴자료형만 작성
public interface BoardMapper {
	/* @Select("SELECT * FROM board_tbl WHERE bno <= 3")
	 * SELECT * FROM board_tbl WHERE ROWNUM <= 3 ORDER BY bno
	 * 어노테이션을 작성하는 경우, xml 파일에는 작성하면 안됨 - 어느쪽을 실행할지 판단하지 못함
	 */
	// select 구문에서만 리턴타입 작성
	public List<BoardVO> getList();
	
	// BoardVO를 매개로 insert 정보를 전달받음
	public void insert(BoardVO vo);
	
	public BoardVO getContent(Long bno);
	
	public void delete(Long bno);
	
	public void update(BoardVO vo);
}
