package action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MypageReviewDao;

public class MypageReviewDeleteAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MypageReviewDao mDao = new MypageReviewDao();
		int reviewIdx = Integer.parseInt(request.getParameter("review_idx"));
		
		mDao.productReviewDelete(reviewIdx);
		
		response.sendRedirect("Controller?command=mypage_review_form&tab=2");
		//request.getRequestDispatcher("Controller?command=mypage_review_form&tab=2").forward(request, response);
	}
}
