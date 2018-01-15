package com.bit_fr.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit_fr.dao.MemberDao;
import com.bit_fr.dao.OrderlistDao;
import com.bit_fr.dao.ProductDao;
import com.bit_fr.vo.MemberVo;
import com.bit_fr.vo.OrderlistVo;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class OrderlistController {

	@Autowired
	private OrderlistDao orderlistDao;

	public void setOrderlistDao(OrderlistDao orderlistDao) {
		this.orderlistDao = orderlistDao;
	}

	@Autowired
	private MemberDao memberDao;

	public void setMemberDao(MemberDao memberDao) {
		this.memberDao = memberDao;
	}

	@Autowired
	private ProductDao productDao;

	public void setProductDao(ProductDao productDao) {
		this.productDao = productDao;
	}

	@RequestMapping(value = "/cartList.do", produces = "text/plain;charset=utf-8")
	public ModelAndView goCartList(HttpSession session, @RequestParam(defaultValue = "1") int pageNUM) {
		ModelAndView mav = new ModelAndView("main");

		int orderlistMAX = 10;
		int endNUM = pageNUM * orderlistMAX;
		int startNUM = endNUM - (orderlistMAX - 1);

		String member_id = (String) session.getAttribute("id");

		String sql = "select * from (" + "select rownum rnum,product_name,main_img,price,rent_month,pr,con "
				+ "from ( select product_name,main_img,price,rent_month,o.product_id pr,p.condition con from orderlist o,product p where o.product_id=p.product_id and o.member_id='"
				+ member_id + "' and p.condition='물품게시' order by order_id desc))";

		// SQL
		List<OrderlistVo> list = orderlistDao.getMyCartList_orderlist(sql);
		mav.addObject("len", list.size());

		int pageMAX = list.size() / orderlistMAX;
		if (list.size() % orderlistMAX != 0) {
			pageMAX++;
		}

		sql += "where rnum >= " + startNUM + " and rnum <= " + endNUM;

		list = orderlistDao.getMyCartList_orderlist(sql);

		// member_id 값에 따른 회원정보 가져오기.
		MemberVo mv = memberDao.getOne_member(member_id);
		// 회원의 주소
		String adr = "";
		adr += mv.getAddress();
		adr += " ";
		adr += mv.getAddress_detail();

		mav.addObject("adr", adr);
		mav.addObject("mv", mv);
		mav.addObject("list", list);
		mav.addObject("pageMAX", pageMAX);
		mav.addObject("viewPage", "cartList.jsp");

		return mav;
	}

	@RequestMapping(value = "/deleteOrderListAjax.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String deleteOrderListAjax(HttpSession session, int product_id) {
		String str = "";
		String member_id = (String) session.getAttribute("id");

		int re = orderlistDao.delete_orderlist(member_id, product_id);

		ObjectMapper mapper = new ObjectMapper();

		try {

			str = mapper.writeValueAsString(re);

		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}

		return str;
	}

	@RequestMapping(value = "/updateConditionOderlistAjax.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String updateOderlistAjax(HttpSession session, int product_id) {
		String member_id = (String) session.getAttribute("id");
		String str = "";

		// 멤버의 잔고 / 결제하기.
		System.out.println("d");
		String condition = "입금완료";
		int re = productDao.updateCondition_product(product_id, condition);

		ObjectMapper mapper = new ObjectMapper();

		try {

			str = mapper.writeValueAsString(re);

		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}

		return str;
	}

	@RequestMapping(value = "/updateRentPeriodOrderListAjax.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String updateRentPeriodOrderListAjax(HttpSession session, int rent_month, int product_id) {
		String str = "";
		String member_id = (String) session.getAttribute("id");

		int re = orderlistDao.updateRentMonth_orderlist(member_id, product_id, rent_month);

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
