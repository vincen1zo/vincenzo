package action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.HousepartyDao;
import vo.HousepartyVo;

public class HousepartyAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String paramFiltering = request.getParameter("filtering");
		if(paramFiltering == null) paramFiltering = "recent";
		
		HousepartyDao hDao = new HousepartyDao();
		ArrayList<HousepartyVo> listHouseparty = hDao.getAllHousepartyVoListSorted(paramFiltering);

		request.setAttribute("listHouseparty", listHouseparty);
		request.getRequestDispatcher("houseparty.jsp").forward(request, response);
	}
}
