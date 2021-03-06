package org.ict.service;

import java.util.List;

import org.ict.domain.BoardAttachVO;
import org.ict.domain.BoardVO;
import org.ict.domain.Criteria;
import org.ict.domain.SearchCriteria;
import org.ict.mapper.BoardAttachMapper;
import org.ict.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

// @Log4j x가 뜨면 pom.xml - log4j에서 version 업그레이드, exclusions, scope 삭제
@Log4j				// 로깅
@Service			// 의존성 등록
@AllArgsConstructor	// 서비스 생성자 자동생성
// BoardServiceImpl은 BoardService 인터페이스 구현
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardMapper mapper;
	
	@Autowired
	private BoardAttachMapper attachMapper;

	@Transactional
	// 등록 작업시 BoardVO를 매개로 실행하기 때문에 아래와 같이 BoardVO를 파라미터에 설정
	@Override
	public void register(BoardVO vo) {
		log.info("등록 작업 실행");
		//mapper.insert(vo);
		mapper.insertSelectKey(vo);
		
		// 첨부파일이 존재하지 않는다면 해당 메서드를 종료시킴
		if(vo.getAttachList() == null || vo.getAttachList().size() <= 0) {
			return;
		}
		
		// 파일정보도 게시글 등록과 함께 하도록 설정
		vo.getAttachList().forEach(attach -> {
			// 첨부파일이 위치할 글 번호를 가져와 입력
			attach.setBno(vo.getBno());
			attachMapper.insert(attach);
		});
	}

	// 특정 게시글 하나만 가져오는 로직이기 때문에 리턴자료형이 BoardVO
	@Override
	public BoardVO get(Long bno) {
		log.info("특정 글 조회");
		return mapper.getContent(bno);
	}

	@Override
	public void modify(BoardVO vo) {
		log.info("수정 작업 실행");
		mapper.update(vo);
	}

	@Override
	// 글이 삭제되면 댓글이 함께 삭제되는 로직 추가하기 + @Transactional
	public void remove(Long bno) {
		log.info("삭제 작업 실행");
		mapper.delete(bno);
	}

	@Override
	public List<BoardVO> getList(String keyword) {
		/* List<BoardVO> boardList = mapper.getList();
		 * return boardList;
		 */
		log.info("전체 목록 조회");
		return mapper.getList(keyword);
	}

	@Override
	public List<BoardVO> getListPaging(SearchCriteria cri) {
		/* cri의 정보(pageNum, amount)를 받아오면 해당 정보를 이용해 mapper의 getPagingList를 호출
		 * 나온 결과물을 리턴해 컨트롤러에서 사용할 수 있도록 처리
		 */
		return mapper.getListPaging(cri);
	}

	@Override
	public int getCountList(SearchCriteria cri) {
		return mapper.getCountList(cri);
	}

	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		return attachMapper.findByBno(bno);
	}


	
}
