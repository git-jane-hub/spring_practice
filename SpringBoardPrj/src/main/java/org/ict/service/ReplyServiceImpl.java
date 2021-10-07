package org.ict.service;

import java.util.List;

import org.ict.domain.ReplyVO;
import org.ict.mapper.BoardMapper;
import org.ict.mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ReplyServiceImpl implements ReplyService{
	/* 댓글이 작성되면 board_tbl의 replycount 값도 업데이트되어야하기 때문에
	 * 트랜잭션 대상이 되어야함
	 * board_tbl에 접근할 수 있도록 BoardMapper도 호출
	 */
	@Autowired
	private BoardMapper boardMapper;
	
	@Autowired
	private ReplyMapper mapper;
	
	@Override
	public List<ReplyVO> listReply(Long bno) {
		return mapper.getList(bno);
	}
	
	// mapper를 두 개 이상 호출하는 경우 작성해서 두개의 로직이 함께 적용되도록 함
	@Override
	@Transactional
	public void addReply(ReplyVO vo) {
		mapper.create(vo);
		// 댓글을 작성하고 나서 board_tbl에 해당 글번호에 댓글 개수 1증가
		boardMapper.updateReplyCount(vo.getBno(), 1L);
	}

	@Override
	public void modifyReply(ReplyVO vo) {
		mapper.update(vo);
	}

	@Override
	@Transactional
	public void removeReply(Long rno) {
		// 추가
		// 삭제된 댓글 번호로 글번호를 조회해서 변수에 저장
		Long bno = mapper.getBno(rno);
		
		// 기존에 있던 댓글을 삭제하는 로직
		mapper.delete(rno);
		
		// 추가
		// replycount를 -1 감소시킴
		boardMapper.updateReplyCount(bno, -1L);
	}

}
