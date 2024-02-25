package action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.HousepartyDao;
import dao.MemberDao;

public class HousepartyCommentDeleteAction implements Action{
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int commentIdx = Integer.parseInt(request.getParameter("comment_idx"));
		HousepartyDao hDao = new HousepartyDao();
		hDao.deleteComment(commentIdx);
		System.out.println("댓글삭제가 완료되었습니다.");
		int housepartyIdx = Integer.parseInt(request.getParameter("houseparty_idx"));
		HttpSession session = request.getSession();
		String loginEmail = (String) session.getAttribute("loginEmail");
		MemberDao mDao = new MemberDao();
		String loginId =  mDao.getMemberId(loginEmail);

		response.sendRedirect("Controller?command=houseparty_detail&houseparty_idx=" + housepartyIdx);
	}
}