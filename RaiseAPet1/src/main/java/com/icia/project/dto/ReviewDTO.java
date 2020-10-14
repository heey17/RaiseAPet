package com.icia.project.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ReviewDTO {

	private String reviewContents, reviewImage, reviewRating, reviewDate, reviewBlind, reviewTitle, reviewKind, reviewUserId;
	private int reviewNum, reviewLike;
	private MultipartFile reviewImageFile;
}
