package com.icia.project.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.icia.project.dto.BeautyDTO;
import com.icia.project.dto.CouponDTO;
import com.icia.project.dto.GoodsDTO;
import com.icia.project.dto.HotelDTO;
import com.icia.project.dto.MedicalDTO;
import com.icia.project.dto.MemberDTO;
import com.icia.project.dto.PageDTO;
import com.icia.project.dto.ReviewDTO;

import javafx.util.Pair;

@Repository
public class MemberDAO {
	
	@Autowired
	private SqlSessionTemplate sql;

	// 아이디 중복검사
	public String idOverlap(String userId) {
		
		return sql.selectOne("member.idOverlap", userId);
	}
	
	// 전화번호 중복검사
	public String phoneOverlap(String userPhone) {
		
		return sql.selectOne("member.phoneOverlap", userPhone);
	}
	
	// 회원가입
	public int memberJoin(MemberDTO member) {
		
		if(member.getUserNaver() != null) {
			return sql.insert("member.memberJoinNaver", member);
		}else if(member.getUserKakao() != null) {
			return sql.insert("member.memberJoinKakao", member);
		}else {
			return sql.insert("member.memberJoin", member);
		}
	}
	
	// 암호화된 비밀번호 가져오기(로그인)
	public String loginPassword(String userId) {
		
		return sql.selectOne("member.memberEncoderPw", userId);
	}
	
	// 일반 로그인
	public MemberDTO memberLogin(MemberDTO member) {
		
		return sql.selectOne("member.memberLogin", member);
	}

	// 네이버로 로그인
	public MemberDTO naverLogin(String userNaver) {
		
		return sql.selectOne("member.naverLogin", userNaver);
	}
	
	// 카카오로 로그인
	public MemberDTO kakaoLogin(String userKakao) {
		
		return sql.selectOne("member.kakaoLogin", userKakao);
	}
	
	// 비밀번호 확인(수정, 탈퇴)
	public String pwCheck(String userId) {
		System.out.println("가냐");
		return sql.selectOne("member.pwCheck", userId);
	}

	// 회원 탈퇴
	public int memberDelete(String userId) {
		
		return sql.delete("member.memberDelete", userId);
	}
	
	// 회원 수정
	public int memberModify(MemberDTO member) {
		System.out.println("3");
		return sql.update("member.memberModify", member);
	}

	// 로그인 확인
	public String loginCheck(Map<String, String> loginCheck) {
		System.out.println("3");
		return sql.selectOne("member.loginCheck", loginCheck);
	}
	
	// 수정 후 회원 정보 조회
	public MemberDTO selectMember(String userId) {
		
		return sql.selectOne("member.selectMember", userId);
	}
	
	// 쿠폰함 조회
	public List<CouponDTO> memberCouponList(String userId) {
		
		return sql.selectList("member.memberCouponList", userId);
	}
	
	// 리뷰내역 조회
	public List<ReviewDTO> memberReviewList(String userId) {
		
		return sql.selectList("member.memberReviewList", userId);
	}
	
	// 문의내역 조회
	public List<GoodsDTO> memberAskList(String userId) {
		
		return sql.selectList("member.memberAskList", userId);
	}

	// 장바구니 조회
	public List<GoodsDTO> memberBasketList(String userId) {
		
		return sql.selectList("member.memberBasketList", userId);
	}
	
	// 장바구니 내역 삭제
	public int basketDelete(Map<String, Object> basketDeleteSelect) {
		
		return sql.delete("member.basketDelete", basketDeleteSelect);
	}
	
	// 쿠폰함 갯수
	public int couponCount(String userId) {
		
		return sql.selectOne("member.couponCount", userId);
	}
	
	// 결제내역 조회 - 미용
	public List<BeautyDTO> beautyPaymentList(String userId) {
		
		return sql.selectList("member.beautyPaymentList", userId);
	}
	
	// 결제내역 조회 - 호텔
	public List<HotelDTO> hotelPaymentList(String userId) {
		
		return sql.selectList("member.hotelPaymentList", userId);
	}
	
	// 결제내역 조회 - 병원
	public List<MedicalDTO> medicalPaymentList(String userId) {
		
		return sql.selectList("member.medicalPaymentList", userId);
	}

	// 결제내역 조회 - 용품
	public List<GoodsDTO> goodsPaymentList(String userId) {
		
		return sql.selectList("member.goodsPaymentList", userId);
	}
	
	// 결제내역 - 호텔 페이징 - count
	public int hotelPaymentListCount(String userId) {
		
		return sql.selectOne("member.hotelPaymentListCount", userId);
	}
	
	// 결제내역 - 미용 페이징 - count
	public int beautyPaymentListCount(String userId) {
		
		return sql.selectOne("member.beautyPaymentListCount", userId);
	}
	
	// 결제내역 병원 페이징 - count
	public int medicalPaymentListCount(String userId) {

		return sql.selectOne("member.medicalPaymentListCount", userId);
	}
	
	// 결제내역 용품 페이징 - count
	public int goodsPaymentListCount(String userId) {
		
		return sql.selectOne("member.goodsPaymentListCount", userId);
	}
	
	// 리뷰내역 페이징 - count
	public int reviewListCount(String userId) {
		
		return sql.selectOne("member.reviewListCount", userId);
	}
	
	// 문의내역 페이징 - count
	public int askListCount(String userId) {
		
		return sql.selectOne("member.askListCount", userId);
	}

	// 장바구니 - 페이징 - count
	public int basketListCount(String userId) {
		
		return sql.selectOne("member.basketListCount", userId);
	}
	
	// 결제내역 - 호텔 페이징
	public List<HotelDTO> hotelPagingList(Map<Object, Object> hotelPagingResult) {
		
		return sql.selectList("member.hotelPagingList", hotelPagingResult);
	}
	
	// 결제내역 - 미용 페이징
	public List<HotelDTO> beautyPagingList(Map<Object, Object> beautyPagingResult) {
		
		return sql.selectList("member.beautyPagingList", beautyPagingResult);
	}
	
	// 결제내역 - 병원 페이징
	public List<MedicalDTO> medicalPagingList(Map<Object, Object> medicalPagingResult) {
		
		return sql.selectList("member.medicalPagingList", medicalPagingResult);
	}
	
	// 결제내역 - 용품 페이징
	public List<GoodsDTO> goodsPagingList(Map<Object, Object> goodsPagingResult) {
		
		return sql.selectList("member.goodsPagingList", goodsPagingResult);
	}
	
	// 리뷰내역 - 페이징
	public List<ReviewDTO> reviewPagingList(Map<Object, Object> reviewPagingResult) {
		
		return sql.selectList("member.reviewPagingList", reviewPagingResult);
	}

	// 문의내역 - 페이징
	public List<GoodsDTO> askPagingList(Map<Object, Object> askPagingResult) {
		
		return sql.selectList("member.askPagingList", askPagingResult);
	}
	
	// 장바구니 - 페이징
	public List<GoodsDTO> basketPagingList(Map<Object, Object> basketPagingResult) {
		
		return sql.selectList("member.basketPagingList", basketPagingResult);
	}
}
