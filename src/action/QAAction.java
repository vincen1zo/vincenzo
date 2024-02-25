package action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.QADao;
import vo.QAMainVo;
import vo.QAVo;

public class QAAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String paramCategory = request.getParameter("category");
		if(paramCategory==null) paramCategory="전체";
		
		QADao qADao = new QADao();
		//ArrayList<QAVo> listQA = qADao.getQaAll();
		ArrayList<QAVo> listQA = qADao.getQaByCategory(paramCategory);
		ArrayList<QAMainVo> listQAMain = qADao.getQaMain();
		
		request.setAttribute("paramCategory", paramCategory);
		request.setAttribute("listQA", listQA);
		request.setAttribute("listQAMain", listQAMain);
		request.getRequestDispatcher("QA.jsp").forward(request, response);
	}
	
}
