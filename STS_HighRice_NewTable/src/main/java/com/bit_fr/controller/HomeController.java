package com.bit_fr.controller;

import java.text.DateFormat;
import java.util.ArrayList;
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
	private OrderlistDao orderlistDao;
	
	@Autowired
	private ProductDao productDao;
	

	public void setProductDao(ProductDao productDao) {
		this.productDao = productDao;
	}

	public void setOrderlistDao(OrderlistDao orderlistDao) {
		this.orderlistDao = orderlistDao;
	}

	public void setMemberDao(MemberDao memberDao) {
		this.memberDao = memberDao;
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
	public ModelAndView goMyPage(HttpSession session, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
//		String member_id = (String)session.getAttribute("member_id");
		String member_id = "lasah";
		MemberVo member = memberDao.getOne_member(member_id);
		
		int min = 1;
		if (request.getParameter("min") != null && !request.getParameter("min").equals("")) {
			min = Integer.parseInt(request.getParameter("min"));
		}
		int max = min + 3;
		
		int rent1 = orderlistDao.getCountToMyCondition_orderlist(member_id, "입금완료");
		int rent2 = orderlistDao.getCountToMyCondition_orderlist(member_id, "배송중");
		int rent3 = orderlistDao.getCountToMyCondition_orderlist(member_id, "대여중");
		int rent4 = orderlistDao.getCountToMyCondition_orderlist(member_id, "반납");
		
		//int total = productDao.("select count(*) from product where member_id=" + "'" + member_id + "'");
		//List<ProductVo> list = productDao.selectAll();//(member_id, min, max);
		
		
		mav.addObject("member", member);
		mav.addObject("rent1", rent1);
		mav.addObject("rent2", rent2);
		mav.addObject("rent3", rent3);
		mav.addObject("rent4", rent4);
		//mav.addObject("total", total);
		//mav.addObject("list", list);
		//mav.addObject("len", list.length())
		
		mav.addObject("viewPage", "myPage.jsp");
		
		mav.setViewName("main");
		
		return mav;
	}
	
	@RequestMapping(value = "sellWrite.do")
	public ModelAndView sellWrite() {
		ModelAndView mav =  new ModelAndView();
		
		mav.addObject("viewPage", "sell/sellWrite.jsp");
		mav.setViewName("main");
		
		return mav;
	}
	
	@RequestMapping(value = "orderlistByCondition.do")
	public ModelAndView orderlistByCondition() {
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("viewPage", "orderlist/orderlistByCondition.jsp");
		mav.setViewName("main");
		
		return mav;
	}
	
	@RequestMapping("pwdChk.do")
	@ResponseBody
	public String pwdChk(HttpSession session, String old_pwd, String input_pwd, String input_pwd2) {
		String id = (String) session.getAttribute("id");
		MemberVo memberVo = memberDao.getOne_member(id);
		
		String str = "";
		String pwd = memberVo.getPwd();
		
		if(input_pwd.equals(input_pwd2)){
			if(old_pwd.equals(pwd))
			{
				str = "일치";
			}else{
				str = "비밀번호가 일치하지 않습니다.";
			}
		}else{
			str = "입력한 두 번호가 일치하지 않습니다.";
		}
		
		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(str);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return str;
	}
	
	@RequestMapping("updatePwdAjax.do")
	@ResponseBody
	public String updatePwdAjax(HttpSession session, String pwd) {
		String str = "";
		String member_id = (String)session.getAttribute("id");
		MemberVo v = new MemberVo();
		v.setMember_id(member_id);
		v.setPwd(pwd);
		
		int re = memberDao.updatePwd_member(v);
		
		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(re);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}
		
		return str;
	}
	
	
	
	
	
	
	
	
	
}