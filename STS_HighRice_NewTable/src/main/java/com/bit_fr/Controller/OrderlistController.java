package com.bit_fr.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.bit_fr.dao.OrderlistDao;

@Controller
public class OrderlistController {

	@Autowired
	private OrderlistDao dao;

	public void setDao(OrderlistDao dao) {
		this.dao = dao;
	}
	
	
}
