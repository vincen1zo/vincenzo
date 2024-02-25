package action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDao;
import vo.MypageShoppingListVo;
import vo.MypageShoppingPrequestVo;

public class MypageShoppingForm implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String email = (String)session.getAttribute("loginEmail");
		MemberDao mDao = new MemberDao();
		String memberId = mDao.getMemberId(email);
		
		System.out.println(memberId);
		ArrayList<MypageShoppingListVo> listRet = mDao.getMypageShoppingList(memberId);
		//상품문의
		ArrayList<MypageShoppingPrequestVo> PListRet = mDao.getMypageShoppingPrequest(memberId);
		//주문문의
		
		
		request.setAttribute("listRet", listRet);
		request.getRequestDispatcher("Mypage_shopping.jsp").forward(request, response);
	}

}
