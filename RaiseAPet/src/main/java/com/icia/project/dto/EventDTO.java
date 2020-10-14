package com.icia.project.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class EventDTO {

	private String eventTitleImage, eventImage, eventDate, eventContents, eventCouponCode, kind;
	private int eventNum, eventHit;
	private MultipartFile eventTitleImageFile, eventImageFile;
}
