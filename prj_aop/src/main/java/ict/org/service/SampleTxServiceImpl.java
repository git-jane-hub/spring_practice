package ict.org.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ict.org.mapper.Sample1Mapper;
import ict.org.mapper.Sample2Mapper;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class SampleTxServiceImpl implements SampleTxService{

	@Autowired
	private Sample1Mapper mapper1;
	
	@Autowired
	private Sample2Mapper mapper2;
	
	@Transactional
	@Override
	public void addData(String value) {
		/* 아래 두개의 실행문을 하나로 간주해서 데이터를 삽입하려고 함
		 * 두개의 실행문을 실행해서 
		 * 둘 다 데이터가 삽입되거나, 둘 다 데이터가 삽입되지 않거나 -> @Transactional
		 */
		log.info("mapper1........");
		mapper1.insertCol1(value);
		log.info("mapper2........");
		mapper2.insertCol2(value);
	}

}
