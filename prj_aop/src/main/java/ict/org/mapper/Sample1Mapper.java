package ict.org.mapper;

import org.apache.ibatis.annotations.Insert;

public interface Sample1Mapper {
	// mapper.xml을 작성하지 않고 어노테이션으로 구문 작성
	@Insert("INSERT INTO tbl_test1(col1) VALUES (#{data})")
	public int insertCol1(String data);
}
