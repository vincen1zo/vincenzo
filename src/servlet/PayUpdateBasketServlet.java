package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import dao.ProductDao;

@WebServlet("/PayUpdateBasketServlet")
public class PayUpdateBasketServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int orderIdx = Integer.parseInt(request.getParameter("order_idx"));
		ProductDao pDao = new ProductDao();
		pDao.updateMirotic(orderIdx);
		
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONObject obj = new JSONObject();
		obj.put("result", 1);
		out.println(obj);
	}

}
