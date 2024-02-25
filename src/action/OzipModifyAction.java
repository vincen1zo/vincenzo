package action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.OMainDao;

public class OzipModifyAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		int ozipIdx = Integer.parseInt(request.getParameter("ozipIdx"));
		String ozipTitle = request.getParameter("ozipTitle");
		String ozipDescription = request.getParameter("ozipDescription");
//		String ozipHashtag = request.getParameter("ozipHashtag");
//		String ozipImgUrl = request.getParameter("ozipImgUrl");
		OMainDao oMainDao = new OMainDao();
		oMainDao.ozipModify(ozipIdx, ozipTitle, ozipDescription);	//이미지 추가하기 나중에 ozipImgUrl 해쉬태그도
		
		request.getRequestDispatcher("Ozip_modify_action_result.jsp").forward(request, response);
	}
	
}
