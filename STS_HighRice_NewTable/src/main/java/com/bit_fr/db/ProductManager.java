package com.bit_fr.db;

import java.io.Reader;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.bit_fr.vo.ProductVo;

public class ProductManager {
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

	public static List<ProductVo> getCust(String sql) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("sql", sql);

		SqlSession session = factory.openSession();
		List<ProductVo> list = session.selectList("product.getCust", map);
		session.close();
		return list;
	}


	public static List<ProductVo> getAll_product(String sql) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("sql", sql);
		SqlSession session = factory.openSession();
		List<ProductVo> list = session.selectList("product.getAll_product", map);
		session.close();
		return list;
	}

	public static ProductVo getOne_product(int product_id) {
		SqlSession session = factory.openSession();
		ProductVo p = session.selectOne("product.getOne_product", product_id);
		session.close();
		return p;
	}

	public static int getNextId_product() {
		SqlSession session = factory.openSession();
		int n = session.selectOne("product.NextId_product");
		session.close();
		return n;
	}

	public static int getCount_product() {
		SqlSession session = factory.openSession();
		int re = session.selectOne("product.getCount_product");
		session.close();
		return re;
	}

	public static ProductVo getCutomizeList_product(String sql) {
		SqlSession session = factory.openSession();
		ProductVo p = (ProductVo) session.selectList("product.getCutomizeList_product", sql);
		session.close();
		return p;
	}

	public static List<ProductVo> getMySell_product(String member_id) {
		SqlSession session = factory.openSession();
		List<ProductVo> list = session.selectList("product.getMySell_product", member_id);
		session.close();
		return list;
	}

	public static int getMySellCount_product(String member_id) {
		SqlSession session = factory.openSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("member_id", member_id);
		int n = session.selectOne("product.getMySellCount_product", map);
		session.close();
		return n;
	}

	public static int getMySellCountWithCondition_product(String member_id, String condition) {
		SqlSession session = factory.openSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("member_id", member_id);
		map.put("condition", condition);
		int n = session.selectOne("product.getMySellCountWithCondition_product", map);
		session.close();
		return n;
	}

	public static List<ProductVo> getMySellForPaging_product(String member_id, int start, int end) {
		SqlSession session = factory.openSession();
		HashMap map = new HashMap();
		map.put("member_id", member_id);
		map.put("start", start);
		map.put("end", end);
		List<ProductVo> list = session.selectList("product.getMySellForPaging_product", map);
		session.close();
		return list;
	}

	public static int getAllPublishingCount_product(String category, String condition) {
		SqlSession session = factory.openSession();
		HashMap map = new HashMap();
		map.put("category", category);
		map.put("condition", condition);

		int re = session.selectOne("product.getAllPublishingCount_product", map);
		session.close();
		return re;
	}

	public static int getItemPublishingCount_product(String condition) {
		SqlSession session = factory.openSession();
		int re = session.selectOne("product.getItemPublishingCount_product");
		session.close();
		return re;
	}

	public static ProductVo getForAdmin_product() {
		SqlSession session = factory.openSession();
		ProductVo p = (ProductVo) session.selectList("product.getForAdmin_product");
		session.close();
		return p;
	}

	public static int insert_product(ProductVo p) {
		SqlSession session = factory.openSession();
		int re = session.insert("product.insert_product", p);
		session.close();
		return re;
	}

	public static int update_product(String product_name, String category, String quality, String main_img,
			String sub_img) {
		SqlSession session = factory.openSession();
		HashMap map = new HashMap();
		map.put("product_name", product_name);
		map.put("category", category);
		map.put("quality", quality);
		map.put("main_img", main_img);
		map.put("sub_img", sub_img);
		int re = session.update("product.update_product", map);
		session.close();
		return re;
	}

	public static int updateCondition_product(int id, String condition) {
		SqlSession session = factory.openSession();
		HashMap map = new HashMap();
		map.put("id", id);
		map.put("condition", condition);
		int re = session.update("product.updateCondition_product", map);
		session.close();
		return re;
	}

	public static int updateAdmin_product(String category, String product_name, String condition, String quality,
			int price) {
		SqlSession session = factory.openSession();
		HashMap map = new HashMap();
		map.put("category", category);
		map.put("product_name", product_name);
		map.put("condition", condition);
		map.put("quality", quality);
		map.put("price", price);
		int re = session.update("product.updateAdmin_product", map);
		session.close();
		return re;
	}

	public static int delete_product(int product_id) {

		SqlSession session = factory.openSession();
		int re = session.delete("product.delete_product", product_id);
		session.commit();
		session.close();
		return re;
	}
}
