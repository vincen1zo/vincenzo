package action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CategoryBestDao;
import dao.MemberDao;
import dao.ProductDao;
import vo.ProductVo;

public class ShoppingMainAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cateName1 = request.getParameter("cate_name1");
		String cateName2 = request.getParameter("cate_name2");
		String cateName3 = request.getParameter("cate_name3");
		
		CategoryBestDao cabeDao = new CategoryBestDao();
		ProductDao pDao = new ProductDao();
		
		ArrayList<ProductVo> listProductVo = null;
		
		if(cateName1==null && cateName2==null && cateName3==null) {
			listProductVo = cabeDao.getAllProductVoList(); 
		} else {
			listProductVo =	cabeDao.getAllProductVoListByCateNames(cateName1, cateName2, cateName3);
		}
		
		request.setAttribute("listProductVo", listProductVo);
		
		request.getRequestDispatcher("shopping_main.jsp").forward(request, response);
	}
}