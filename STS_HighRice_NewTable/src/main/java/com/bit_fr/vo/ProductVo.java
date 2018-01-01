package com.bit_fr.vo;

public class ProductVo {
	private int product_id;
	private String condition;
	private String product_name;
	private String category;
	private String quality;
	private int price;
	private String main_img;
	private String sub_img;
	private String member_id;
	private int rownum;

	// Setter
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public void setQuality(String quality) {
		this.quality = quality;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public void setMain_img(String main_img) {
		this.main_img = main_img;
	}

	public void setSub_img(String sub_img) {
		this.sub_img = sub_img;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public void setRownum(int rownum) {
		this.rownum = rownum;
	}

	// Getter
	public int getProduct_id() {
		return product_id;
	}

	public String getCondition() {
		return condition;
	}

	public String getProduct_name() {
		return product_name;
	}

	public String getCategory() {
		return category;
	}

	public String getQuality() {
		return quality;
	}

	public int getPrice() {
		return price;
	}

	public String getMain_img() {
		return main_img;
	}

	public String getSub_img() {
		return sub_img;
	}

	public String getMember_id() {
		return member_id;
	}

	public int getRownum() {
		return rownum;
	}

	// Constructor

	public ProductVo() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ProductVo(int product_id, String condition, String product_name, String category, String quality, int price,
			String main_img, String sub_img, String member_id, int rownum) {
		super();
		this.product_id = product_id;
		this.condition = condition;
		this.product_name = product_name;
		this.category = category;
		this.quality = quality;
		this.price = price;
		this.main_img = main_img;
		this.sub_img = sub_img;
		this.member_id = member_id;
		this.rownum = rownum;
	}

}
