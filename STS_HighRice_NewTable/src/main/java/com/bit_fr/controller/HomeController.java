package com.bit_fr.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit_fr.dao.MemberDao;
import com.bit_fr.dao.OrderlistDao;
import com.bit_fr.dao.ProductDao;
import com.bit_fr.vo.MemberVo;
import com.bit_fr.vo.ProductVo;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	private MemberDao memberDao;

	@Autowired
	private ProductDao productDao;

	@Autowired
	private OrderlistDao orderlistDao;

	public void setMemberDao(MemberDao memberDao) {
		this.memberDao = memberDao;
	}

	public void setProductDao(ProductDao productDao) {
		this.productDao = productDao;
	}

	public void setOrderlistDao(OrderlistDao orderlistDao) {
		this.orderlistDao = orderlistDao;
	}

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate);

		return "home";
	}

	@RequestMapping("myPage.do")
	public ModelAndView goMyPage(HttpSession session, @RequestParam(value = "min", defaultValue = "1") int min) {
		ModelAndView mav = new ModelAndView();
		
		String member_id = (String)session.getAttribute("id");
		MemberVo member = memberDao.getOne_member(member_id);

		int max = min + 3;

		int rent1 = orderlistDao.getCountToMyCondition_orderlist(member_id, "입금완료");
		int rent2 = orderlistDao.getCountToMyCondition_orderlist(member_id, "대여중");
		int rent3 = orderlistDao.getCountToMyCondition_orderlist(member_id, "배송중");
		int rent4 = orderlistDao.getCountToMyCondition_orderlist(member_id, "반납");

		// int rent1 = productDao.getMySellCountWithCondition_product(member_id,
		// "입금완료");
		// int rent2 = productDao.getMySellCountWithCondition_product(member_id, "대여중");
		// int rent3 = productDao.getMySellCountWithCondition_product(member_id, "베송중");
		// int rent4 = productDao.getMySellCountWithCondition_product(member_id, "반납");
		//
		int total = productDao.getMySellCount_product(member_id);
		List<ProductVo> list = productDao.getMySellForPaging_product(member_id, min, max);

		mav.addObject("member", member);
		mav.addObject("rent1", rent1);
		mav.addObject("rent2", rent2);
		mav.addObject("rent3", rent3);
		mav.addObject("rent4", rent4);
		mav.addObject("total", total);
		mav.addObject("list", list);
		mav.addObject("len", list.size());
		mav.addObject("min", min);

		mav.addObject("viewPage", "myPage.jsp");

		mav.setViewName("main");

		return mav;
	}
	
	@RequestMapping(value = "/sellWrite.do")
	public ModelAndView sellWrite() {
		ModelAndView mav = new ModelAndView();

		mav.addObject("viewPage", "sell/sellWrite.jsp");
		mav.setViewName("main");

		return mav;
	}

	@RequestMapping(value = "/orderlistByCondition.do")
	public ModelAndView orderlistByCondition() {
		ModelAndView mav = new ModelAndView();

		mav.addObject("viewPage", "orderlist/orderlistByCondition.jsp");
		mav.setViewName("main");

		return mav;
	}

	
	@RequestMapping("admin.do")
	public ModelAndView admin(){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("main");
		mav.addObject("viewPage", "admin/adminPage.jsp");
		
		int page = 10;
		
		int totalRecord_product = productDao.getCount_product();
		int totalRecord_orderList = orderlistDao.getCountNextOrderId_orderlist() -1;
		int totalRecord_member = memberDao.getCount_member();
		
		int totalPage_product = totalRecord_product/page;
		if(totalRecord_product%page != 0 ){
			totalPage_product++;
		}
		
		mav.addObject("listProduct", productDao.getAll_product(null));
		mav.addObject("totalPage_product", totalPage_product);
		
		mav.addObject("listOrder", orderlistDao.getAll_orderlist());
		mav.addObject("listMember", memberDao.getAll_member());
		
		
		return mav;
	}
	

}