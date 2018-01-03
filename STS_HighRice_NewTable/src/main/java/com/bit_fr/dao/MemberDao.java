package com.bit_fr.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bit_fr.db.MemberManager;
import com.bit_fr.vo.MemberVo;

@Repository
public class MemberDao {
	public List<MemberVo> getAll_member() {
		return MemberManager.getAll_member();
	}

	public MemberVo getOne_member(String member_id) {
		return MemberManager.getOne_member(member_id);
	}

	public String getId_member(MemberVo v) {
		return MemberManager.getId_member(v);
	}

	public int getCount_member() {
		return MemberManager.getCount_member();
	}

	public int insert_member(MemberVo v) {
		return MemberManager.insert_member(v);
	}

	public int updateResetPwd_member(String member_id) {
		return MemberManager.updateResetPwd_member(member_id);
	}

	public int updatePwd_member(MemberVo v) {
		return MemberManager.updatePwd_member(v);
	}

	public int updateInfo_member(MemberVo v) {
		return MemberManager.updateInfo_member(v);
	}
}
