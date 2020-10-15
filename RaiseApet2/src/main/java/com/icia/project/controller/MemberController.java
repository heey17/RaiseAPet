package com.icia.project.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.PasswordAuthentication;
import java.util.HashMap;
import java.util.Properties;

import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.apache.catalina.User;
import org.codehaus.jackson.JsonNode;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.icia.project.api.KakaoApi;
import com.icia.project.api.NaverJoinApi;
import com.icia.project.api.NaverLoginApi;
import com.icia.project.dto.MemberDTO;
import com.icia.project.service.MemberService;
import com.icia.project.service.UserMailSendService;

import oracle.jdbc.driver.Message;

@Controller
public class MemberController {

	@Autowired
	MemberService mSvc;
	
	@Autowired
	HttpSession session;
	
	ModelAndView mav = new ModelAndView();
	
	@Autowired
	private NaverLoginApi naverLoginApi;
	
	@Autowired
	private NaverJoinApi naverJoinApi;
	
	private String apiResult;
	
	@Autowired
	private UserMailSendService mailsender;
	
	// 아이디 중복검사
	@RequestMapping(value="/idoverlap")
	public @ResponseBody String IdOverlap(@RequestParam("userId") String userId) {
		// @ResponseBody : ajax 받아오기 위해서 설정함.
		
		String resultMsg = mSvc.idOverlap(userId);
		
		return resultMsg;
	}
	
	// 전화번호 중복검사
	@RequestMapping(value="/phoneoverlap")
	public @ResponseBody String PhoneOverlap(@RequestParam("userPhone") String userPhone) {
		// @ResponseBody : ajax 받아오기 위해서 설정함.
		
		String resultMsg = mSvc.phoneOverlap(userPhone);
		
		return resultMsg;
	}
	
	// 이메일 중복검사
	@RequestMapping(value="/emailoverlap")
	public @ResponseBody String Emailoverlap(@RequestParam("userEmail") String userEmail) {
		// @ResponseBody : ajax 받아오기 위해서 설정함.
		
		String resultMsg = mSvc.emailoverlap(userEmail);
		
		return resultMsg;
	}
	
	// 비밀번호 확인(수정)
	@RequestMapping(value="/modifyPwCheck", method=RequestMethod.POST)
	public @ResponseBody String ModifyPwCheck(@RequestParam("passConfirm") String passConfirm) {
		// @ResponseBody : ajax 받아오기 위해 설정함.
		
		String resultMsg = mSvc.pwCheck(passConfirm);
		// pwCheck라는 method명을 가진 service로 보내는 이유는 탈퇴와 하는 동작이 같기 때문에
		
		return resultMsg;
	}
	
	// 비밀번호 확인(탈퇴)
	@RequestMapping(value="/deletePwCheck", method=RequestMethod.POST)
	public @ResponseBody String DeletePwCheck(@RequestParam("passConfirm") String passConfirm) {
		// @ResponseBody : ajax 받아오기 위해 설정함.
		
		String resultMsg = mSvc.pwCheck(passConfirm);
		// pwCheck라는 method명을 가진 service로 보내는 이유는 탈퇴와 하는 동작이 같기 때문에
		
		return resultMsg;
	}
	
	// 일반 회원가입
	@RequestMapping(value="/memberJoin")
	public ModelAndView MemberJoin(@ModelAttribute MemberDTO member, HttpServletRequest request) throws IllegalStateException, IOException {
		
		mav = mSvc.memberJoin(member);
		
		mailsender.mailSendWithUserKey(member.getUserEmail(), member.getUserId(), request);
		// 회원가입 후 메일 발송을 위한 메소드
		
		return mav;
	}
	
	// 이메일 재발송
	@RequestMapping(value="/emailAgainSend")
	public ModelAndView EmailAgainSend(HttpServletRequest request) throws IllegalStateException, IOException{
		
		MemberDTO member = (MemberDTO) session.getAttribute("emailAgainSend");
		
		String userId = member.getUserId();
		String userEmail = member.getUserEmail();
		// 로그인 service에서 * 값을 select 해서 본인인증이 안되었을 경우 emailAgainSend session에 저장하였기 때문에 따로 db 갈 필요 없이 Controller에서 설정했다.
		
		mailsender.mailSendWithUserKey(userEmail, userId, request);
		// 본인인증이 안된 회원이 로그인을 했을 경우 -> 메일 재발송을 눌렀을 때 -> 메일 발송을 해주기 위한 메소드
		
		mav.setViewName("Index");
		
		return mav;
	}
	
	// 비밀번호 찾기 이메일 발송
	@RequestMapping(value="/pwFindEmail")
	public ModelAndView PwFindEmail(HttpServletRequest request) throws IllegalStateException, IOException{

		String userEmail = (String) session.getAttribute("userPwFindEmail");
		System.out.println("userPwFindEmail : " + userEmail);
		
		mailsender.mailSend(userEmail);
		
		return mav;
	}
	
	// 비밀번호 찾기 인증번 호 같은 지 확인
	@RequestMapping(value="/keyConfirm")
	public @ResponseBody String KeyConfirm(@RequestParam("key") String key, @RequestParam("keyConfirm") String keyConfirm) {
		
		String resultMsg = mSvc.keyConfirm(key, keyConfirm);
		
		return resultMsg;
	}
	
	// email 인증 컨트롤러
	@RequestMapping(value="/user/key_alter", method=RequestMethod.GET)
	public String key_alterConfirm(@RequestParam("userId") String userId, @RequestParam("key") String key) {
		
		mailsender.alter_userKey_service(userId, key); // mailsender의 경우 @Autowired
		
		
		
		 
		
		return "regSuccess";
		// regSuccess.jsp로 이동
	}
	
	// 일반 로그인
	@RequestMapping(value="/memberLogin")
	public ModelAndView MemberLogin(@ModelAttribute MemberDTO member) {
		
		mav = mSvc.memberLogin(member);
		
		return mav;
	}
	
	// 아이디 찾기
	@RequestMapping(value="/idfindoverlap")
	public @ResponseBody String IdFindOverlap(@RequestParam("userName") String userName, @RequestParam("userEmail") String userEmail) {
		
		String resultMsg = mSvc.idFindOverlap(userName, userEmail);
		
		return resultMsg;
	}
	
	// 비밀번호 찾기
	@RequestMapping(value="/pwfindoverlap")
	public @ResponseBody String PwFindOverlap(@RequestParam("userName") String userName, @RequestParam("userId") String userId, @RequestParam("userEmail") String userEmail) throws IllegalStateException, IOException{
		
		String resultMsg = mSvc.pwFindOverlap(userName, userId, userEmail);
		System.out.println("resultMsg : " + resultMsg);
		
		return resultMsg;
	}
	
	// 네이버 아이디로 회원가입
	@RequestMapping(value="/naverjoin")
	public ModelAndView naverJoin() {
		
		String naverUrl = naverJoinApi.getAuthorizationUrl(session);
		
		mav.addObject("naverurl", naverUrl);
		mav.setViewName("NaverLogin");
		
		return mav;
	}
	
	// 네이버 회원가입 할 때 네이버 로그인 성공 시 callback 호출 메소드
	@RequestMapping(value="/naverjoinok")
	public ModelAndView callbackJoin(@RequestParam("code") String code, @RequestParam("state") String state) throws IOException, ParseException{
		
		OAuth2AccessToken oauthToken;
		oauthToken = naverJoinApi.getAccessToken(session, code, state);
		
		// 로그인 사용자 정보를 가져온다
		apiResult = naverJoinApi.getUserProfile(oauthToken);
		
		mav.addObject("result", apiResult);
		
		// apiResult에 담긴 내용이 JSON이기 때문에 String 변환 작업 수행
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		
		JSONObject member = (JSONObject) obj;
		JSONObject memberInfo = (JSONObject) member.get("response");
		
		// 네이버로 로그인 성공시 가져올 정보들
		String userNaver = (String) memberInfo.get("id");
		String userEmail= (String) memberInfo.get("email");
		String userName= (String) memberInfo.get("name");
		String userGender= (String) memberInfo.get("gender");
		String userBirth= (String) memberInfo.get("birthday");
		
		mav.addObject("userNaver", userNaver);
		mav.setViewName("MemberJoinForm");
		
		return mav;
	}
	
	@Autowired
	private KakaoApi kakao;
	
	// 카카오 회원가입 api
	@RequestMapping(value="/join")
	public String join(@RequestParam("code") String code) {

		String access_Token = kakao.getAccessTokenJoin(code);
		
		HashMap<String, Object> userInfo = kakao.getUserInfo(access_Token);
		
		// 클라이언트의 이메일이 존재 할 때 세션에 해당 이메일과 토큰 등록
		if(userInfo.get("email") != null) {
			session.setAttribute("userKakao", userInfo.get("email"));
			session.setAttribute("access_Token", access_Token);
		}
		
		return "MemberJoinForm";
	}
	
	// 네이버 아이디로 로그인(네이버 아이디로 사이트 가입 후 로그인)
	@RequestMapping(value="/naverLogin")
	public ModelAndView naverLogin() {
		
		String naverUrl = naverLoginApi.getAuthorizationUrl(session);
		
		mav.addObject("naverurl", naverUrl);
		mav.setViewName("NaverLogin");
		
		return mav;
	}
	
	// 네이버로 로그인 성공 시 callback 호출 메소드
	@RequestMapping(value = "/naverloginok")
	public ModelAndView callbackLogin(@RequestParam("code")String code, 
			@RequestParam("state") String state) throws IOException, 
			ParseException{
		
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginApi.getAccessToken(session, code, state);
		
		// 로그인 사용자 정보를 가져온다
		apiResult = naverLoginApi.getUserProfile(oauthToken);
		
		mav.addObject("result", apiResult);
		
		// apiResult에 담긴 내용이 JSON이기 때문에 String 변환 작업 수행
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		
		JSONObject member = (JSONObject) obj;
		JSONObject memberInfo = (JSONObject) member.get("response");
		
		// 네이버로 로그인 성공시 가져올 정보들
		String userNaver = (String) memberInfo.get("id");
		
		mav = mSvc.naverLogin(userNaver);
		
		mav.addObject("userNaver", userNaver);
		
		return mav;
		
	}
	
	// 카카오 로그인 api
	@RequestMapping(value="/login")
	public ModelAndView login(@RequestParam("code") String code) {
		
		String access_Token = kakao.getAccessTokenLogin(code);
		HashMap<String, Object> userInfo = kakao.getUserInfo(access_Token);
		
		if(userInfo.get("email") != null) {
			String userKakao = (String) userInfo.get("email");
			mav = mSvc.kakaoLogin(userKakao);
		}
		
		return mav;
	}
	
	// 일반 회원 로그아웃
	@RequestMapping(value="/memberLogout")
	public ModelAndView MemberLogout(@ModelAttribute MemberDTO member) {
		
		session.invalidate();
		mav.setViewName("Index");
		
		return mav;
	}
	
	// 회원 탈퇴
	@RequestMapping(value="/memberDelete", method=RequestMethod.GET)
	public ModelAndView MemberDelete() {

		mav = mSvc.memberDelete();
		
		return mav;
	}
	
	// 회원 수정
	@RequestMapping(value="/memberModify", method=RequestMethod.POST)
	public ModelAndView MemberModify(@ModelAttribute MemberDTO member) throws IllegalStateException, IOException {
		
		mav = mSvc.memberModify(member);
		
		return mav;
	}
	
	// 로그인 확인
	@RequestMapping(value="/loginCheck", method=RequestMethod.POST)
	public @ResponseBody String LoginCheck(@RequestParam("userId") String userId, @RequestParam("userPw") String userPw) {
		
		String resultMsg = mSvc.loginCheck(userId, userPw);
		
		return resultMsg;
	}
	
	// 쿠폰함 조회
	@RequestMapping(value="/memberCouponList")
	public ModelAndView MemberCouponList() {
		
		mav = mSvc.memberCouponList();
		
		return mav;
	}
	
	// 리뷰내역 조회
	@RequestMapping(value="/memberReviewList")
	public ModelAndView MemberReviewList() {
		
		mav = mSvc.memberReviewList();
		
		return mav;
	}
	
	// 문의내역 조회
	@RequestMapping(value="/memberAskList")
	public ModelAndView MemberAskList() {
		
		mav = mSvc.memberAskList();
		
		return mav;
	}
	
	// 장바구니 조회
	@RequestMapping(value="/memberBasketList")
	public ModelAndView MemberBasketList() {
		
		mav = mSvc.memberBasketList();
		
		return mav;
	}
	
	// 장바구니 내역 삭제
	@RequestMapping(value="/basketDelete", method=RequestMethod.GET)
	public @ResponseBody String BasketDelete(@RequestParam("goodsNum") int goodsNum) {
		
		String resultMsg = mSvc.basketDelete(goodsNum);
		
		return resultMsg;
	}
	
	// 쿠폰함 갯수
	@RequestMapping(value="/couponCount", method=RequestMethod.POST)
	public @ResponseBody String CouponCount() {
		
		String resultMsg = mSvc.couponCount();
		
		return resultMsg;
	}
	
	// 결제내역 
	@RequestMapping(value="memberPaymentList")
	public ModelAndView MemberPaymentList() {
		
		mav = mSvc.memberPaymentList();
		
		return mav;
	}
	
	// 결제내역 페이징
	@RequestMapping(value="paymentPagingList")
	public ModelAndView PaymentPagingList(@RequestParam(value="hotelPage", required=false, defaultValue="1") int hotelPage,
										  @RequestParam(value="beautyPage", required=false, defaultValue="1") int beautyPage,
										  @RequestParam(value="medicalPage", required=false, defaultValue="1") int medicalPage,
										  @RequestParam(value="goodsPage", required=false, defaultValue="1") int goodsPage) {
		
		if(hotelPage == 0) {
			hotelPage = 1;
		}
		
		if(beautyPage == 0) {
			beautyPage = 1;
		}
		
		if(medicalPage == 0) {
			medicalPage = 1;
		}
		
		if(goodsPage == 0) {
			goodsPage = 1;
		}
		
		mav = mSvc.hotelPaymentPagingList(hotelPage);
		mav = mSvc.beautyPaymentPagingList(beautyPage);
		mav = mSvc.medicalPaymentPagingList(medicalPage);
		mav = mSvc.goodsPaymentPagingList(goodsPage);
		
		return mav;
	}
	
	// 리뷰내역 페이징
	@RequestMapping(value="reviewPagingList")
	public ModelAndView ReviewPagingList(@RequestParam(value="page", required=false, defaultValue="1") int page) {
		
		if(page == 0) {
			page = 1;
		}
		
		mav = mSvc.reviewPagingList(page);
		
		return mav;
	}
	
	// 문의내역 페이징
	@RequestMapping(value="askPagingList")
	public ModelAndView AskPagingList(@RequestParam(value="page", required=false, defaultValue="1") int page) {
		
		if(page == 0) {
			page = 1;
		}
		
		mav = mSvc.askPagingList(page);
		
		return mav;
	}
	
	// 장바구니 페이징
	@RequestMapping(value="basketPagingList")
	public ModelAndView BasketPagingList(@RequestParam(value="page", required=false, defaultValue="1") int page) {
		
		if(page == 0) {
			page = 1;
		}
		
		mav = mSvc.basketPagingList(page);
		
		return mav;
	}
}
