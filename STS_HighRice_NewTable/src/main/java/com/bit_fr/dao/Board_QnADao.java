package com.bit_fr.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bit_fr.db.Board_QnAManager;
import com.bit_fr.vo.Board_QnAVo;

@Repository
public class Board_QnADao {

	// 페이징처리와 관련된 변수

	// 한화면에 보여줄 게시물의 수
	public static int pageSIZE = 10;

	// 전체레코드 수
	public static int totalRecord = 0;

	// 전체페이지 수
	public static int totalPage = 1;

	public int update(Board_QnAVo b) {
		return Board_QnAManager.update(b);
	}

	public int nextNo() {
		return Board_QnAManager.nextNo();
	}

	public int insert(Board_QnAVo b) {
		return Board_QnAManager.insert(b);
	}

	public List<Board_QnAVo> list(int pageNUM, String writer, String my) {
		totalRecord = Board_QnAManager.getTotalRecord(writer, my);

		// 전체페이수를 계산하여 totalPage에 저장합니다.
		/*
		 * 한화면에 10개씩 보여주려고 합니다. 만약에 게시물의 수가 24개라면 전체페이지수는 3이어야 합니다.
		 * 
		 * totlaRecord/pageSIZE
		 * 
		 * 만약에 totalRecord % pageSIZE 0이 아니라면 1증가
		 */

		totalPage = (int) Math.ceil(totalRecord / (double) pageSIZE);

		/*
		 * totlaRecord / pageSIZE int int ==> 결과가 int 2
		 * 
		 * 
		 * 실수의 결과를 원한다면 둘중에 하나를 실수로 캐스팅하여 연산시킨다.
		 * 
		 * totalRecord / (double)pageSIZE ==> 결과가 double int double 2.4
		 * 
		 * 
		 * 무조건 그 수의 올림수를 취하기 위하여 Math.ceil(2.4) ===> 3.0 실수를 반환
		 * 
		 * (int)Math.ceil(2.4) 3.0 3
		 */

		return Board_QnAManager.list(pageNUM, writer, my);
	}

	public Object getBoard(int no) {
		// TODO Auto-generated method stub
		return Board_QnAManager.getBoard(no);
	}

	public int deleteBoard(int no) {
		// TODO Auto-generated method stub
		return Board_QnAManager.deleteBoard(no);
	}

	public void updateStep(int b_ref, int b_step) {
		// TODO Auto-generated method stub
		Board_QnAManager.updateStep(b_ref, b_step);
	}
}
