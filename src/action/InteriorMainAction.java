package action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.InteriorDao;
import vo.InteriorMainVo;

public class InteriorMainAction implements Action {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		double lat = 0.0;
		double lng = 0.0;
		try {
			lat = Double.parseDouble(request.getParameter("lat"));
			lng = Double.parseDouble(request.getParameter("lng"));
		} catch(Exception e) { }
		
		InteriorDao iDao = new InteriorDao();
		
		ArrayList<InteriorMainVo> mainlist2 = null;
		if(lat==0.0 || lng==0.0) {
			mainlist2 = iDao.getListInteriorMainVo();
		} else {
			System.out.println("!!");
			mainlist2 = iDao.getListInteriorMainVoNearBy(lat, lng);
		}
		
		request.setAttribute("mainlist", mainlist2);
		request.getRequestDispatcher("interior_main.jsp").forward(request, response);
	}

}
 