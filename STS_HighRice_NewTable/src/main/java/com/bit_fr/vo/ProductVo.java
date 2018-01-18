package com.bit_fr.vo;

import org.springframework.web.multipart.MultipartFile;

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
	private int rnum;
	private MultipartFile mainIMG;
	private MultipartFile subIMG;
	
	// MyPage에서 내가 판 상품들의 가격 총액과 판매 건수를 저장할 변수
	private int total;
	private int cnt;
	public ProductVo(int product_id, String condition, String product_name, String category, String quality, int price,
			String main_img, String sub_img, String member_id, int rnum, MultipartFile mainIMG, MultipartFile subIMG,
			int total, int cnt) {
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
		this.rnum = rnum;
		this.mainIMG = mainIMG;
		this.subIMG = subIMG;
		this.total = total;
		this.cnt = cnt;
	}
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public String getCondition() {
		return condition;
	}
	public void setCondition(String condition) {
		this.condition = condition;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getQuality() {
		return quality;
	}
	public void setQuality(String quality) {
		this.quality = quality;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getMain_img() {
		return main_img;
	}
	public void setMain_img(String main_img) {
		this.main_img = main_img;
	}
	public String getSub_img() {
		return sub_img;
	}
	public void setSub_img(String sub_img) {
		this.sub_img = sub_img;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	public MultipartFile getMainIMG() {
		return mainIMG;
	}
	public void setMainIMG(MultipartFile mainIMG) {
		this.mainIMG = mainIMG;
	}
	public MultipartFile getSubIMG() {
		return subIMG;
	}
	public void setSubIMG(MultipartFile subIMG) {
		this.subIMG = subIMG;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public ProductVo() {
		super();
		// TODO Auto-generated constructor stub
	}

}
