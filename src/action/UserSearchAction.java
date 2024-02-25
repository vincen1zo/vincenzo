/*
 * package action;
 * 
 * import java.io.IOException; import java.util.ArrayList;
 * 
 * import javax.servlet.ServletException; import
 * javax.servlet.http.HttpServletRequest; import
 * javax.servlet.http.HttpServletResponse; import
 * javax.servlet.http.HttpSession;
 * 
 * import dao.CommunityMainDao; import dao.MemberDao; import vo.UserSearchVo;
 * 
 * public class UserSearchAction implements Action {
 * 
 * @Override public void execute(HttpServletRequest request, HttpServletResponse
 * response) throws ServletException, IOException { MemberDao mDao = new
 * MemberDao();
 * 
 * HttpSession session = request.getSession(); String loginEmail =
 * (String)session.getAttribute("loginEmail"); String loginId =
 * mDao.getMemberId(loginEmail); String searchUser =
 * request.getParameter("search_user");
 * 
 * CommunityMainDao cmDao = new CommunityMainDao(); ArrayList<UserSearchVo>
 * listUserSearchVo = cmDao.getUserBySearch(loginId, searchUser);
 * request.setAttribute("listUserSearchVo", listUserSearchVo);
 * request.getRequestDispatcher("community_main.jsp").forward(request,
 * response); }
 * 
 * }
 */
