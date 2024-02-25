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

@WebServlet("/PayInsertBasketServlet")
public class PayInsertBasketServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String orderStr = request.getParameter("order_str");
		String memberId = "뚱이";       // TODO : 세션으로부터 받아와야 돼!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!아아아아악!!!
		int productIdx = Integer.parseInt(request.getParameter("product_idx"));
		String payment = request.getParameter("payment");
		int totalPrice = Integer.parseInt(request.getParameter("total_price"));
		
		ProductDao pDao = new ProductDao();
		int orderIdx = pDao.insertBaroMirotic(memberId, productIdx, orderStr, payment, totalPrice);

		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONObject obj = new JSONObject();
		obj.put("result", 1);
		obj.put("order_idx", orderIdx);
		out.println(obj);
	}

}
