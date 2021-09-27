package org.ict.domain;
/* Data Transfer Object - 데이터 전달 객체
 * VO DTO 둘 다 특정 데이터를 한 변수에 묶어 보내기 위해 사용
 * VO: DB에서 바로 꺼낸 데이터를 매칭
 * DTO: DB에 있는 정보를 토대로 가공한 데이터를 전달할 때 사용
 */
import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	// 페이지네이션 버튼 개수
	private int btnNum;
	// 페이지 세트중 시작 번호
	private int startPage;
	// 페이지 세트중 마지막 번호 
	private int endPage;
	// 이전, 이후 버튼 유무 
	private boolean prev, next;
	// 전체 게시글 개수
	private int total;
	// 페이지, 글 정보
	private Criteria cri;
	
	// 위 변수의 정보들을 자동을 가공하기 위한 생성자
	// btnNum - 페이지네이션 버튼 개수는 10개
	public PageDTO(Criteria cri, int total, int btnNum) {
		this.cri = cri;
		this.total = total;
		this.btnNum = btnNum;
		
		// 마지막 번호: 현재 페이지를 btnNum(실수)로 나누고 다시 곱한 결과물을 올림을 해서 btnNum을 다시 곱함
		this.endPage = (int)(Math.ceil(cri.getPageNum() / (double)this.btnNum) * this.btnNum);
		
		
		// 시작 번호: 마지막 번호를 토대로 시작 번호를 구함
		this.startPage = this.endPage - this.btnNum + 1;
		
		// 시작 번호가 구해지고 나서 마지막 번호를 구해야 시작번호가 1로 시작할 수 있음 
		// 마지막 번호가 실제 게시글보다 많이 나올 수 있기 때문에 실제 게시글에 맞춰 페이지네이션 버튼 개수를 맞춰주기 위한 로직
		int realEnd = (int)(Math.ceil((total * 1.0) / cri.getAmount()));
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		// 이전으로 가는 버튼은 시작 번호가 1만 아니면 나타나도록 작성
		this.prev = this.startPage == 1 ? false : true;
		
		// 다음으로 가는 버튼은 마지막번호가 실제 마지막번호보다 작을 때만 나타나도록 작성
		this.next = this.endPage < realEnd;
	}
}
