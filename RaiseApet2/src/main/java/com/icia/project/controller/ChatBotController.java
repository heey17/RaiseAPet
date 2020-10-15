package com.icia.project.controller;

import java.io.IOException;

import org.codehaus.jackson.map.JsonMappingException;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonParseException;
import com.icia.project.dto.KeyboardDTO;
import com.icia.project.dto.MessageDTO;
import com.icia.project.dto.RequestMessageDTO;
import com.icia.project.dto.ResponseMessageDTO;

@RestController
public class ChatBotController {
	
	
	@RequestMapping(value = "/keyboard", method = RequestMethod.GET, produces="application/json; charset=UTF-8")
	public KeyboardDTO keyboard(){
		KeyboardDTO keyboard=new KeyboardDTO();
		keyboard.setType("text");
		return keyboard;
	}
	
	@RequestMapping(value = "/message", method = RequestMethod.POST, produces="application/json; charset=UTF-8")
	@ResponseBody
	public ResponseMessageDTO message(@RequestBody RequestMessageDTO vo) throws JsonParseException, JsonMappingException, IOException{
	  ResponseMessageDTO res_vo=new ResponseMessageDTO();
	  MessageDTO mes_vo=new MessageDTO();
	  KeyboardDTO keyboard=new KeyboardDTO();
	  keyboard.setType("text");
	  res_vo.setKeyboard(keyboard);
	  if(!vo.getType().equals("text")){
	  //텍스트 타입만 허용할 것이기 때문에
	  mes_vo.setText("텍스트 타입만 허용하고 있습니다");
	  res_vo.setMessage(mes_vo);
	  return res_vo;
	  }
	  mes_vo.setText(vo.getContent());
	  res_vo.setMessage(mes_vo);
	  return res_vo;
	}
}
