package action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.OMainDao;

public class OzipWriteAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String ozipTitle = request.getParameter("OzipTitle");
		String ozipDescription = request.getParameter("OzipDescription");
		/* String memberId = (String) session.getAttribute("loginEmail"); */
		String memberId = (String) session.getAttribute("memberId");
		System.out.println("멤버 아이디 : " + memberId);
		
		OMainDao oMainDao = new OMainDao();
		oMainDao.ozipWrite(ozipTitle, ozipDescription, memberId);	//imgUrl 추가 해야돼
		request.getRequestDispatcher("Ozip_write_action_result.jsp").forward(request, response);
	}

}
