package action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDao;
import dao.MypageReviewDao;
import vo.MyWriteReviewVo;
import vo.MypageReviewVo;

public class MypageReviewFormAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String tab = request.getParameter("tab");  // ex. "2"
		if(tab==null) tab="1";
		
		HttpSession session = request.getSession();
		MemberDao mDao = new MemberDao();
		String loginEmail = "또랑이";
		//(String)session.getAttribute("loginEmail");
		String memberId = mDao.getMemberId(loginEmail);
	
		MypageReviewDao rDao = new MypageReviewDao();
		ArrayList<MypageReviewVo> listProductReview = rDao.getlistProductReviewVo(memberId);
		ArrayList<MyWriteReviewVo> listWriteReview = rDao.getListWriteReviewVo(memberId);
		
		
		request.setAttribute("memberId", memberId);
		request.setAttribute("listProductReview", listProductReview);
		request.setAttribute("listWriteReview", listWriteReview);
		request.setAttribute("tab",  tab);
		request.getRequestDispatcher("Mypage_review.jsp").forward(request, response);
		
	}

}
