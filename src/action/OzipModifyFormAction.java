package action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.OMainDao;
import vo.OzipDetailVo;
import vo.OzipDetailVo2;

public class OzipModifyFormAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int ozipIdx = Integer.parseInt(request.getParameter("ozipIdx"));
		OMainDao omDao = new OMainDao();
//		OzipModifyVo vo = omDao.getOzipModifyByOzipIdx(ozipIdx);
		OzipDetailVo2 vo = omDao.ozipDetail2(ozipIdx);
		ArrayList<OzipDetailVo> listOzipDetailVo = omDao.ozipDetail1(ozipIdx);
		
		
		request.setAttribute("vo", vo);
		request.setAttribute("listOzipDetailVo", listOzipDetailVo);
		request.getRequestDispatcher("Ozip_modify_page.jsp").forward(request, response);
	}
	
}
