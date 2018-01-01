package com.bit_fr.vo;

import java.util.Date;

public class Board_QnaVo {
	private String board_id;
	private String title;
	private String member_id;
	private int product_id;
	private Date regdate;
	private String content;
	private int b_ref;
	private int b_level;

	// Setter
	public void setBoard_id(String board_id) {
		this.board_id = board_id;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public void setB_ref(int b_ref) {
		this.b_ref = b_ref;
	}

	public void setB_level(int b_level) {
		this.b_level = b_level;
	}

	// Getter
	public String getBoard_id() {
		return board_id;
	}

	public String getTitle() {
		return title;
	}

	public String getMember_id() {
		return member_id;
	}

	public int getProduct_id() {
		return product_id;
	}

	public Date getRegdate() {
		return regdate;
	}

	public String getContent() {
		return content;
	}

	public int getB_ref() {
		return b_ref;
	}

	public int getB_level() {
		return b_level;
	}

	// Constructor
	public Board_QnaVo(String board_id, String title, String member_id, int product_id, Date regdate, String content,
			int b_ref, int b_level) {
		super();
		this.board_id = board_id;
		this.title = title;
		this.member_id = member_id;
		this.product_id = product_id;
		this.regdate = regdate;
		this.content = content;
		this.b_ref = b_ref;
		this.b_level = b_level;
	}

	public Board_QnaVo() {
		super();
		// TODO Auto-generated constructor stub
	}

}
