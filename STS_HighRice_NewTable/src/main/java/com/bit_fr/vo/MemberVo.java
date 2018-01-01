package com.bit_fr.vo;

public class MemberVo {
	private String member_id;
	private String pwd;
	private String name;
	private String tel;
	private String jumin;
	private String pwd_q;
	private String pwd_a;
	private String address;
	private String address_detail;
	private int payback;
	private String account_no;
	private String bank;
	private int balance;
	private String grade;

	// Setter
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public void setJumin(String jumin) {
		this.jumin = jumin;
	}

	public void setPwd_q(String pwd_q) {
		this.pwd_q = pwd_q;
	}

	public void setPwd_a(String pwd_a) {
		this.pwd_a = pwd_a;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public void setAddress_detail(String address_detail) {
		this.address_detail = address_detail;
	}

	public void setPayback(int payback) {
		this.payback = payback;
	}

	public void setAccount_no(String account_no) {
		this.account_no = account_no;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	public void setBalance(int balance) {
		this.balance = balance;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	// Getter
	public String getMember_id() {
		return member_id;
	}

	public String getPwd() {
		return pwd;
	}

	public String getName() {
		return name;
	}

	public String getTel() {
		return tel;
	}

	public String getJumin() {
		return jumin;
	}

	public String getPwd_q() {
		return pwd_q;
	}

	public String getPwd_a() {
		return pwd_a;
	}

	public String getAddress() {
		return address;
	}

	public String getAddress_detail() {
		return address_detail;
	}

	public int getPayback() {
		return payback;
	}

	public String getAccount_no() {
		return account_no;
	}

	public String getBank() {
		return bank;
	}

	public int getBalance() {
		return balance;
	}

	public String getGrade() {
		return grade;
	}

	// Constructor
	public MemberVo(String member_id, String pwd, String name, String tel, String jumin, String pwd_q, String pwd_a,
			String address, String address_detail, int payback, String account_no, String bank, int balance,
			String grade) {
		super();
		this.member_id = member_id;
		this.pwd = pwd;
		this.name = name;
		this.tel = tel;
		this.jumin = jumin;
		this.pwd_q = pwd_q;
		this.pwd_a = pwd_a;
		this.address = address;
		this.address_detail = address_detail;
		this.payback = payback;
		this.account_no = account_no;
		this.bank = bank;
		this.balance = balance;
		this.grade = grade;
	}

	public MemberVo() {
		super();
		// TODO Auto-generated constructor stub
	}

}
