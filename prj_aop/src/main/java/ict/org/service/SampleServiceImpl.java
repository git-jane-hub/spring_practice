package ict.org.service;

import org.springframework.stereotype.Service;

@Service// 구현체를 빈컨테이너에 넣어야함
public class SampleServiceImpl implements SampleService{

	@Override
	public Integer doAdd(String str1, String str2) throws Exception {
		return Integer.parseInt(str1) + Integer.parseInt(str2);
	}

	@Override
	public void introduce() {
		System.out.println("hello iam jane");
		
	}

}
