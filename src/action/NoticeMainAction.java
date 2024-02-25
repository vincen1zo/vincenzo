package action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.NoticeDao;
import vo.NoticeVo;

public class NoticeMainAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		NoticeDao nDao = new NoticeDao();
		ArrayList<NoticeVo> listNoticeVo = nDao.getNoticeList();
		
		request.setAttribute("listNoticeVo", listNoticeVo);
		request.getRequestDispatcher("Notice.jsp").forward(request, response);
	}
	
}
