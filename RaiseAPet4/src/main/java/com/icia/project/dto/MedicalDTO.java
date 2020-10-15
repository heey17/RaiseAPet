package com.icia.project.dto;

import lombok.Data;

@Data
public class MedicalDTO {

	// 의사 정보
	private String doctorName, doctorCode, doctorImage, doctorOff, doctorCareer, doctorSubject;

	// 예약 정보
	private String medicalReserveDate, medicalReserveTime, medicalReserveAnimalKind, medicalReserveAnimalNote, 
					medicalReserveDoctor, medicalReserveUserId, medicalReservePayment, kind;
	private int medicalReserveAnimalAge, medicalReservePrice, medicalReservePoint;
}
