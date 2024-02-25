package action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ProductDao;
import vo.ProductDetailImgVo;
import vo.ProductDetailVo;
import vo.ProductMainImgVo;
import vo.ProductOption1Vo;
import vo.ProductVo;

public class ProductDetailAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int productIdx = Integer.parseInt(request.getParameter("product_idx"));   // ex. 3

		ProductDao pDao = new ProductDao();
		ProductVo pVo = pDao.getProductVoByProductIdx(productIdx);
		ProductDetailVo pDetailVo = pDao.getProductDetailVoByProductIdx(productIdx);
		String categoryStr = pDao.getCategoryStringFromCategoryIdx(pVo.getCategory()); // ex. "가구>서랍·수납장>수납장"
		String[] arrCategoryStr = categoryStr.split(">");  // ex. ["가구","서랍·수납장","수납장"]
		ArrayList<ProductMainImgVo> listProductMainImgVo = pDao.getListProductMainImgVo(productIdx);
		ArrayList<ProductDetailImgVo> listProductDetailImgVo = pDao.getListProductDetailImgVo(productIdx);
		
		String strOption1Text = pDao.getOption1Name(productIdx);
		ArrayList<ProductOption1Vo> listProductOption1Vo = pDao.getListProductOption1Vo(productIdx);
		
		int danIlOptionIdx = pDao.getDanIlOptionIdxFromProductIdx(productIdx);  

		int likeCount = pDao.getLikeyCountByProductIdx(productIdx);
		int reviewCount = pDao.getCountReviewByProductIdx(productIdx);
		
		request.setAttribute("productIdx", productIdx);
		request.setAttribute("pVo", pVo);
		request.setAttribute("pDetailVo", pDetailVo);
		request.setAttribute("arrCategoryStr", arrCategoryStr);
		request.setAttribute("listProductMainImgVo", listProductMainImgVo);
		request.setAttribute("listProductDetailImgVo", listProductDetailImgVo);
		request.setAttribute("strOption1Text", strOption1Text);
		request.setAttribute("listProductOption1Vo", listProductOption1Vo);
		request.setAttribute("danIlOptionIdx", danIlOptionIdx);
		request.setAttribute("likeCount", likeCount);
		request.setAttribute("reviewCount", reviewCount);
		
		request.getRequestDispatcher("product_detail.jsp").forward(request, response);
	}

}
