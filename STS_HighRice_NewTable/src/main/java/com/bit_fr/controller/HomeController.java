package com.bit_fr.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
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
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.bit_fr.dao.MemberDao;
import com.bit_fr.dao.OrderlistDao;
import com.bit_fr.dao.ProductDao;
import com.bit_fr.vo.MemberVo;
import com.bit_fr.vo.OrderlistVo;
import com.bit_fr.vo.ProductVo;
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
	public ModelAndView deliveryInfo(int order_id) {
		ModelAndView mav = new ModelAndView();
		OrderlistVo orderV = orderlistDao.getOne_orderlist(order_id);
		List<MemberVo> bitManList = memberDao.getBitMan_member();
		
		String bitSelect="<select name='bitman'>";
		
		for(MemberVo mv : bitManList) {
			bitSelect+= "<option value='"+mv.getName()+"'>"+mv.getName()+"</option>";
		}
		 bitSelect += "</select>";
		 
		 System.out.println(bitSelect);
		int product_id = orderV.getProduct_id();
		String member_id = orderV.getMember_id();
		MemberVo memberVo =  memberDao.getOne_member(member_id);
		
		mav.addObject("bitSelect",bitSelect);
		ProductVo productVo = productDao.getOne_product(product_id);
		
		mav.addObject("product_info",productVo);
		mav.addObject("orderlist_info",orderV);
		mav.addObject("member_info",memberVo);
		
		
		return mav;
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
	public ModelAndView sellWrite(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String member_id = (String)session.getAttribute("id");
		mav.addObject("viewPage", "sell/sellWrite.jsp");
		mav.addObject("member_id", member_id);
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

	//어드민에서 프로덕트 리스트를 불러오기 위한 ajax
	@RequestMapping(value = "/admin_product.do", produces="text/plain; charset=utf-8")
	@ResponseBody
	public String admin_product(ProductVo v) {
		String str = "";
		
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

	//어드민에서 오더리스트를 불러오기 위한 ajax
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

	//어드민에서 editing을 바로 하기 위한 ajax
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

	//맴버 업데이트를 위한 ajax
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
	
	//비밀번호 리셋을 위한 ajax
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
	
	//입금완료 된 상품을 배송하기 위한 ajax
	@RequestMapping(value = "sellCompliate_product.do", produces="text/plain; charset=UTF-8")
	@ResponseBody
	public String sellCompliate_product(int order_id, int price, String member_id) {
		
		
		String str = "";	
		
		int rent_month = orderlistDao.getRentMonth_orderlist(order_id);
	
		if(rent_month == -1) {
			str = rent_month+"";
			return str;
		}
		int payback = (price*rent_month)/10;
		
		int re = memberDao.updatePayback_member(member_id, payback);
		
		ObjectMapper mapper = new ObjectMapper();
		try {
//			str = mapper.writeValueAsString(re);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}
		
		return str;
	}
	
	//검수가 된 물품을 실제로 게시하기 위한 메소드
	@RequestMapping("adminSell_product.do")
	public ModelAndView adminSell_product(HttpServletRequest request, ProductVo p) {
		ModelAndView mav = new ModelAndView();
	
		String main_img = "";
		String sub_img = "";
		
		String path = request.getRealPath("/resources/img/product");
		String oldMain_img = p.getMain_img();
		String oldSub_img = p.getSub_img();
		int mainFsize = 0;
		int subFsize = 0;
		
		MultipartFile mainIMG = p.getMainIMG();
		MultipartFile subIMG = p.getSubIMG();
		
		if(mainIMG != null) {
			try {
				byte[] mainbyte = mainIMG.getBytes();
			
				main_img = mainIMG.getOriginalFilename();
				mainFsize = mainbyte.length;
				
				FileOutputStream mainfos = new FileOutputStream(path+"/"+main_img);
				mainfos.write(mainbyte);
				
				mainfos.close();
				
				if(!main_img.equals(oldMain_img)) {
					
					p.setMain_img(main_img);
					
					File file = new File(path+"/"+oldMain_img);
					file.delete();
				}
			
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		
		if(subIMG != null) {
			try {
				byte[] subbyte = subIMG.getBytes();
				sub_img = subIMG.getOriginalFilename();
				
				subFsize = subbyte.length;
				FileOutputStream subfos = new FileOutputStream(path+"/"+sub_img);
				
				subfos.write(subbyte);
				subfos.close();
				
				if(!sub_img.equals(oldSub_img)) {
					p.setSub_img(sub_img);
					
					File file = new File(path+"/"+oldSub_img);
					file.delete();
				}
				
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println(e);
			}
		}
		
		productDao.updateAdmin_product(p);
		mav.setViewName("redirect:/admin.do");
		
		return mav;
	}
}
