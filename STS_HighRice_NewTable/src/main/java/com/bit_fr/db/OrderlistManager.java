package com.bit_fr.db;

import java.io.Reader;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.bit_fr.vo.OrderlistVo;

public class OrderlistManager {
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

	public static int getCheckExist_orderlist(String member_id, int product_id) {
		int count = -1;
		SqlSession session = factory.openSession();

		HashMap map = new HashMap();
		map.put("member_id", member_id);
		map.put("product_id", product_id);

		count = session.selectOne("orderlist.getCheckExist_orderlist", map);
		session.close();

		return count;
	}

	public static int getCountNextOrderId_orderlist() {
		int nextOrderID = -1;
		SqlSession session = factory.openSession();

		nextOrderID = session.selectOne("orderlist.getCountNextOrderId_orderlist");
		session.close();

		return nextOrderID;
	}

	public static int getCountToMyCondition_orderlist(String member_id, String condition) {
		int count_MyProduct = -1;
		SqlSession session = factory.openSession();

		HashMap map = new HashMap();
		map.put("member_id", member_id);
		map.put("condition", condition);

		count_MyProduct = session.selectOne("orderlist.getCountToMyCondition_orderlist", map);
		session.close();

		return count_MyProduct;
	}

	public static List<OrderlistVo> getAll_orderlist() {
		SqlSession session = factory.openSession();

		List<OrderlistVo> list = session.selectList("orderlist.getAll_orderlist");
		session.close();

		return list;
	}

	public static List<OrderlistVo> getMyOrderlistToCondition_orderlist(String member_id, String condition) {
		SqlSession session = factory.openSession();

		HashMap map = new HashMap();
		map.put("member_id", member_id);
		map.put("condition", condition);

		List<OrderlistVo> list = session.selectList("orderlist.getMyOrderlistToCondition_orderlist", map);
		session.close();

		return list;
	}

	public static List<OrderlistVo> getAllMyOrder_orderlist(String member_id) {
		HashMap map = new HashMap();
		map.put("member_id", member_id);

		SqlSession session = factory.openSession();

		List<OrderlistVo> list = session.selectList("orderlist.getAllMyOrder_orderlist", map);
		session.close();

		return list;
	}

	public static List<OrderlistVo> getMyCartList_orderlist(String sql) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("sql", sql);

		SqlSession session = factory.openSession();
		List<OrderlistVo> list = session.selectList("orderlist.getMyCartList_orderlist", map);
		session.close();

		return list;
	}

	public static int getMyRentMonth_orderlist(String member_id, int product_id) {
		int rent_month = -1;
		SqlSession session = factory.openSession(true);

		HashMap map = new HashMap();
		map.put("member_id", member_id);
		map.put("product_id", product_id);

		rent_month = session.selectOne("orderlist.getMyRentMonth_orderlist", map);
		session.close();

		return rent_month;
	}

	public static int insertCartlist_orderlist(OrderlistVo v) {
		int re = -1;
		SqlSession session = factory.openSession(true);

		HashMap map = new HashMap();
		map.put("order_id", v.getOrder_id());
		map.put("member_id", v.getMember_id());
		map.put("product_id", v.getProduct_id());
		map.put("rent_month", v.getRent_month());

		re = session.insert("orderlist.insertCartlist_orderlist", map);
		session.close();

		return re;
	}

	public static int insertPayment_orderlist(OrderlistVo v) {
		int re = -1;
		SqlSession session = factory.openSession(true);

		HashMap map = new HashMap();
		map.put("order_id", v.getOrder_id());
		map.put("member_id", v.getMember_id());
		map.put("product_id", v.getProduct_id());
		map.put("rent_month", v.getRent_month());

		re = session.insert("orderlist.insertPayment_orderlist", map);
		session.close();

		return re;
	}

	public static int updateRentMonth_orderlist(String member_id, int product_id, int rent_month) {
		int re = -1;
		SqlSession session = factory.openSession(true);

		HashMap map = new HashMap();
		map.put("member_id", member_id);
		map.put("product_id", product_id);
		map.put("rent_month", rent_month);

		re = session.update("orderlist.updateRentMonth_orderlist", map);
		session.close();

		return re;
	}

	public static int updateRentEnd_orderlist(int order_id) {
		int re = -1;
		HashMap map = new HashMap();
		map.put("order_id", order_id);

		SqlSession session = factory.openSession(true);

		re = session.update("orderlist.updateRentEnd_orderlist", map);
		session.close();

		return re;
	}

	public static int updatePaymentProduct_orderlist(String member_id, long paymentOne) {
		int re = -1;
		SqlSession session = factory.openSession(true);

		HashMap map = new HashMap();
		map.put("member_id", member_id);
		map.put("paymentOne", paymentOne);

		re = session.update("orderlist.updatePaymentProduct_orderlist", map);
		session.close();

		return re;
	}

	public static int updateRentalDateFromCartlistPayment_orderlist(String member_id, int product_id, int rent_month) {
		int re = -1;
		SqlSession session = factory.openSession(true);

		HashMap map = new HashMap();
		map.put("member_id", member_id);
		map.put("product_id", product_id);
		map.put("rent_month", rent_month);

		re = session.update("orderlist.updateRentalDateFromCartlistPayment_orderlist", map);
		session.close();

		return re;
	}

	public static int updateDepositToMaster_orderlist(long paymentOne) {
		int re = -1;
		SqlSession session = factory.openSession(true);

		HashMap map = new HashMap();
		map.put("paymentOne", paymentOne);

		re = session.update("orderlist.updateDepositToMaster_orderlist", map);
		session.close();

		return re;
	}

	public static int delete_orderlist(String member_id, int product_id) {
		int re = -1;
		SqlSession session = factory.openSession(true);

		HashMap map = new HashMap();
		map.put("member_id", member_id);
		map.put("product_id", product_id);

		re = session.delete("orderlist.delete_orderlist", map);
		session.close();

		return re;
	}

}
