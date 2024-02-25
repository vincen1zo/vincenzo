package action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDao;

public class CreateAccountSnsAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		long kakaoId = 0;
		String profileImage = null;
		try {
			kakaoId = (Long)session.getAttribute("kakao_id");
			profileImage = (String)session.getAttribute("profile_image");
		} catch(Exception e) { }
		
		String email = request.getParameter("email"); 
//		String password = request.getParameter("pw");
		String memberId = request.getParameter("memberId");
		/* session.setAttribute("memberId", memberId); */
//		ArrayList<Integer> agreeList = new ArrayList<Integer>();
//		for(int i=1; i<=5; i++) {
//			agreeList.add(Integer.parseInt(request.getParameter("agree"+i)));
//		}
//		int agree1 = Integer.parseInt(request.getParameter("agree1"));
//		int agree2 = Integer.parseInt(request.getParameter("agree2"));
//		int agree3 = Integer.parseInt(request.getParameter("agree3"));
//		int agree4 = Integer.parseInt(request.getParameter("agree4"));
//		int agree5 = Integer.parseInt(request.getParameter("agree5"));
		
		MemberDao mDao = new MemberDao();
		/*if(kakaoId==0) {
			mDao.createAccount(memberId, email, password, agreeList);
		} else {*/
		mDao.createAccountWithKakao(memberId, email, /*password,  agreeList, */ profileImage, kakaoId);
			/* } */
		
		request.setAttribute("msg", "카카오 계정으로 가입되었습니다. 다시 로그인 해주세요.");
		request.getRequestDispatcher("Controller?command=login_form").forward(request, response);
	}

}
