package com.spe.service;

import java.util.List;

import com.spe.domain.BoardVO;

public interface BoardService {
	public void register(BoardVO vo);
	
	public List<BoardVO> list();
	
	public BoardVO detail(Long bno);
	
	public void modify(BoardVO vo);
	
	public void remove(Long bno);
}
