package org.ict.domain;

import lombok.Getter;
import lombok.ToString;
import lombok.Setter;

@Getter
@Setter
@ToString
public class Criteria {
	// 페이지 번호와 페이지당 몇 개의 글을 보여줄지 지정하고, 이를 이용해 나머지 정보를 계산
	private int pageNum;
	private int amount;

	// 생성자 오버로딩 - 들어온 페이지 정보가 없다면 1페이지, 10개 게시물을 기본값으로 지정
	public Criteria() {
		this(1, 10);
	}
	
	// 들어온 페이지 정보가 있다면 해당 정보를 기반으로 수치를 지정
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
}
