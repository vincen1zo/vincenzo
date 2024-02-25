// AptDao 로부터 ...nearBy() 메서드를 사용해서, 현재 위치로부터 가까운 청약 목록 + 경쟁률 출력.
package api;


import java.util.ArrayList;

import dao.AptDao;
import vo.AptVo;

public class TestApi4 {
	public static void main(String[] args) throws Exception {
		// ================================================================================
		AptDao aDao = new AptDao();
		ArrayList<AptVo> listAptVo = aDao.getSubscriptionListNearby(37.521598, 126.909336);
		ApiGetCompeteRate.prepareCompeteRate();
		System.out.println(ApiGetCompeteRate.map1.size());  // 8740
		// ================================================================================
		
		System.out.println("listAptVo.size() : " + listAptVo.size());
		for(AptVo vo : listAptVo) {
			String s = ApiGetCompeteRate.getCompeteRateByHouseNm(vo.getName());
			System.out.println(vo.getName() + " = " + s);
		}
		
	}
}
