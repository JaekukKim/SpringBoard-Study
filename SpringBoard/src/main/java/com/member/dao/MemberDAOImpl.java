package com.member.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.member.domain.MemberDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class MemberDAOImpl implements MemberDAO{
	
	@Autowired
	private SqlSession sqlSession;
	
	private static final String NAME_SPACE = "mybatisMember";
	
	// 회원가입
	@Override
	public void memberSignUp(MemberDTO membeDTO) throws Exception {
		log.info("회원가입 실행 memberSignUp (DAO)");
		
		sqlSession.insert(NAME_SPACE + ".signUpMember", membeDTO);
	}
}
