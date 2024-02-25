package action;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.MemberDao;
import dao.MypageReviewDao;
import vo.MypageReviewVo;

public class MypageReviewAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		MemberDao mDao = new MemberDao();
		String loginEmail = "또랑이";
		//(String)session.getAttribute("loginEmail");
		String memberId = mDao.getMemberId(loginEmail);
		
		
		
		
		
		
		//  upload 파일처리 
		request.setCharacterEncoding("utf-8");
		
		ServletContext application = request.getServletContext();
		String path = application.getRealPath("upload"); //upload 폴더의 절대경로.
		System.out.println("(참고) real path : " + path);
//				--------------------------------------------------	절대경로를 가져왔을뿐.
		
		
		File filePath = new File(path);
		if(!filePath.exists()) { // upload 폴더가 없으면.
			filePath.mkdirs(); // 폴더를 만듦.
		}
//				--------------------------------------------------	폴더를 가져왔을뿐.
		
		int sizeLimit = 100*1024*1024; //파일크기 제한설정 : 100MB.
		
		
		
		MultipartRequest multi = new MultipartRequest(
									request, // 요청객체
									path,	//파일저장경로(절대경로)
									sizeLimit, //파일최대크기
									"UTF-8",	// 파일명 한글깨짐 방지
									new DefaultFileRenamePolicy() // 기본적인 'rename 정책'
				);
		// -----------> MultipartRequest 객체가 생성될 때!!!! 파일 저장완료.
		
		//이제, 저장된 파일에 대한 정보(파일이름)를 MultipartRequest 객체로부터 뽑아냄. 
		//Enumeration > 옛날에 손가락으로 쓰던거
		//getFileNames > 여러개 파일등록
		Enumeration<?> files = multi.getFileNames();
		String fileObject = (String)files.nextElement();
		
		String filename = multi.getFilesystemName(fileObject); // 서버에 저장된 파일 이름
	//	filename = URLEncoder.encode(filename, "utf-8");
		System.out.println("file name : " + filename);   
		//(참고) multi.getOriginalFileName(fileObject) --> 웹브라우저에서 선택한 파일 이름.
		//(참고) multi.getFile(fileObject).length() ---> 업로드한 파일 크기
		
		int productIdx = Integer.parseInt(multi.getParameter("product_idx"));
		int durability = Integer.parseInt(multi.getParameter("durability"));
		int price = Integer.parseInt(multi.getParameter("price"));
		int design = Integer.parseInt(multi.getParameter("design"));
		int destination = Integer.parseInt(multi.getParameter("destination"));
		String reviewTextarea = multi.getParameter("review_textarea");
		int orderIdx = Integer.parseInt(multi.getParameter("order_idx"));
		int optionIdx = Integer.parseInt(multi.getParameter("option_idx"));
//		String imgUrl = multi.getParameter("img_url");
		String option1Value =multi.getParameter("option1_value");
		MypageReviewVo vo = new MypageReviewVo(memberId, orderIdx, productIdx, orderIdx, fileObject, reviewTextarea, filename, optionIdx, option1Value, option1Value);
		
		System.out.println(productIdx);
		System.out.println(durability + ", " + price + ", " + design + ", " + destination + " / " + reviewTextarea );
		System.out.println(filename);

		
		MypageReviewDao rDao = new MypageReviewDao();
		rDao.productReviewWrite(productIdx, memberId, option1Value, durability, price, design, destination, filename, reviewTextarea, orderIdx, optionIdx);

		request.getRequestDispatcher("Controller?command=mypage_review_form").forward(request, response);	
		//response.sendRedirect("Controller?command=mypage_review_form&tab=2"); 이걸로 바꿔도 되는지?
		
	}
}
