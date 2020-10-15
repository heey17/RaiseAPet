package com.icia.project.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class EducationDTO {

	// 훈련 정보
	private String eduTitle, eduContents, eduImage, eduVideo;
	private int eduLike, eduHit, eduNum;
	private MultipartFile eduImageFile;
}
