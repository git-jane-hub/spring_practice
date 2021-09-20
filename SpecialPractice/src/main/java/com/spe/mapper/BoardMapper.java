package com.spe.mapper;

import java.util.List;

import com.spe.domain.BoardVO;

public interface BoardMapper {
	// 파라미터 값으로 BoardVO
	public void insert(BoardVO vo);
	
	public List<BoardVO> selectList();
	
	public BoardVO selectDetail(Long bno);
	
	// 파라미터 값으로 BoardVO
	public void update(BoardVO vo);
	
	public void delete(Long bno);
}
