package action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.InteriorDao;
import dao.MemberDao;
import vo.interiorReviewVo;

public class InteriorReviewFormAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		InteriorDao iDao = new InteriorDao();
		String conName = request.getParameter("conName");
		interiorReviewVo iReviewVo = iDao.getInteriorReviewVo(conName);
		System.out.println(iReviewVo == null);
		
		
		
		request.setAttribute("conName", conName);
		request.setAttribute("iReviewVo", iReviewVo);
		request.getRequestDispatcher("interior_review.jsp").forward(request, response);

	}

}
