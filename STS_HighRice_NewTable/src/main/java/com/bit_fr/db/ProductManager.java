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
	
	public static List<ProductVo> selectAll() {
		SqlSession session = factory.openSession();
		List<ProductVo> list = session.selectList("product.selectAll_product");
		session.close();
		return list;
	}
	
	public static ProductVo selectOne(int id) {
		SqlSession session = factory.openSession();
		ProductVo p = (ProductVo) session.selectList("product.selectOne_product", id);
		session.close();
		return p;
	}
	
	public static List<ProductVo> selectSell(String member_id){
		SqlSession session = factory.openSession();
		List<ProductVo> list = session.selectList("product.selectSell_product", member_id);
		session.close();
		return list;
	}
	
	//min, max 값이 무엇인지 모르겠는 부분
	public static List<ProductVo> selectAllByCondition() {
		SqlSession session = factory.openSession();
		List<ProductVo> list = session.selectList("product.selectAll_product");
		session.close();
		return list;
	}
	
	// 상태 미상 1
	public static int getXXXCount(String condition) {
		SqlSession session = factory.openSession();
		int re = session.selectOne("product.getXXXCount_product");
		session.close();
		return re;
	}
	
	// 상태 미상 2
	public static int getXXXCount(String category, String condition) {
		SqlSession session = factory.openSession();
		HashMap map = new HashMap();
		map.put("category", category);
		map.put("condition", condition);
		
		int re = session.selectOne("product.getXXXCount_product", map);
		session.close();
		return re;
	}
	
	public static int nextNextId() {
		SqlSession session = factory.openSession();
		int n = session.selectOne("product.getNextId");
		session.close();
		return n;
	}
	
/* 자료형 모르겠는 부분	
	public static ??????????? {
		SqlSession session = factory.openSession();
		int n = session.selectOne("product.getNextId");
		session.close();
		return n;
	}
*/
	
	public static int getCount() {
		SqlSession session = factory.openSession();
		int re = session.selectOne("product.getCount_product");
		session.close();
		return re;
	}
	
	public static int insertProduct(ProductVo p) {
		SqlSession session = factory.openSession();
		int re = session.insert("product.insert_product", p);
		session.close();
		return re;
	}
	
	public static int updateCondition(int id, String condition) {
		SqlSession session = factory.openSession();
		HashMap map = new HashMap();
		map.put("id", id);
		map.put("condition", condition);
		int re = session.update("product.updateCondition_product", map);
		session.close();
		return re;
	}
	
	public static int updateProduct(String product_name, String category, String quality, String main_img, String sub_img) {
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
	
	public static int updateAdmin(String category, String product_name, String condition, String quality, int price) {
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
	
	public static int deleteProduct(int id) {
		SqlSession session = factory.openSession();
		int re = session.delete("product.delete_product", id);
		session.close();
		return re;
	}
	
	// 모르겠는 부분 처리 못함(매퍼 내)
}
