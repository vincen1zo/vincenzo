package action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AptDao;
import dao.InteriorDao;
import vo.ConReviewVo;
import vo.AptConReviewVo;
import vo.AptReveiwPhotoVo;

public class AptReviewDetailAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int reviewIdx = Integer.parseInt(request.getParameter("reviewIdx"));
		
		AptDao aDao = new AptDao();
		AptConReviewVo ConReviewByReviewIdxVo = aDao.getConReviewVoByReviewIdxVo(reviewIdx);
		ArrayList<AptReveiwPhotoVo> listAptReviewPhoto = aDao.getListAptReviewPhoto(reviewIdx);
		
		request.setAttribute("ConReviewByReviewIdxVo", ConReviewByReviewIdxVo);
		request.setAttribute("listAptReviewPhoto", listAptReviewPhoto);
		request.getRequestDispatcher("apt_review_detail.jsp").forward(request, response);
	}

}
