package org.ict.service;

import java.util.List;

import org.ict.domain.BoardVO;
import org.ict.domain.Criteria;

/* 서비스 계층은 하나의 동작을 담당
 * mapper 계층에서 하나의 메서드가 1개의 쿼리문만 담당했는데
 * service 계층은 하나의 메서드가 2개 이상의 쿼리문을 담당할 수도 있으며
 * 메서드 1개가 사용자 입장에서의 1개의 동작단위를 담당
 * (service는 mapper를 조합하여 하나의 기능을 실행하도록 작성)
 */
public interface BoardService {
	// 사용자의 동작단위를 기술
	// 글 등록(INSERT - DB에서 가져오지 않음 리턴:void)
	public void register(BoardVO vo);

	// 글 조회(SELECT - DB에서 조회하기 때문에 리턴:BoardVO - 하나의글)
	public BoardVO get(Long bno);
	
	// 글 수정(UPDATE - DB에서 가져오지 않음 리턴:void)
	public void modify(BoardVO vo);
	
	// 글 삭제(DELETE - DB에서 가져오지 않음 리턴:void)
	public void remove(Long bno);
	
	// 전체 글 목록(SELECT - DB에서 조회하기 때문에 리턴:List<BoardVO> - 전체글)
	public List<BoardVO> getList(String keyword);
	
	// 전체 글 목록(페이징 처리)
	public List<BoardVO> getPagingList(Criteria cri);
}
