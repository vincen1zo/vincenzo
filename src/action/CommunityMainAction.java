package action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CategoryBestDao;
import dao.CommunityMainDao;
import dao.MemberDao;
import dao.ODealDao;
import dao.ProductDao;
import vo.HomeMainHpVo;
import vo.ODealVo;
import vo.ProductAllVo;
import vo.ProductMainImgVo;
import vo.ProductVo;
import vo.UserInteriorReviewVo;

public class CommunityMainAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	 	CommunityMainDao cmDao = new CommunityMainDao();
	 	CategoryBestDao cgbDao = new CategoryBestDao();
	 	ODealDao odDao = new ODealDao();
	 	ProductDao pdDao = new ProductDao();
		ArrayList<HomeMainHpVo> listHomeMainHpVo = cmDao.getAllHomeMainHpVo();
		ArrayList<UserInteriorReviewVo> listUserInteriorReviewVo = cmDao.getListUserInteriorReviewVo();
		ArrayList<ODealVo> listODealVo = odDao.getODealVoByProductIdx();
		ArrayList<ProductAllVo> listProductAllVo = cgbDao.getAllProductAllVoList();
		
		HttpSession session = request.getSession();
		String loginEmail = (String) session.getAttribute("loginEmail");
		MemberDao mDao = new MemberDao();
		String loginId =  mDao.getMemberId(loginEmail);

		request.setAttribute("listHomeMainHpVo", listHomeMainHpVo);
		request.setAttribute("listUserInteriorReviewVo", listUserInteriorReviewVo);
		request.setAttribute("listODealVo", listODealVo);
		request.setAttribute("listProductAllVo", listProductAllVo);
		
		request.getRequestDispatcher("community_main.jsp").forward(request, response);
	}

}
