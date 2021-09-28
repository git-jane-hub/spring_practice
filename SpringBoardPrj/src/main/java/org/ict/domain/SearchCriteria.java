package org.ict.domain;

import lombok.Data;

// 검색기능과 페이징 처리를 함께 구현하기 위해 Criteria를 재사용하는 SearchCriteria
@Data
public class SearchCriteria extends Criteria{
	// Controller에서 아래 변수명으로 입력되는 파라미터값을 받을 수 있음
	private String searchType;
	private String keyword;
}
