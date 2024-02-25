package action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import dao.InteriorDao;

public class AjaxReviewLikeAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String memberId = request.getParameter("member_id");
		int reviewIdx = Integer.parseInt(request.getParameter("review_idx"));
		InteriorDao iDao = new InteriorDao();
		// 1. count
		
		boolean likeOrNot = iDao.getReviewLikeOrNot(memberId, reviewIdx);
		
		String result = "";
		// --> true --> Do delete.
		if(likeOrNot) {
			iDao.deleteReviewLike(memberId, reviewIdx);
			result = "DELETED";
		} else {
		// --> false -> Do insert.
			iDao.insertReviewLike(memberId, reviewIdx);
			result = "INSERTED";
		}
		
		// response(json object)
		// response data.result -> "DELETED", "INSERTED"
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json"); // MIME 타입 //MIME : 전세계표준으로 여러가지가 정해져있음
		PrintWriter out = response.getWriter(); 
		JSONObject obj = new JSONObject(); // vo같은애,json에서 담아주면 자바스크립트에서 사용할수있음
		obj.put("result",result );
		
		out.println(obj); // --> obj > obj.toString(); // JSON이 만들어져서 담아서 보내 어디로? ExAjax2.jsp에서 vo로!

	}

}

