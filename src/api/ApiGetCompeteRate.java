package api;
import java.util.HashMap;
import java.util.Set;
import java.util.TreeSet;

import vo.AptSubscriptionDetailVo;

public class ApiGetCompeteRate {
	public static HashMap<String, String> map1 = null;

	public static HashMap<String, String> getAllHouseNameCompeteRate() throws Exception {
		HashMap<String, String> mapRet = new HashMap<String, String>();
		
		ApiAptSubscriptionDetail api2 = new ApiAptSubscriptionDetail();
		api2.request(1,  1817);
		
//		System.out.println(api2.listSubscriptionDetail.size());

		ApiAptSubscriptionCompeteRate api1 = new ApiAptSubscriptionCompeteRate();
		for(int i=1; i<=4; i++) {
			api1.request(i, 10000);
		}
//        System.out.println(api1.listCompeteRateVo.size());

        for(AptSubscriptionDetailVo vo : api2.listSubscriptionDetail) {
        	for(int i=0; i<=api1.listCompeteRateVo.size()-1; i++) {
        		if(api1.listCompeteRateVo.get(i).getHouseManageNo()==null) continue;
        		if(vo.getHouseManageNo() == Long.parseLong(api1.listCompeteRateVo.get(i).getHouseManageNo())) {
        			if("-".equals(api1.listCompeteRateVo.get(i).getCmpetRate())) 
        				continue;
        			mapRet.put(vo.getHouseNm() + "_" + api1.listCompeteRateVo.get(i).getHouseTy(), 
        						api1.listCompeteRateVo.get(i).getCmpetRate());
//        			System.out.println("[" + i + "] " + vo.getHouseManageNo() + " / " + vo.getHouseNm() 
//        						+ " / 순위:" + api1.listCompeteRateVo.get(i).getSubscrptRankCode()
//        						+ " / 평형:" + api1.listCompeteRateVo.get(i).getHouseTy() 
//        						+ " / 경쟁률:" + api1.listCompeteRateVo.get(i).getCmpetRate());
        		}
        	}
        }
        return mapRet;
	}
	public static void prepareCompeteRate() throws Exception {
		map1 = getAllHouseNameCompeteRate();
	}
	public static String getCompeteRateByHouseNm(String houseNm) throws Exception {
		TreeSet<String> setCompeteRates = new TreeSet<String>();
//		System.out.println(map1);

		Set<String> keySet = map1.keySet();
		for(String key : keySet) {
			if(key.startsWith(houseNm)) {
				String value = map1.get(key);
				if(value==null || value.equals("-")) continue;
				setCompeteRates.add(value);
			}
		}
//		for(String key : keySet) {
//			String value = map1.get(key);
//			if(value==null || value.equals("-")) continue;
//			setCompeteRates.add(value);
//		}

//		double min = setCompeteRates.first();
//		double max = setCompeteRates.last();
		
		return setCompeteRates.toString().replace("[","").replace("]","");
	}
}
