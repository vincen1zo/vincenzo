package action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LikeyAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*
		  HttpSession session = Request.getSession(); String email =
		  request.getSession("loginEmail");
		 */
		request.getRequestDispatcher("likey.jsp").forward(request, response);
	}

}
