package com.bit_fr.vo;

import java.util.Date;

public class OrderlistVo {
	private int order_id;
	private String member_id;
	private int product_id;
	private String pay_date;
	private String rent_start;
	private String rent_end;
	private int rent_month;
<<<<<<< HEAD
	
=======
	// page Vo
	private int rnum;
>>>>>>> branch 'master' of https://github.com/HighRice-Team/STS_HighRice_Furniture_project.git

<<<<<<< HEAD
	// Setter
	public void setOrder_id(int order_id) {
		this.order_id = order_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public void setPay_date(String pay_date) {
		this.pay_date = pay_date;
	}
	public void setRent_start(String rent_start) {
		this.rent_start = rent_start;
	}
	public void setRent_end(String rent_end) {
		this.rent_end = rent_end;
	}
	public void setRent_month(int rent_month) {
		this.rent_month = rent_month;
	}
	// Getter
=======
	// Join product
	private String product_name;
	private String main_img;
	private String price;
	// product_id
	private int pr;
	// condition
	private String con;

	// getter

>>>>>>> branch 'master' of https://github.com/HighRice-Team/STS_HighRice_Furniture_project.git
	public int getOrder_id() {
		return order_id;
	}
	public String getMember_id() {
		return member_id;
	}
	public int getProduct_id() {
		return product_id;
	}
	public String getPay_date() {
		return pay_date;
	}
	public String getRent_start() {
		return rent_start;
	}
	public String getRent_end() {
		return rent_end;
	}
	public int getRent_month() {
		return rent_month;
	}

<<<<<<< HEAD

	// Constructor
	public OrderlistVo(int order_id, String member_id, int product_id, String pay_date, String rent_start,
			String rent_end, int rent_month) {
=======
	public int getRnum() {
		return rnum;
	}

	public String getProduct_name() {
		return product_name;
	}

	public String getMain_img() {
		return main_img;
	}

	public String getPrice() {
		return price;
	}

	public int getPr() {
		return pr;
	}

	public String getCon() {
		return con;
	}

	// setter

	public void setOrder_id(int order_id) {
		this.order_id = order_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public void setPay_date(Date pay_date) {
		this.pay_date = pay_date;
	}

	public void setRent_start(Date rent_start) {
		this.rent_start = rent_start;
	}

	public void setRent_end(Date rent_end) {
		this.rent_end = rent_end;
	}

	public void setRent_month(int rent_month) {
		this.rent_month = rent_month;
	}

	public void setRnum(int rnum) {
		this.rnum = rnum;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public void setMain_img(String main_img) {
		this.main_img = main_img;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public void setPr(int pr) {
		this.pr = pr;
	}

	public void setCon(String con) {
		this.con = con;
	}

	// constructor

	public OrderlistVo(int order_id, String member_id, int product_id, Date pay_date, Date rent_start, Date rent_end,
			int rent_month, int rnum, String product_name, String main_img, String price, int pr, String con) {
>>>>>>> branch 'master' of https://github.com/HighRice-Team/STS_HighRice_Furniture_project.git
		super();
		this.order_id = order_id;
		this.member_id = member_id;
		this.product_id = product_id;
		this.pay_date = pay_date;
		this.rent_start = rent_start;
		this.rent_end = rent_end;
		this.rent_month = rent_month;
		this.rnum = rnum;
		this.product_name = product_name;
		this.main_img = main_img;
		this.price = price;
		this.pr = pr;
		this.con = con;
	}
	public OrderlistVo() {
		super();
	}
}
