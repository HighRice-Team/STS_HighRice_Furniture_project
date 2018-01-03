package com.bit_fr.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.bit_fr.dao.ProductDao;

@Controller
public class ProductController {

	@Autowired
	private ProductDao dao;

	public void setDao(ProductDao dao) {
		this.dao = dao;
	}
	
	@RequestMapping("/index.do")
	public ModelAndView main() {
		ModelAndView mav = new ModelAndView();

		mav.addObject("viewPage", "index.jsp");
		mav.setViewName("main");
		
		return mav;
	}
	
	
}
