package action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.HousepartyDao;

public class HousepartyCommentModifyAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int housepartyIdx = Integer.parseInt(request.getParameter("houseparty_idx"));
		int commentIdx = Integer.parseInt(request.getParameter("comment_idx"));
		String hpComment = request.getParameter("comment_modify");
		
		HousepartyDao hDao = new HousepartyDao();
		hDao.modifyComment(hpComment, housepartyIdx, commentIdx);
		
		request.getRequestDispatcher("Controller?command=houseparty_detail&houseparty_idx=" + housepartyIdx).forward(request, response);
	}
}
