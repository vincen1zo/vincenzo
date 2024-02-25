package action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.BasketDao;
import dao.MemberDao;
import vo.BasketVo;

public class BascketAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		MemberDao mDao = new MemberDao();
		String loginEmail = (String)session.getAttribute("loginEmail");
		String memberId = mDao.getMemberId(loginEmail);
		
		
		BasketDao bDao = new BasketDao();
		 ArrayList<BasketVo> listBasket = bDao.getlistBasket(memberId); 
		
		
		request.setAttribute("memberId", memberId);
		request.setAttribute("listBasket", listBasket);
		request.getRequestDispatcher("basket.jsp").forward(request, response);

	}

}
