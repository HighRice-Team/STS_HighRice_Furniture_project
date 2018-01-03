package com.bit_fr.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit_fr.dao.MemberDao;
import com.bit_fr.vo.MemberVo;
//import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class MemberController {

	@Autowired
	private MemberDao member_dao;

	public void setDao(MemberDao dao) {
		this.member_dao = dao;
	}

	//Select
	@RequestMapping("/getAll_member.do")
	public ModelAndView getAll_member() {
		ModelAndView mav = new ModelAndView();
		mav.addObject("list", member_dao.getAll_member());

		return mav;
	}

	@RequestMapping("/getOne_member.do")
	public ModelAndView getOne_member(String member_id) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("v", member_dao.getOne_member(member_id));

		return mav;
	}

	@RequestMapping("/getId_member.do")
	public ModelAndView getId_member(MemberVo v) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("member_id", member_dao.getId_member(v));

		return mav;
	}

	@RequestMapping("/getCount_member.do")
	public ModelAndView getCount_member() {
		ModelAndView mav = new ModelAndView();
		mav.addObject("countMember",member_dao.getCount_member());

		return mav;
	}

	//Insert
	
	@RequestMapping(value = "/insert_member.do", method = RequestMethod.GET)
	public void goToInsertMember() {
	}
	
	@RequestMapping(value = "/insert_member.do", method = RequestMethod.POST)
	public ModelAndView insert_member(MemberVo v) {
		ModelAndView mav = new ModelAndView(); // 성공 시 요청 할 내용 입력해야 함 . ex) main 화면
		int re = member_dao.insert_member(v);

		if (re != 1) // insert가 실패 했을 경우.
		{
			mav.addObject("msg", "insert_member 등록 실패.");
			mav.setViewName("fail");
		}

		return mav;
	}
	
	//Update은 Ajax을 이용.
	
	
	@RequestMapping(value="/updateResetPwd_member.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String updateResetPwd_member(String member_id)
	{
		String str = "";
//		ObjectMapper om = new ObjectMapper();
		int re = member_dao.updateResetPwd_member(member_id);
		
		try {
//			str = om.writeValueAsString(re);
		} catch (Exception e) {
			System.out.println(e);
		}
		return str;
	}
	
	@RequestMapping(value="/updatePwd_member.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String updatePwd_member(MemberVo v)
	{
		String str = "";
//		ObjectMapper om = new ObjectMapper();
		
		int re = member_dao.updatePwd_member(v);
		
		try {
//			str = om.writeValueAsString(re);
		} catch (Exception e) {
			System.out.println(e);
		}
		return str;
	}
	
	@RequestMapping(value="/updateInfo_member.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String updateInfo_member(MemberVo v)
	{
		String str = "";
//		ObjectMapper om = new ObjectMapper();
		
		int re = member_dao.updateInfo_member(v);
		
		try {
//			str = om.writeValueAsString(re);
		} catch (Exception e) {
			System.out.println(e);
		}
		return str;
	}
	
	
}
