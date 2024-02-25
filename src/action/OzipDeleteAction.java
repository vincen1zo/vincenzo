package action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.OMainDao;

public class OzipDeleteAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int ozipIdx = Integer.parseInt(request.getParameter("ozipIdx"));
		OMainDao omDao  = new OMainDao();
		omDao.OzipDelete(ozipIdx);
		
		request.setAttribute("msg", "삭제되었습니다.");
		request.getRequestDispatcher("Ozip_delete_action_result.jsp").forward(request, response);
	}
	
}
