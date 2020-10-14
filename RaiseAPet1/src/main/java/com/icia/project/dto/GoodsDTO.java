package com.icia.project.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class GoodsDTO {

	// 용품 정보
	private String goodsName, goodsAnimalKind, goodsCategory, goodsContents, goodsImage1,goodsImage2,goodsImage3,goodsImage4,goodsImage5, kind;
	private int goodsNum, goodsPrice, goodsStock, goodsLike, goodsHit, userPoint;
	private MultipartFile goodsImageFile;
	
	
	// 구매 정보
	private String buyUserId, buyPayment, buyAddress, buyDelevery;
	private int buyGoodsNum, buyCount, buyPrice;	
	
	// 장바구니 정보
	private int basketGoodsCount, basketPrice;
	
	// 문의 정보
	private String askContents, askUserId, askSecret, askAnswer;
	private int askGoodsNum, askNum, askPw;
}
