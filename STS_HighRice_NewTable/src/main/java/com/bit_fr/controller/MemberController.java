package com.bit_fr.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit_fr.dao.MemberDao;
import com.bit_fr.vo.MemberVo;
//import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class MemberController {
	
	@Autowired
	private JavaMailSender mailSender;
	

	public void setMailSender(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}


	@Autowired
	private MemberDao member_dao;

	public void setDao(MemberDao dao) {
		this.member_dao = dao;
	}
	
	//단순 뷰페이지 이동
	@RequestMapping("findMember.do")
	public ModelAndView gotofindMemberPage() {
		ModelAndView mav = new ModelAndView("main");
		
		mav.addObject("viewPage","join/findMember.jsp" );
		
		return mav;
	}
	
	@RequestMapping("search.do")
	public void goSearchAddress() {}
	
	@RequestMapping("joinAccess.do")
	public ModelAndView gotoJoinAccess() {
		ModelAndView mav = new ModelAndView("main");
		
		mav.addObject("viewPage","join/joinAccess.jsp");
		
		return mav;
	}
	
	@RequestMapping(value="joinCheck.do",method = RequestMethod.GET)
	public ModelAndView gotoJoinCheck() {
		ModelAndView mav = new ModelAndView("main");
		
		mav.addObject("viewPage","join/joinCheck.jsp");
		
		return mav;
	}

	//Select
	@RequestMapping(value="logout.do",produces="text/plain;charset=utf-8")
	@ResponseBody
	public String logout(HttpSession session) {
		String str="";
		
		session.invalidate();

		return str;
	}
	
	@RequestMapping(value="login.do",produces="text/plain;charset=utf-8")
	@ResponseBody
	public String login(MemberVo v,HttpSession session) {
		String str="";
		
		MemberVo v2 = member_dao.getOne_member(v.getMember_id());
		
		String input_pwd = v.getPwd();
	   
		if (v2 != null && !v2.equals("")) {
			
			String pwd = v2.getPwd();
			if(pwd.equals(input_pwd)) {
				str = "1";
				session.setAttribute("needToLogin", null);
				session.setAttribute("id", v.getMember_id());
				session.setAttribute("grade", v2.getGrade());
				session.setAttribute("pwd", v2.getPwd());
				
			}else {
				str = "0";
			}
		}else{
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
	
	@RequestMapping(value="/getOne_member.do",produces="text/plain;charset=utf-8")
	@ResponseBody
	public String getOne_member(String member_id) {
		String str="";
		MemberVo v =  member_dao.getOne_member(member_id);
		
		try {
			
			ObjectMapper om = new ObjectMapper();
			str = om.writeValueAsString(v);
			
		} catch (Exception e) {
			System.out.println(e);
		}

		return str;
	}

	@RequestMapping(value="getId_member.do",method = RequestMethod.POST,produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String getId_member(MemberVo v) {
		String str ="";
		
		if(member_dao.getId_member(v)!=null&&!member_dao.getId_member(v).equals(""))
		{
			str = member_dao.getId_member(v);
		}

		return str;
	}

	@RequestMapping("/getCount_member.do")
	public ModelAndView getCount_member() {
		ModelAndView mav = new ModelAndView();
		mav.addObject("countMember",member_dao.getCount_member());

		return mav;
	}

	//Insert
	
	@RequestMapping(value = "/insert_member.do", method = RequestMethod.GET)
	public ModelAndView goToInsertMember(MemberVo v) {
		ModelAndView mav = new ModelAndView("main");
		
		mav.addObject("viewPage","join/insert_member.jsp");
		mav.addObject("v",v);
//		String jumin = v.getJumin().substring(0, 6);
//		mav.addObject("jumin",jumin);
		
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
	
	
	@RequestMapping(value="sendMail.do",produces="text/plain;charset=utf-8")
	@ResponseBody
	public String mail(String member_id) {
		String str = "";
		System.out.println(member_id);
		SimpleMailMessage mailMessage = new SimpleMailMessage();
		mailMessage.setSubject("[BIT FR]비밀번호 안내.");
		mailMessage.setFrom("bitfr@naver.com");
		
		MemberVo v = member_dao.getOne_member(member_id);
		
		mailMessage.setText("귀하의 비밀번호는 < "+v.getPwd()+" > 입니다.");
		mailMessage.setTo(member_id);
		
		try {
			mailSender.send(mailMessage);
		} catch (Exception e) {
			System.out.println(e);
		}
		
		return str;
	}
	
	
}
