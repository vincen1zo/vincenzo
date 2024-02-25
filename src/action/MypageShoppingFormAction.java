package action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDao;
import vo.MypageShoppingListVo;
import vo.MypageShoppingOrequestVo;
import vo.MypageShoppingPrequestVo;

public class MypageShoppingFormAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String email = (String)session.getAttribute("loginEmail");
		MemberDao mDao = new MemberDao();
		String memberId = mDao.getMemberId(email);
		
		System.out.println(memberId);
		ArrayList<MypageShoppingListVo> listRet = mDao.getMypageShoppingList(memberId);
		//상품문의  주문번호로 구분 null이면 상품문의 null이 아니면 주문문의
		ArrayList<MypageShoppingPrequestVo> PListRet = mDao.getMypageShoppingPrequest(memberId);
		//주문문의
		ArrayList<MypageShoppingOrequestVo> OListRet = mDao.getMypageShoppingOrequest(memberId);
		int[] arr = new int[8];
		for(MypageShoppingListVo vo : listRet) {
			if(vo.getProcessedState().equals("장바구니")) arr[0]++;
			if(vo.getProcessedState().equals("결제완료")) arr[1]++;
			if(vo.getProcessedState().equals("배송준비")) arr[2]++;
			if(vo.getProcessedState().equals("배송중")) arr[3]++;
			if(vo.getProcessedState().equals("배송완료")) arr[4]++;
			if(vo.getProcessedState().equals("구매확정")) arr[5]++; 
		}
		for(MypageShoppingPrequestVo prVo : PListRet) {arr[6] += prVo.getInquiryIdx();}
		for(MypageShoppingOrequestVo orVo : OListRet) {arr[7] += orVo.getInquiryIdx();}
System.out.println("arr[6] : " +arr[6]+ "arr[7]" + arr[7]);
		
		//구매상품 상태 카운트
		request.setAttribute("arr", arr);
		request.setAttribute("listRet", listRet);
		request.setAttribute("PListRet", PListRet);
		request.setAttribute("OListRet", OListRet);
		request.getRequestDispatcher("Mypage_shopping.jsp").forward(request, response);
	}

}
