package org.ict.mapper;

import org.ict.domain.PayVO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class PayMapperTest {
	
	@Autowired
	private PayMapper mapper;
	
	@Test
	public void testInsertPay() {
		PayVO vo = new PayVO();
		vo.setItemName("itemName");
		vo.setAmount(10000L);
		vo.setMerchant_uid("merchant_uid");
		
		mapper.insertPay(vo);
	}
}
