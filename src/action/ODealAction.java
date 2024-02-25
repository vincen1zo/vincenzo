package action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ODealDao;
import dao.ProductDao;
import vo.ODealVo;

public class ODealAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ODealDao odDao = new ODealDao();
		ArrayList<ODealVo> listODVo = odDao.getODealVoByProductIdx();
		
		request.setAttribute("listODVo", listODVo);
		request.getRequestDispatcher("o_deal.jsp").forward(request, response);
	}
}
