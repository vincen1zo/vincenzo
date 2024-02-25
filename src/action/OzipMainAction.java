package action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.OMainDao;
import vo.OzipVo;

public class OzipMainAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
System.out.println("들어옴");
		String query = request.getParameter("query");		//검색 결과  : ex. "외관/외벽"
System.out.println(query);
		String[] arrQuery = null;
		if(query != null)
			arrQuery = query.split("/");    // ["외관", "외벽"]
		else
			arrQuery = new String[] {""};   // 이해 후 지우기) 요소 1개짜리 배열 생성, 첫 번째 요소 = 빈 문자열("").
		String paramSort = request.getParameter("sort");   // null, "recent", "popular", "comment"
		if(paramSort==null) paramSort="recent";
		
		OMainDao oMainDao = new OMainDao();
		ArrayList<OzipVo> listOzipVo = null;
		
		int pageNum = 1;
		try {
			pageNum = Integer.parseInt(request.getParameter("page"));
		} catch(NumberFormatException e) { }
		
		listOzipVo = oMainDao.getAllListSortedKeyword(pageNum, paramSort, arrQuery);
		int countAll = oMainDao.getCountAllListSortedKeyword(pageNum, paramSort, arrQuery);
//System.out.println("countAll : " + countAll);		마지막 페이지 확인
		int startPNum = 1;
		int endPNum = 10;
		//int lastPageNum = oMainDao.getLastPageNum(); // (삭제예정)
		int lastPageNum = countAll / 10 + (countAll%10>0 ? 1 : 0);
		
		request.setAttribute("listOzipVo", listOzipVo);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("startPNum", startPNum);
		request.setAttribute("endPNum", endPNum);
		request.setAttribute("lastPageNum", lastPageNum);
		request.setAttribute("arrQuery", arrQuery);
		
		request.getRequestDispatcher("Ozip_main.jsp").forward(request, response);
	}
	

}
