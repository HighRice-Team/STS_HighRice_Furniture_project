package com.bit_fr.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bit_fr.db.ProductManager;
import com.bit_fr.vo.ProductVo;

@Repository
public class ProductDao {
	public List<ProductVo> selectAll(){
		return ProductManager.selectAll();
	}
	
	public ProductVo selectOne(int id) {
		return ProductManager.selectOne(id);
	}
	
	public List<ProductVo> selectAllByCondition(){
		return ProductManager.selectAllByCondition();
	}
	
	public int getXXXCount(String condition) {
		return ProductManager.getXXXCount(condition);		
	}
	
	public int getXXXCount(String category, String condition) {
		return ProductManager.getXXXCount(category, condition);
	}
	
	public int nextNextId() {
		return ProductManager.nextNextId();
	}
	
	//자료형 모르겠는 부분
//	public int nextNextId() {
//		return ProductManager.nextNextId();
//	}
	
	public int getCount() {
		return ProductManager.getCount();
	}
	
	public int insertProduct(ProductVo p) {
		return ProductManager.insertProduct(p);
	}
	
	public int updateCondition(int id, String condition) {
		return ProductManager.updateCondition(id, condition);
	}
	
	public int updateProduct(String product_name, String category, String quality, String main_img, String sub_img) {
		return ProductManager.updateProduct(product_name, category, quality, main_img, sub_img);
	}

	public int updateAdmin(String category, String product_name, String condition, String quality, int price) {
		return ProductManager.updateAdmin(category, product_name, condition, quality, price);		
	}
	
	public int deleteProduct(int id) {
		return ProductManager.deleteProduct(id);
	}
	
	//모르겠는 부분 처리 못함(매퍼 내)
}
