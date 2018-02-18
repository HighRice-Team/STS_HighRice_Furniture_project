package com.bit_fr.controller;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resources;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
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
import com.bit_fr.vo.OrderlistVo;
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
	
	@Scheduled(cron="0 0 0 * * *")
	public void pro() {
//		스케쥴링 내용적기
	}
	
	@RequestMapping("admin/deliveryInfo.do")
	public void deliveryInfo() {
		
	}
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate);

		return "home";
	}
	
	@RequestMapping("/myPage.do")
	public ModelAndView goMyPage(HttpSession session, @RequestParam(value = "min", defaultValue = "1") int min,String selectedMyPage) {
		ModelAndView mav = new ModelAndView();

		String member_id = (String) session.getAttribute("id");
		MemberVo member = memberDao.getOne_member(member_id);
		
		List<OrderlistVo>recentList = orderlistDao.getMyRecentlyOrder_orderlist(member_id);
		if(recentList.size()!=0) {
			mav.addObject("recentList", recentList);
			mav.addObject("chkRecentList", "ok");
		}else {
			mav.addObject("chkRecentList", null);
		}

		int max = min + 3;

		int rent1 = orderlistDao.getCountToMyCondition_orderlist(member_id, "입금완료");
		int rent2 = orderlistDao.getCountToMyCondition_orderlist(member_id, "대여중");
		int rent3 = orderlistDao.getCountToMyCondition_orderlist(member_id, "배송중");
		int rent4 = orderlistDao.getCountToMyCondition_orderlist(member_id, "반납");

		int total = productDao.getMySellCount_product(member_id);
		List<ProductVo> list = productDao.getMySellForPaging_product(member_id);

		mav.addObject("member", member);
		mav.addObject("rent1", rent1);
		mav.addObject("rent2", rent2);
		mav.addObject("rent3", rent3);
		mav.addObject("rent4", rent4);
		mav.addObject("total", total);
		mav.addObject("list", list);
		
		mav.addObject("selectedMyPage", selectedMyPage);
		mav.addObject("len", list.size());

		mav.addObject("viewPage", "myPage.jsp");

		mav.setViewName("main");

		return mav;
	}
	
	@RequestMapping(value = "/aboutus.do")
	public ModelAndView goAboutus() {
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("viewPage","aboutUs.jsp" );
		mav.setViewName("main");
		
		return mav;
	}
	
	@RequestMapping(value = "/faq.do")
	public ModelAndView goFAQ() {
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("viewPage","faq.jsp" );
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

	@RequestMapping("/admin.do")
	public ModelAndView admin() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("main");
		mav.addObject("viewPage", "admin/adminPage.jsp");

		return mav;
	}

	@RequestMapping(value = "/admin_product.do", produces="text/plain; charset=utf-8")
	@ResponseBody
	public String admin_product(ProductVo v) {
		String str = "";
		System.out.println(v);
		
		List<ProductVo> list = productDao.getAll_productAdmin(v);

		ObjectMapper mapper = new ObjectMapper();
		
		try {
			str = mapper.writeValueAsString(list);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}

		return str;
	}

	@RequestMapping(value = "/admin_orderlist.do", produces="text/plain; charset=utf-8")
	@ResponseBody
	public String admin_orderlist(OrderlistVo v) {
		String str = "";
		
		List<OrderlistVo> list = orderlistDao.getAll_orderlist(v);
		List<OrderlistVo> list2 = new ArrayList<OrderlistVo>();
		
		for(OrderlistVo vo : list) {
			vo.setPay_date(vo.getPay_date().substring(0,10)); 
			vo.setRent_start(vo.getRent_start().substring(0,10)); 
			vo.setRent_end(vo.getRent_end().substring(0,10)); 
			
			list2.add(vo);
		}
		
		ObjectMapper mapper = new ObjectMapper();

		try {
			str = mapper.writeValueAsString(list2);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}

		return str;
	}

	@RequestMapping(value = "/admin_member.do", produces="text/plain; charset=utf-8")
	@ResponseBody
	public String admin_member(MemberVo m) {
				
		String str = "";
		List<MemberVo> list = memberDao.getAll_member(m);
		ObjectMapper mapper = new ObjectMapper();
			
		try {
			str = mapper.writeValueAsString(list);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}

		return str;
	}

	@RequestMapping(value = "/adminUpdate_product.do", produces="text/plain; charset=utf-8")
	@ResponseBody
	public String adminUpdate_product(ProductVo p) {
		String str = "";

		int re = productDao.updateAdmin_product(p);

		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(re);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}

		return str;
	}

	@RequestMapping("/adminUpdate_orderlist.do")
	@ResponseBody
	public String adminUpdate_orderlist(OrderlistVo o) {
		String str = "";

		return str;
	}

	@RequestMapping(value = "/adminUpdate_member.do", produces="text/plain; charset=utf-8")
	@ResponseBody
	public String adminUpdate_member(MemberVo m) {
		String str = "";

		int re = memberDao.updateInfo_member(m);

		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(re);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}

		return str;
	}
	
	@RequestMapping(value = "/updateResetPwd_member.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String updateResetPwd_member(String member_id) {
		String str = "";
		ObjectMapper om = new ObjectMapper();
		int re = memberDao.updateResetPwd_member(member_id);

		try {
			 str = om.writeValueAsString(re);
		} catch (Exception e) {
			System.out.println(e);
		}
		return str;
	}
	
	@RequestMapping(value = "sellCompliate_product.do", produces="text/plain; charset=UTF-8")
	@ResponseBody
	public String sellCompliate_product(ProductVo p) {
		String str = "";	
		int rent_month = orderlistDao.getRentMonth_orderlist(p.getMember_id(), p.getProduct_id());
		
		if(rent_month == -1) {
			str = rent_month+"";
			return str;
		}
		int payback = (p.getPrice()*rent_month)/10;
		
		int re = memberDao.updatePayback_member(p.getMember_id(), payback);
		
		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(re);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}
		
		return str;
	}
	@RequestMapping(value = "getPwd_q.do", produces="text/plain; charset=UTF-8")
	@ResponseBody
	public String getPwd_q() {
		String str = "";
		List<String> list = memberDao.getPwd_q();
		ObjectMapper mapper = new ObjectMapper();
		try {
			mapper.writeValueAsString(list);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}
		
		return str;
	}
	

}
