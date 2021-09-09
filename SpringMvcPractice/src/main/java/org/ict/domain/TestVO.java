package org.ict.domain;

import lombok.Data;

/* lombok을 이용하면 자동으로 getter, setter, toString 생성 가능
 * @Data 어노테이션을 클래스 위에 작성하면 자동 생성 - 좌측 Package Explorer에서 확인 가능 
 * @Getter @Setter @ToString으로 원하는 것만 생성할 수도 있음
 * 변수를 추가하면 자동으로 추가됨
 */
@Data
public class TestVO {
	private String name;
	private int age;
	private int level;
}
