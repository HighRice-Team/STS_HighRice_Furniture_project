package com.bit_fr.db;

import java.io.Reader;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.bit_fr.vo.MemberVo;

public class MemberManager {
	private static SqlSessionFactory factory;
	static {
		try {
			Reader reader = Resources.getResourceAsReader("com/bit_fr/db/sqlMapConfig.xml");
			factory = new SqlSessionFactoryBuilder().build(reader);
			reader.close();

		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}
	}

	// Select

	public static List<MemberVo> getAll_member() { // Member 테이블의 모든 객체를 member_id 순으로 정렬한 결과를 List로 반환한다.
		SqlSession session = factory.openSession();
		List<MemberVo> list = session.selectList("member.getAll_member");
		session.close();

		return list;
	}

	public static MemberVo getOne_member(String member_id) { // member_id를 매개변수로 받아 해당 member의 정보를 Vo로 반환한다.
		HashMap map = new HashMap();
		map.put("member_id", member_id);
		
		SqlSession session = factory.openSession();
		MemberVo v = session.selectOne("member.getOne_member", map);
		session.close();

		return v;
	}

	public static String getId_member(MemberVo v) { // 회원정보 찾기. name과 jumin을 매개변수로 받아 일치하는 member의 member_id값을 반환
		SqlSession session = factory.openSession();
		String member_id = session.selectOne("member.getId_member", v);
		session.close();

		return member_id;
	}

	public static int getCount_member() { // 모든 회원의 수를 반환.
		SqlSession session = factory.openSession();
		int re = session.selectOne("member.getCount_member");
		session.close();

		return re;
	}

	
	
	// Insert

	public static int insert_member(MemberVo v) { // 회원가입. 일반회원과 관리자 구분없이 아이디 생성이 이루어짐. 구분은 속성 값 grade로 구별한다.
		SqlSession session = factory.openSession(true);
		int re = session.insert("member.insert_member", v);
		session.close();

		return re;
	}

	
	
	// Update

	public static int updateResetPwd_member(String member_id) { // 회원계정의 비밀번호 초기화
		SqlSession session = factory.openSession(true);
		int re = session.update("member.updateResetPwd_member", member_id);
		session.close();

		return re;
	}

	public static int updatePwd_member(MemberVo v) { // 회원계정의 비밀번호 변경
		SqlSession session = factory.openSession(true);
		int re = session.update("member.updatePwd_member", v);
		session.close();

		return re;
	}

	public static int updateInfo_member(MemberVo v) { // 회원계정의 정보변경
		SqlSession session = factory.openSession(true);
		int re = session.update("member.updateInfo_member", v);
		session.close();

		return re;
	}
	
	 

	
	
	// Delete

}
