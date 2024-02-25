package action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.HousepartyDao;
import vo.HousepartyCommentVo;
import vo.HousepartyDetailVo;
import vo.HousepartyPicWriteVo;

public class HousepartyDetailAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HousepartyDao hDao = new HousepartyDao();
		int housepartyIdx = Integer.parseInt(request.getParameter("houseparty_idx"));
		HousepartyDetailVo hppVo = hDao.getHousepartyPostVoByHousepartyIdx(housepartyIdx);
		ArrayList<HousepartyPicWriteVo> listHousepartyPicWriteVo = hDao.getListHousepartyPicWriteVo(housepartyIdx);
		String[] arrSmallTalk = hDao.getArrSmallTalkHacksim(housepartyIdx);
		ArrayList<HousepartyCommentVo> listHousepartyComment = hDao.getListHousepartyCommentByHousepartyIdx(housepartyIdx);

		request.setAttribute("housepartyIdx", housepartyIdx);
		request.setAttribute("hppVo", hppVo);
		request.setAttribute("listHousepartyPicWriteVo", listHousepartyPicWriteVo);
		request.setAttribute("arrSmallTalk", arrSmallTalk);
		request.setAttribute("listHousepartyComment", listHousepartyComment);
		request.getRequestDispatcher("houseparty_detail.jsp").forward(request, response);
		
	}

}
