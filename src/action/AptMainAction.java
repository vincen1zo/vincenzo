package action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import api.ApiGetCompeteRate;
import dao.AptDao;
import vo.AptVo;

public class AptMainAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		double latitude = 37.5780547612815;
		double longitude = 126.92101916232;
		try {
			latitude = Double.parseDouble(request.getParameter("lat"));  // 위도
			longitude = Double.parseDouble(request.getParameter("lng")); // 경
		} catch(Exception e) { }
		
		AptDao aptDao = new AptDao();
		ArrayList<AptVo> listAptVo = aptDao.getAptListNearby(latitude, longitude);
		
		ArrayList<AptVo> listSubscription = aptDao.getSubscriptionListNearby(37.521598, 126.909336);
		HashMap<Integer, String> mapAptIdxCompeteRate = new HashMap<Integer, String>();
		try {
			ApiGetCompeteRate.prepareCompeteRate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		for(AptVo vo : listSubscription) {
			try {
				mapAptIdxCompeteRate.put(vo.getAptIdx(), ApiGetCompeteRate.getCompeteRateByHouseNm(vo.getName()));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		System.out.println(ApiGetCompeteRate.map1.size());  // 8740
		// ================================================================================


		System.out.println("AptMainAction에서 latitude : " + latitude);
		request.setAttribute("listAptVo", listAptVo);
		request.setAttribute("listSubscription", listSubscription);
		request.setAttribute("mapAptIdxCompeteRate", mapAptIdxCompeteRate);
		request.setAttribute("latitude", latitude);
		request.setAttribute("longitude", longitude);
		request.getRequestDispatcher("apt_main.jsp").forward(request, response);

	}

}
