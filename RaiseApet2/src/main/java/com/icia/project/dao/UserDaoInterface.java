package com.icia.project.dao;

public interface UserDaoInterface {

	int GetKey(String userId, String key); // 유저 인증키 생성 메서드
	int alter_userKey(String userId, String key); // 유저 인증키 Y로 바꿔주는 메서드
}
