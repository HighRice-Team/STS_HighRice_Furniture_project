package com.bit_fr.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.bit_fr.dao.Board_QnADao;

@Controller
public class Board_QnAController {

	@Autowired
	private Board_QnADao dao;

	public void setDao(Board_QnADao dao) {
		this.dao = dao;
	}
	
	
}
