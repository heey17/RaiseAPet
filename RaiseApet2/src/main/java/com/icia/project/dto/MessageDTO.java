package com.icia.project.dto;

import lombok.Data;

@Data
public class MessageDTO {
	//사용자에게 발송될 텍스트("최대 100자")
		private String text;
}
