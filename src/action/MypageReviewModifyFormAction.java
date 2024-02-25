package action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MypageReviewDao;
import vo.MypageReviewByReviewIdxVo;

public class MypageReviewModifyFormAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int reviewIdx = Integer.parseInt(request.getParameter("review_idx"));
		
		MypageReviewDao rDao = new MypageReviewDao();
		MypageReviewByReviewIdxVo MypageReviewVo = rDao.getWriteReviewVoByReviewIdx(reviewIdx);
		
//		request.setAttribute("reviewIdx", reviewIdx);
		request.setAttribute("MypageReviewVo", MypageReviewVo);
		request.getRequestDispatcher("mypage_review_modify").forward(request, response);
	}

}
