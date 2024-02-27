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
		response.setContentType("application/json");
		PrintWriter out = response.getWriter(); 
		JSONObject obj = new JSONObject(); 
		obj.put("result",result );
		
		out.println(obj); 

	}

}

