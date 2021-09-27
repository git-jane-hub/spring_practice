package org.ict.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.ict.domain.BoardVO;
import org.ict.domain.Criteria;
// 메서드 이름과 용도에 따른 리턴자료형만 작성
public interface BoardMapper {
	// BoardVO를 매개로 insert 정보를 전달받음
	public void insert(BoardVO vo);
	
	// 등록한 게시글의 bno를 알 수 있는 로직
	public void insertSelectKey(BoardVO vo);
	
	public BoardVO getContent(Long bno);
	
	public void update(BoardVO vo);
	
	public void delete(Long bno);
	
	/* @Select("SELECT * FROM board_tbl WHERE bno <= 3")
	 * SELECT * FROM board_tbl WHERE ROWNUM <= 3 ORDER BY bno
	 * 어노테이션을 작성하는 경우, xml 파일에는 작성하면 안됨 - 어느쪽을 실행할지 판단하지 못함
	 */
	// select 구문에서만 리턴타입 작성
	public List<BoardVO> getList(String keyword);
	
	// 페이징 처리가 된 글목록을 조회해야하기 때문에 Criteria 정보를 파라미터로 제공해야함
	// - 몇 페이지의 글을 조회할 지 정보를 같이 쿼리문에 전송 가능
	public List<BoardVO> getListPaging(Criteria cri);
}
