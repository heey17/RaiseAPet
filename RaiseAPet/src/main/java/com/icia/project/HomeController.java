package com.icia.project;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		//return "editorTest";
		return "Index";
	}
	
/*                                         희영                                                                              */
	// 글작성 폼으로 이동
	@RequestMapping(value = "goHotelWrtieForm", method = RequestMethod.GET)
	public String goHotelWrtieForm() {
		return "AdminHotelWriteForm";
	}
	
	@RequestMapping(value = "goBeautyWrtieForm", method = RequestMethod.GET)
	public String goBeautyWrtieForm() {
		return "AdminBeautyWriteForm";
	}
	
	@RequestMapping(value = "goMedicalWrtieForm", method = RequestMethod.GET)
	public String goMedicalWrtieForm() {
		return "AdminMedicalWriteForm";
	}
	
	@RequestMapping(value = "goGoodsWrtieForm", method = RequestMethod.GET)
	public String goGoodsWrtieForm() {
		return "AdminGoodsWriteForm";
	}
	
	@RequestMapping(value = "goEventWrtieForm", method = RequestMethod.GET)
	public String goEventWrtieForm() {
		return "AdminEventWriteForm";
	}
	
	@RequestMapping(value = "goEducationWrtieForm", method = RequestMethod.GET)
	public String goEducationWrtieForm() {
		return "AdminEducationWriteForm";
	}
	
	@RequestMapping(value = "goCouponWrtieForm", method = RequestMethod.GET)
	public String goCouponWrtieForm() {
		return "AdminCouponWriteForm";
	}
	
	// 회원 신고 리스트로 이동
	@RequestMapping(value = "goAdminMemberReport", method = RequestMethod.GET)
	public String goAdminMemberReport() {
		return "AdminReportList";
	}
	
	// 문의 글 리스트로 이동
	@RequestMapping(value = "goAdminAskList", method = RequestMethod.GET)
	public String goAdminAskList() {
		return "AdminAskList";
	}
	
	
/*                                         은희                                                                              */
		
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
		public String MemberMyPage() {
			return "MemberMyPage";
		}
		
		// Index(메인).jsp로 이동
		@RequestMapping(value="/indexForm")
		public String IndexForm() {
			
			return "Index";
		}
}
