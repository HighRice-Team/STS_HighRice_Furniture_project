package com.bit_fr.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit_fr.dao.MemberDao;
import com.bit_fr.vo.MemberVo;
//import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class MemberController {

	@Autowired
	private MemberDao member_dao;

	public void setDao(MemberDao dao) {
		this.member_dao = dao;
	}

	// 단순 뷰페이지 이동
	@RequestMapping("/joinAccess.do")
	public ModelAndView gotoJoinAccess() {
		ModelAndView mav = new ModelAndView("main");

		mav.addObject("viewPage", "join/joinAccess.jsp");

		return mav;
	}

	@RequestMapping(value = "/joinCheck.do", method = RequestMethod.GET)
	public ModelAndView gotoJoinCheck() {
		ModelAndView mav = new ModelAndView("main");

		mav.addObject("viewPage", "join/joinCheck.jsp");

		return mav;
	}

	// Select
	@RequestMapping(value = "/logout.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String logout(HttpSession session) {
		String str = "";

		session.invalidate();

		return str;
	}

	@RequestMapping(value = "/login.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String login(MemberVo v, HttpSession session) {
		String str = "";

		MemberVo v2 = member_dao.getOne_member(v.getMember_id());

		String input_pwd = v.getPwd();

		if (v2 != null && !v2.equals("")) {

			String pwd = v2.getPwd();
			if (pwd.equals(input_pwd)) {
				str = "1";
				session.setAttribute("needToLogin", null);
				session.setAttribute("id", v.getMember_id());
				session.setAttribute("grade", v2.getGrade());
				session.setAttribute("pwd", v2.getPwd());

			} else {
				str = "0";
			}
		} else {
			str = "-1";
		}

		return str;
	}

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

	@RequestMapping(value = "/getOne_member_ajax.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String getOne_member_ajax(String member_id) {

		String str = "";
		MemberVo m = member_dao.getOne_member(member_id);
		try {
			ObjectMapper mapper = new ObjectMapper();
			str = mapper.writeValueAsString(m);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}

		return str;
	}

	@RequestMapping(value = "/getId_member.do", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String getId_member(MemberVo v) {
		String str = "";

		if (member_dao.getId_member(v) != null && !member_dao.getId_member(v).equals("")) {
			str = member_dao.getId_member(v);
		}

		return str;
	}

	@RequestMapping("/getCount_member.do")
	public ModelAndView getCount_member() {
		ModelAndView mav = new ModelAndView();
		mav.addObject("countMember", member_dao.getCount_member());

		return mav;
	}

	// Insert

	@RequestMapping(value = "/insert_member.do", method = RequestMethod.GET)
	public ModelAndView goToInsertMember(MemberVo v) {
		ModelAndView mav = new ModelAndView("main");

		mav.addObject("viewPage", "join/insert_member.jsp");
		mav.addObject("v", v);

		return mav;
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

	// Update은 Ajax을 이용.

	@RequestMapping(value = "/updateResetPwd_member.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String updateResetPwd_member(String member_id) {
		String str = "";
		// ObjectMapper om = new ObjectMapper();
		int re = member_dao.updateResetPwd_member(member_id);

		try {
			// str = om.writeValueAsString(re);
		} catch (Exception e) {
			System.out.println(e);
		}
		return str;
	}

	@RequestMapping(value = "/changePwdChk.do", produces = "text/plain; charset=utf-8")
	@ResponseBody
	public String changePwdChk(HttpSession session, String old_pwd, String input_pwd, String input_pwd2) {
		String id = (String) session.getAttribute("id");
		MemberVo memberVo = member_dao.getOne_member(id);

		String str = "";
		String pwd = memberVo.getPwd();

		if (input_pwd.equals(input_pwd2)) {
			if (old_pwd.equals(pwd)) {
				str = "일치";
			} else {
				str = "비밀번호가 일치하지 않습니다.";
			}
		} else {
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

	@RequestMapping(value = "/updatePwd_member.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String updatePwd_member(MemberVo v) {
		String str = "";
		// ObjectMapper om = new ObjectMapper();

		int re = member_dao.updatePwd_member(v);

		try {
			// str = om.writeValueAsString(re);
		} catch (Exception e) {
			System.out.println(e);
		}
		return str;
	}

	@RequestMapping(value = "/updateInfo_member.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String updateInfo_member(MemberVo v, HttpSession session) {
		String str = "";
		ObjectMapper om = new ObjectMapper();
		String member_id = (String) session.getAttribute("id");
		v.setMember_id(member_id);
		int re = member_dao.updateInfo_member(v);

		try {
			str = om.writeValueAsString(re);
		} catch (Exception e) {
			System.out.println(e);
		}
		return str;
	}

	@RequestMapping(value = "/getMemberInfoAjax.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String getMemberInfoAjax(HttpSession session) {
		String str = "";
		String member_id = (String) session.getAttribute("id");

		MemberVo v = member_dao.getOne_member(member_id);

		ObjectMapper mapper = new ObjectMapper();

		try {

			str = mapper.writeValueAsString(v);

		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}

		return str;
	}

	@RequestMapping(value = "/updateMemberOkAjax.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String updateMemberOkAjax(HttpSession session, String j_pwd, String pwd_chk, MemberVo v, String address1,
			String address2, String address3) {
		String str = "";
		// 주소에대한 Vo 삽입이변경되어야함..

		String pwd = (String) session.getAttribute("pwd");
		String input_pwd = j_pwd;
		String input_pwd2 = pwd_chk;

		if (input_pwd.equals(input_pwd2)) {
			v.setAddress(address1 + " " + address2);
			v.setAddress_detail(address3);

			String member_id = (String) session.getAttribute("id");
			v.setMember_id(member_id);

			if (input_pwd.equals(pwd)) {

				member_dao.updateInfo_member(v);

				str = "회원정보 변경 완료";

			} else {
				str = "비밀번호 오류.";
			}
		} else {
			str = "입력한 두 비밀번호가 일치하지 않습니다.";
		}

		return str;
	}

	@RequestMapping(value = "/pwdChk.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String pwdChk(HttpSession session, String pwd, String pwd2) {
		String member_id = (String) session.getAttribute("id");
		MemberVo memberVo = member_dao.getOne_member(member_id);

		String str = "";
		String db_pwd = memberVo.getPwd();

		if (pwd.equals(pwd2)) {
			if (db_pwd.equals(pwd)) {
				str = "일치";
			} else {
				str = "비밀번호가 일치하지 않습니다.";
			}
		} else {
			str = "입력한 두 번호가 일치하지 않습니다.";
		}

		return str;
	}

}
