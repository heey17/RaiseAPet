package com.icia.project.service;

import java.util.Random;

import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.icia.project.dao.UserDaoInterface;

@Service
public class UserMailSendService {
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	private UserDaoInterface userDao;
	
	@Autowired
	HttpSession session;
		
	// 이메일 난수 만드는 메서드
	private String init() {
		
		Random ran = new Random();
		StringBuffer sb = new StringBuffer();
		int num = 0;
		
		do {
			num = ran.nextInt(75) + 48;
			if((num >= 48 && num <= 57) || (num >= 65 && num <= 90) || (num >= 97 && num <= 122)) {
				sb.append((char) num);
			}else {
				continue;
			}
		} while(sb.length() < size);
		if(lowerCheck) {
			return sb.toString().toLowerCase();
		}
		return sb.toString();
	}
	
	// 난수를 이용한 키 생성
	private boolean lowerCheck;
	private int size;
	
	public String getKey(boolean lowerCheck, int size) {
		this.lowerCheck = lowerCheck;
		this.size = size;
		return init();
	}
	
	// 회원가입 발송 이메일(인증키 발송)
	public void mailSendWithUserKey(String userEmail, String userId, HttpServletRequest request) {
		
		String key = getKey(false, 20);
		userDao = sqlSession.getMapper(UserDaoInterface.class);
		userDao.GetKey(userId, key);
		MimeMessage mail = mailSender.createMimeMessage();
		String htmlStr = "<h2>안녕하세요 :p 레어펫(Raise A Pet) 입니다!</h2><br><br>" +
					"<h3>" + userId + "님</h3>" + "<p>인증하기 버튼을 누르시면 로그인을 하실 수 있습니다. :"
					+ "<a href='http://localhost:9090" + request.getContextPath() + 
					"/user/key_alter?userId=" + userId + "&key=" + key +"'>인증하기</a></p>";
		
			try {
				mail.setSubject("[본인인증] 레어펫(Raise A Pet) :p 본인인증 메일 입니다.", "utf-8");
				mail.setText(htmlStr, "utf-8", "html");
				mail.addRecipient(RecipientType.TO, new InternetAddress(userEmail));
				mailSender.send(mail);
			} catch (MessagingException  e) {
				e.printStackTrace();
			}
	}
	
	// 인증 확인 메서드(Y 값으로 바꿔주는 메서드)
	public int alter_userKey_service(String userId, String key) {
		
		int resultCnt = 0;
		
		userDao = sqlSession.getMapper(UserDaoInterface.class);
		resultCnt = userDao.alter_userKey(userId, key);
		
		return resultCnt;
	}
	
	// 비밀번호 찾기 이메일 발송
	public void mailSend(String userEmail) {
			
		String key = getKey(false, 20);
		session.setAttribute("key", key);
		// 인증번호 발송하고 ajax로 인증번호가 같은 지 확인하기 위해서 key(난수)를 session에 담음.
		userDao = sqlSession.getMapper(UserDaoInterface.class);
		MimeMessage mail = mailSender.createMimeMessage();
		String htmlStr = "<h2>안녕하세요 :p 레어펫(Raise A Pet) 입니다!</h2><br><br>" +
					"<p>인증번호를 입력 하시면 비밀번호를 수정 하실 수 있습니다</p><br>" + "<p>인증번호는 "
					+ key +"입니다</p>";
			
			try {
				mail.setSubject("[본인인증] 레어펫(Raise A Pet) :p 비밀번호 찾기 인증번호 메일 입니다.", "utf-8");
				mail.setText(htmlStr, "utf-8", "html");
				mail.addRecipient(RecipientType.TO, new InternetAddress(userEmail));
				mailSender.send(mail);
			} catch (MessagingException  e) {
				e.printStackTrace();
			}
		
	}

}
