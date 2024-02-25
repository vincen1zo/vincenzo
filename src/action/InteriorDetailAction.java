package action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.InteriorDao;
import vo.ConReviewListVo;
import vo.ConReviewVo;
import vo.HousepartySigongVo;
import vo.InteriorDetailSideVo;
import vo.InteriorInfoVo;
import vo.InteriorPhotoVo;

public class InteriorDetailAction implements Action {
	@Override
 	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		InteriorDao iDao = new InteriorDao();
		String conName = request.getParameter("conName");
		String tab = request.getParameter("tab");
		if(tab==null) tab="1";
		
		// 1) 인테리어 좌측
		InteriorDetailSideVo sideVo = iDao.getInteriorDetailSideVo(conName);
		
		// 2) 인테리어 좌측 별점평균 옆 오늘이집 계약 갯수
		int count = iDao.getContractCount(conName); 
		
		// 3) 계약자 리뷰
		ArrayList<ConReviewListVo> listConReviewListVo = iDao.getListConReviewVo(conName);
		
		// 4) 시공사례
		ArrayList<HousepartySigongVo> listSigong = iDao.getListHousepartySigongVo(conName);
		
		//5) 사진
		ArrayList<InteriorPhotoVo> listInteriorPhoto = iDao.getlistInteriorPhotoVo(conName);
		
		//6) 시공리뷰
		ArrayList<ConReviewVo> listConReview = iDao.getlistConReviewVo(conName);
		
		//7) 업체정보
		InteriorInfoVo getInfoVo = iDao.getInfoVo(conName);
		
		request.setAttribute("tab",  tab);
		request.setAttribute("conName", conName);
		request.setAttribute("sideVo", sideVo);
		request.setAttribute("count", count);
		request.setAttribute("listConReviewListVo", listConReviewListVo);
		request.setAttribute("listSigong", listSigong);
		request.setAttribute("listInteriorPhoto", listInteriorPhoto);
		request.setAttribute("listConReview", listConReview);
		request.setAttribute("getInfoVo", getInfoVo);
		request.getRequestDispatcher("interior_detail.jsp").forward(request, response);
	}

}

