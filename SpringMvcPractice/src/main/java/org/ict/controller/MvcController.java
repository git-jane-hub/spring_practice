package org.ict.controller;

import java.text.DecimalFormat;

import org.ict.domain.TestVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

// 가장 먼저 할 일은 bean container에 삽입
@Controller
public class MvcController {
	
	// 기본 주소(localhost:8181)뒤에 "/goA"를 작성하면 goA() 메서드가 실행됨
	@RequestMapping(value="/goA")
	
	// return 타입이 String 인 경우 결과 페이지 지정 
	public String goA() {
		System.out.println("goA 주소 접속 감지");
		
		// 결과 페이지는 views 폴더 아래의 A.jsp(.jsp 를 생략하고 작성)
		return "A";
	}
	
	@RequestMapping(value="/goB")
	public String goB() {
		System.out.println("goB 주소 접속 감지");
		return "B";
	}
	
	@RequestMapping(value="/goC")
	// 주소 뒤 ?cNum=값 형태로 들어오는 값을 로직 내 cNum(int)으로 처리 - 파라미터 값을 작성하지 않으면 jsp 파일에 접근 불가 
	// Model model 파라미터를 작성해서 인자를 전달할 수 있도록 함
	public String goC(int cNum, Model model) {
		System.out.println("주소로 전달받은 값: " + cNum);
		
		// 파라미터 값 전달 
		model.addAttribute("cNum", cNum);

		return "C";
	}
	
	// RequestParam: 변수명과 받는 이름이 일치하지 않을 때 사용 
	@RequestMapping(value="/goD")
	// RequestParam("대체이름") - 작성한 변수명 대신 대체이름으로 받아옴 
	public String goD(@RequestParam("d")int dNum, Model model) {
		System.out.println("d 변수명으로 전달받는 값: " + dNum);
		model.addAttribute("dNum", dNum);
		return "D";
	}
	
	// ** 하나의 로직으로 작동된다는 것을 알려주기 위해 "/cToF"라는 같은 주소를 사용하며 접근 방식만 다르게 작성 **
	// form 에서 post 으로 제출했을 때만 결과 페이지로 이동되도록 설계 
	/* 섭씨를 입력받아 화씨로 변경 
	 * c(섭씨) = (f(화씨) - 32)/ 1.8
	 * f = (c * 1.8) + 32
	 */
	@RequestMapping(value="/cToF", method=RequestMethod.POST)
	public String cToF(int c, Model model) {
		System.out.println("입력받은 섭씨 " + c + ".C");
		double f = (c * 1.8) + 32;
		model.addAttribute("c", c);
		model.addAttribute("f", f);
		System.out.println("계산된 화씨 " + f + ".F");
		return "cToF";
	}
	
	// form 과 결과 페이지가 같은 주소를 공유하지만 접근방식을 다르게 작성
	@RequestMapping(value="/cToF", method=RequestMethod.GET)
	public String cToForm() {
		return "cToFForm";
	}
	
	// bmi = weight / (height ^ 2)
	@RequestMapping(value="/bmi", method=RequestMethod.POST)
	public String bmi(double height, int weight, Model model) {	// 파라미터 내부에 받는 변수명으로 .jsp 에 작성 
		System.out.println("입력받은 키: " + height + "입력받은 몸무게: " + weight);
		double bmi = (weight / ((height * 0.01) * (height * 0.01)));
		System.out.println("bmi: " + bmi);
		
		// 소수점 자리 지정 
		DecimalFormat form = new DecimalFormat("#.##");
		
		model.addAttribute("height", height);
		model.addAttribute("weight", weight);
		model.addAttribute("bmi", form.format(bmi));
		return "bmi";
	}
	
	@RequestMapping(value="/bmi", method=RequestMethod.GET)
	public String bmi() {
		return "bmiform";
	}
	
	/* @PathVariable 을 이용하면 url 패턴으로도 특정 파라미터 값을 받아올 수 있음
	 * Rest 방식으로 url 을 처리할 때 주로 사용하는 방식으로
	 *  /pathtest/숫자 중 숫자 위치에 온것은 page 값으로 간주 
	 */
	@RequestMapping(value="/pathtest/{page}")
	// int page 왼쪽에 @PathVariable을 작성 
	public String pathTest(@PathVariable int page, Model model) {
		model.addAttribute("page", page);
		return "path";
	}
	
	// @PathVariable 을 이용한 cToF
	@RequestMapping(value="/ctofpv/{cel}")
	public String ctofpv(@PathVariable int cel, Model model) {
		model.addAttribute("faren", (cel * 1.8) + 32);
		return "ctofpv";
	}
	
	/* void 타입은 return 구문을 사용할 수 없기 때문에
	 * view 파일의 이름을 'url패턴.jsp'으로 자동 지정됨 
	 * 간단한 작성은 void 타입을 이용하지만 메서드명에 제약이 생길 수 있기 때문에 잘 사용하지 않음 
	 */
	@RequestMapping(value="/voidreturn", method=RequestMethod.GET)
	public void voidTest(int something, Model model) {
		System.out.println("void 컨트롤러는 리턴구문이 필요 없음");
		model.addAttribute("something", something);
	}
	
	/* 원래 파라미터의 자료형이 int, String 등이였던 경우,
	 * 단일 자료형이였기 때문에 get, post 방식으로 전달되는 데이터를 자동으로 받아 처리 가능 
	 * TestVO 내부에는 int age, Stirng name이 있고 TestVO를 아래와 같이 선언하는 것 만으로도
	 * 내부에 있는 int age, String name을 선언하는 것과 같은 효과가 있음 
	 * 즉, ?age=(int)&name=(String)이라고 적는 데이터를 받아올 수 있음 
	 */
	@RequestMapping(value="/getVO")
	public String getVO(TestVO vo, Model model) {
		System.out.println("받아온 객체: " + vo);
		model.addAttribute("vo", vo);
		return "testvo/voview";
	}
}
