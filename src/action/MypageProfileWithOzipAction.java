package action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDao;
import vo.MPOzipVo;
import vo.MypageProfileHousePartyVo;
import vo.MypageProfileMemberInfoVo;

public class MypageProfileWithOzipAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("loginEmail");
//		if(email==null) {
//			request.getRequestDispatcher("Mypage_profile_all.jsp").forward(request, response);
//		}
		MemberDao mDao = new MemberDao();
		String memberId = mDao.getMemberId(email);
		ArrayList<MPOzipVo> listMPOzipVo = mDao.getMemberProfileWithOzip(memberId);
		//하우스 파티 idx, 커버이미지, 타이틀, 멤버아이디, 
		ArrayList<MypageProfileHousePartyVo> listMPPHouseParty = mDao.getMapageProfileHouseParty(memberId);
		//내정보
		ArrayList<MypageProfileMemberInfoVo> listMPPMemberInfo = mDao.getMypageProfileMemberInfo(memberId);
		
		request.setAttribute("listMPOzipVo", listMPOzipVo);
		request.setAttribute("listMPPHouseParty", listMPPHouseParty);
		request.setAttribute("listMPPMemberInfo", listMPPMemberInfo);
		request.getRequestDispatcher("Mypage_profile_all.jsp").forward(request, response);
	}

}
