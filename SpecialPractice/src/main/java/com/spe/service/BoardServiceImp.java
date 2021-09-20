package com.spe.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spe.domain.BoardVO;
import com.spe.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class BoardServiceImp implements BoardService{

	@Autowired
	private BoardMapper mapper;
	
	@Override
	public void register(BoardVO vo) {
		log.info("게시글 등록 진행완료");
		mapper.insert(vo);
	}

	@Override
	public List<BoardVO> list() {
		log.info("게시글 전체 조회");
		return mapper.selectList();
	}

	@Override
	public BoardVO detail(Long bno) {
		log.info("게시글 하나 조회");
		return mapper.selectDetail(bno);
	}

	@Override
	public void modify(BoardVO vo) {
		log.info("게시글 수정완료");
		mapper.update(vo);
	}

	@Override
	public void remove(Long bno) {
		log.info("게시글 삭제완료");
		mapper.delete(bno);
	}
}
