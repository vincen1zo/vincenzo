package action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDao;
import dao.newDao;
import vo.newVo;

public class NewAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		MemberDao mDao = new MemberDao();
		String loginEmail = (String)session.getAttribute("loginEmail");
		String memberId = mDao.getMemberId(loginEmail);
		
		newDao nDao = new newDao();
		ArrayList<newVo> listNew = nDao.getNewVo(memberId);
		
		request.setAttribute("memberId", memberId);
		request.setAttribute("listNew", listNew);
		request.getRequestDispatcher("new.jsp").forward(request, response);
	}

}
