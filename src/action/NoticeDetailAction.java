package action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.NoticeDao;
import vo.NoticeVo;

public class NoticeDetailAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
int ParamNoticeIdx = Integer.parseInt(request.getParameter("notice_idx"));
		
		NoticeDao nDao = new NoticeDao();
		NoticeVo voRet = nDao.getNoticeDetail(ParamNoticeIdx);
		
		request.setAttribute("voRet", voRet);
		RequestDispatcher rd = request.getRequestDispatcher("Notice_detail.jsp");
		rd.forward(request, response);
	}
	
}
