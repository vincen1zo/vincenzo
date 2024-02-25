package action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AptDao;
import vo.AptDetailVo;
//import vo.AptDetailVo;
import vo.AptSigongConVo;
import vo.AptSigongReviewVo;
import vo.AptVo;

public class AptDetailAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int aptIdx = Integer.parseInt(request.getParameter("apt_idx"));
		
		AptDao aDao = new AptDao();
		AptVo aptVo = aDao.getAptVoByAptIdx(aptIdx);
		ArrayList<AptVo> listAptVoNearBy = aDao.getAptListNearby(aptVo.getLatitude(), aptVo.getLongitude());
		ArrayList<AptDetailVo> listAptDetail = aDao.getlistAptDetail(aptIdx);
		ArrayList<AptSigongReviewVo> listAptSigongReview = aDao.getlistAptSigongReview(aptIdx);
		ArrayList<AptSigongConVo> listAptSigongCon = aDao.getlistAptSigongCon(aptIdx);
		
		
		request.setAttribute("aptVo", aptVo);
		request.setAttribute("listAptVoNearBy", listAptVoNearBy);
		request.setAttribute("listAptDetail", listAptDetail);
		request.setAttribute("listAptSigongReview", listAptSigongReview);
		request.setAttribute("listAptSigongCon", listAptSigongCon);
		request.getRequestDispatcher("apt_detail.jsp").forward(request, response);

	}
}