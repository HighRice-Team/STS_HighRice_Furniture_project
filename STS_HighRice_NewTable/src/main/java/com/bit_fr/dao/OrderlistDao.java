package com.bit_fr.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bit_fr.db.OrderlistManager;
import com.bit_fr.vo.OrderlistVo;

@Repository
public class OrderlistDao {

	public int getCheckExist_orderlist(String member_id, int product_id) {
		return OrderlistManager.getCheckExist_orderlist(member_id, product_id);
	}

	public int getCountNextOrderId_orderlist() {
		return OrderlistManager.getCountNextOrderId_orderlist();
	}

	public int getCountToMyCondition_orderlist(String member_id, String condition) {
		return OrderlistManager.getCountToMyCondition_orderlist(member_id, condition);
	}

	public List<OrderlistVo> getAll_orderlist() {
		return OrderlistManager.getAll_orderlist();
	}

	public List<OrderlistVo> getMyOrderlistToCondition_orderlist(String member_id, String condition) {
		return OrderlistManager.getMyOrderlistToCondition_orderlist(member_id, condition);
	}

	public int getCountMyOrderToCondition_orderlist(String member_id, String condition) {
		return OrderlistManager.getCountMyOrderToCondition_orderlist(member_id, condition);
	}

	public List<OrderlistVo> getAllMyOrder_orderlist(String member_id) {
		return OrderlistManager.getAllMyOrder_orderlist(member_id);
	}

	// Controller 에서 order_id 가 dao.getNUM_NextOrderID 으로 받아와짐.
	public int insert_orderlist(OrderlistVo v) {
		return OrderlistManager.insert_orderlist(v);
	}

	public int updateRentMonth_orderlist(String member_id, int product_id, int rent_month) {
		return OrderlistManager.updateRentMonth_orderlist(member_id, product_id, rent_month);
	}

	// Controller 에서 order_id 가 dao.getNUM_NextOrderID 으로 받아와짐.
	public int updateRentEnd_orderlist(int order_id) {
		return OrderlistManager.updateRentEnd_orderlist(order_id);
	}

	public int delete_orderlist(String member_id, int product_id) {
		return OrderlistManager.delete_orderlist(member_id, product_id);
	}

}
