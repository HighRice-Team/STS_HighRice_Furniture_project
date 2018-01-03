package com.bit_fr.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.bit_fr.dao.QnaBoardDao;

@Controller
public class QnaBoardController {

	@Autowired
	private QnaBoardDao dao;

	public void setDao(QnaBoardDao dao) {
		this.dao = dao;
	}
	
	
}
