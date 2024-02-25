package action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.OMainDao;
import vo.OzipDetailVo;
import vo.OzipDetailVo2;
import vo.OzipReplyVo;

public class OzipDetailAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int ozipIdx = 0;
		HttpSession session = request.getSession();
		if(session.getAttribute("ozip_idx")==null)
			ozipIdx = Integer.parseInt(request.getParameter("ozip_idx"));
		else {
			ozipIdx = (Integer) session.getAttribute("ozip_idx");
		}
		OMainDao omDao = new OMainDao();
		ArrayList<OzipDetailVo> listOzipDetailVo = omDao.ozipDetail1(ozipIdx);
		OzipDetailVo2 vo = omDao.ozipDetail2(ozipIdx);
		ArrayList<OzipReplyVo> listOzipReplyVo = omDao.getReplyListByOzipIdx(ozipIdx);
		
		int commentPageNum = 1;
		try {
			commentPageNum = Integer.parseInt(request.getParameter("commentPage"));
		} catch(NumberFormatException e) { }
		int startCommentPNum = 1;
		int endCommentPNum = 10;
		int countAll = omDao.getCommentList(ozipIdx, commentPageNum);
		int lastcommentPageNum = countAll / 10 + (countAll%10>0 ? 1 : 0);
		
		
		request.setAttribute("commentPageNum", commentPageNum);
		request.setAttribute("lastcommentPageNum", lastcommentPageNum);
		request.setAttribute("startCommentPNum", startCommentPNum);
		request.setAttribute("endCommentPNum", endCommentPNum);
		
		request.setAttribute("vo", vo);
		request.setAttribute("listOzipDetailVo", listOzipDetailVo);
		request.setAttribute("listOzipReplyVo", listOzipReplyVo);
		RequestDispatcher rd = request.getRequestDispatcher("Ozip_detail_page.jsp");
		rd.forward(request, response);
	}
}
