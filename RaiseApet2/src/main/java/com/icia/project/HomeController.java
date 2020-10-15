package com.icia.project;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.icia.project.api.KakaoApi;
import com.icia.project.dto.MemberDTO;

@Controller
public class HomeController {
	
	@Autowired
	HttpSession session;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	// 시작페이지
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String Index() {
		
		return "Index";
	}
	
	// MemberJoin(회원가입).jsp로 이동
	@RequestMapping(value="/memberJoinForm", method=RequestMethod.GET)
	public String MemberJoinForm() {
		
		return "MemberJoinForm";
	}
	
	// MemberLogin(로그인).jsp로 이동
	@RequestMapping(value="/memberLoginForm", method=RequestMethod.GET)
	public String MemberLoginForm() {
		
		return "MemberLoginForm";
	}
	
	// MemberFind(아이디/비밀번호 찾기).jsp로 이동
	@RequestMapping(value="/memberFindForm", method=RequestMethod.GET)
	public String MemberFindForm() {
		
		return "MemberFindForm";
	}
	
	// MemberModify(회원수정).jsp로 이동
	@RequestMapping(value="/memberModifyForm", method=RequestMethod.GET)
	public String MemberModify() {
		
		return "MemberModifyForm";
	}
	
	// MemberMyPage(마이페이지).jsp로 이동
	@RequestMapping(value="/memberMyPage", method=RequestMethod.GET)
	public String MemberMyPage(@ModelAttribute MemberDTO member) {
		
		return "MemberMyPage";
	}
	
	// Index(메인).jsp로 이동
	@RequestMapping(value="/indexForm")
	public String IndexForm() {
		
		return "Index";
	}
}
