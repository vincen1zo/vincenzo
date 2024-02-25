package action;

import java.io.IOException;//내가죽거든 
import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDao;

public class CreateAccountAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("CreateAccountAction에 들어옴");
		String email = request.getParameter("email");
		String password = request.getParameter("pw");
		String memberId = request.getParameter("memberId");
		ArrayList<Integer> agreeList = new ArrayList<Integer>();
		for(int i=1; i<=5; i++) {
			if(request.getParameter("agree"+i) == null) {
				agreeList.add(0);
			} else {
				agreeList.add(Integer.parseInt(request.getParameter("agree"+i)));
			}
		}
//		int agree1 = Integer.parseInt(request.getParameter("agree1"));
//		int agree2 = Integer.parseInt(request.getParameter("agree2"));
//		int agree3 = Integer.parseInt(request.getParameter("agree3"));
//		int agree4 = Integer.parseInt(request.getParameter("agree4"));
//		int agree5 = Integer.parseInt(request.getParameter("agree5"));
		System.out.println(agreeList + "끝나가냐?");
		MemberDao mDao = new MemberDao();
		mDao.createAccount(memberId, email, password, agreeList);
		
		request.setAttribute("msg", "가입되었습니다. 다시 로그인 해주세요.");
		request.getRequestDispatcher("Create_account_Result.jsp").forward(request, response);
	}
	
}
