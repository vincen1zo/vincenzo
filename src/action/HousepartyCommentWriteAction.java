package action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.HousepartyDao;
import dao.MemberDao;

public class HousepartyCommentWriteAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String memberId = request.getParameter("member_id");
		int housepartyIdx = Integer.parseInt(request.getParameter("houseparty_idx"));
		String comment = request.getParameter("comment");
		
		HttpSession session = request.getSession();
		String loginEmail = (String) session.getAttribute("loginEmail");
		MemberDao mDao = new MemberDao();
		String loginId =  mDao.getMemberId(loginEmail);
		
		HousepartyDao hDao = new HousepartyDao();
		hDao.writeComment(memberId, housepartyIdx, comment);
		
		response.sendRedirect("Controller?command=houseparty_detail&houseparty_idx=" + housepartyIdx);
	}

}
