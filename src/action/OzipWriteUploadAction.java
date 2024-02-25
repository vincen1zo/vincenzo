package action;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.MemberDao;
import dao.OMainDao;

public class OzipWriteUploadAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ServletContext application = request.getServletContext();
		String path = application.getRealPath("upload"); //upload 폴더의 절대경로
		System.out.println("File Upload) real path : " + path);
		
		File filePath = new File(path);
		if(!filePath.exists()) {	//업로드 폴더가 없으면
			filePath.mkdirs();		//폴더를 만듦
		}
		
		int sizeLimit = 100*1024*1024;	//파일 크기 제한 설정 : 100MB
		
		MultipartRequest multi = new MultipartRequest(
									request,			//요청객체
									path,				//파일저장경로(절대경로)
									sizeLimit,			//파일최대 크기
									"UTF-8",			//파일명한글깨짐방지
									new DefaultFileRenamePolicy()	//기본적인 'rename'정책
				
		);
		
		int globalIdx = Integer.parseInt(multi.getParameter("global_idx"));
		System.out.println("globalIdx : " + globalIdx);
		
		ArrayList<String> listFilenamePre = new ArrayList<String>();
		ArrayList<String> listFilename = new ArrayList<String>();
		ArrayList<String> listDesc = new ArrayList<String>();
		
		Enumeration<?> files = multi.getFileNames()	;		//여러개의 파일을 업로드하기위해 Names
		while(files.hasMoreElements()) {
			String fileObject = (String)files.nextElement();
			String filename = multi.getFilesystemName(fileObject);	//서버에 저장된 파일이름
			System.out.println("filename : " + filename);
			listFilenamePre.add(filename);
		}
		for(int i=listFilenamePre.size()-1; i>=0; i--) {
			listFilename.add(listFilenamePre.get(i));
		}
		
		String title = multi.getParameter("OzipTitle");
		System.out.println("title : " + title);
		for(int i=1; i<=globalIdx; i++) {
			String desc = multi.getParameter("OzipDescription"+i);
			System.out.println("desc" + i + " : " + desc);
			if(desc!=null) listDesc.add(desc);
		}
		String hashtag = multi.getParameter("hashtag");
		System.out.println("hashtag : " + hashtag);
		
		HttpSession session = request.getSession();
		String loginEmail = (String) session.getAttribute("loginEmail");
		MemberDao mDao = new MemberDao();
		String loginId = mDao.getMemberId(loginEmail);
		
		// DB things...
		
		OMainDao omDao = new OMainDao();
		omDao.write(loginId, title, hashtag, listFilename, listDesc);
		
		request.getRequestDispatcher("Controller?command=Ozip_main").forward(request, response);
		//request.getRequestDispatcher("Ozip_write_action_result.jsp").forward(request, response);	
		
		
	}

}
