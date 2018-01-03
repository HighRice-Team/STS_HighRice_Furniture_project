package com.bit_fr.db;

import java.io.Reader;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.bit_fr.dao.Board_QnADao;
import com.bit_fr.vo.Board_QnAVo;

public class Board_QnAManager {
	private static SqlSessionFactory factory;
	static {
		try {
			Reader reader = Resources.getResourceAsReader("com/bit_fr/db/sqlMapConfig.xml");

			factory = new SqlSessionFactoryBuilder().build(reader);
			reader.close();

		} catch (Exception e) {

			System.out.println(e);
		}
	}

	public static int getTotalRecord(String writer, String my) {
		SqlSession session = factory.openSession();
		HashMap map = new HashMap();
		map.put("writer", writer);
		map.put("my", my);
		int n = session.selectOne("board.totalRecord", map);
		session.close();
		return n;
	}

	public static int nextNo() {
		SqlSession session = factory.openSession();
		int n = session.selectOne("board.nextNo");
		session.close();
		return n;
	}

	public static int insert(Board_QnAVo b) {
		SqlSession session = factory.openSession();
		int re = session.insert("board.insert", b);
		session.commit();
		session.close();
		return re;
	}

	public static int update(Board_QnAVo b) {
		SqlSession session = factory.openSession();
		int re = session.update("board.update", b);
		session.commit();
		session.close();
		return re;
	}

	public static List<Board_QnAVo> list(int pageNUM, String writer, String my) {
		int start = (pageNUM - 1) * Board_QnADao.pageSIZE + 1;
		int end = start + Board_QnADao.pageSIZE - 1;

		if (writer != null && writer.equals(""))
			writer = null;

		HashMap map = new HashMap();
		map.put("start", start);
		map.put("end", end);
		map.put("writer", writer);
		map.put("my", my);

		SqlSession session = factory.openSession();
		List<Board_QnAVo> list = session.selectList("board.selectAll", map);
		session.close();
		return list;

	}

	public static Object getBoard(int no) {

		Board_QnAVo b = null;
		SqlSession session = factory.openSession();
		b = session.selectOne("board.getBoard", no);
		session.close();
		return b;
	}

	public static int deleteBoard(int no) {

		SqlSession session = factory.openSession();
		int re = session.delete("board.delete", no);
		session.commit();
		session.close();
		return re;
	}

	public static void updateStep(int b_ref, int b_step) {

		HashMap map = new HashMap();
		map.put("b_ref", b_ref);
		map.put("b_step", b_step);

		SqlSession session = factory.openSession(true);
		session.update("board.updateStep", map);
		session.close();
	}
}
