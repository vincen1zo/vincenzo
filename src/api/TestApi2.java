// https://api.odcloud.kr/api/ApplyhomeInfoDetailSvc/v1/getAPTLttotPblancDetail?page=1&perPage=10&serviceKey=d8BGrUbjrluAJ7vMGvpM3M%2FAy%2FAQwMdpovd1%2BknX5Q99k4oRrLcN%2F37ZuH17qC4sD0lHjfCnHpnmSf27rZ0TnQ%3D%3D
// 청약정보1
package api;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import vo.AptSubscriptionCompeteRateVo;

// 아파트청약경쟁률API

class ApiAptSubscriptionCompeteRate {
    ArrayList<AptSubscriptionCompeteRateVo> listCompeteRateVo = new ArrayList<AptSubscriptionCompeteRateVo>();

    void request(int page, int perPage) throws Exception {
		// 1. URL을 만들기 위한 StringBuilder.
        StringBuilder urlBuilder = new StringBuilder("https://api.odcloud.kr/api/ApplyhomeInfoCmpetRtSvc/v1/getAPTLttotPblancCmpet"); /*URL*/
        // 2. 오픈 API의요청 규격에 맞는 파라미터 생성, 발급받은 인증키.
        urlBuilder.append("?serviceKey=d8BGrUbjrluAJ7vMGvpM3M%2FAy%2FAQwMdpovd1%2BknX5Q99k4oRrLcN%2F37ZuH17qC4sD0lHjfCnHpnmSf27rZ0TnQ%3D%3D"); /*Service Key*/
        //urlBuilder.append("&" + URLEncoder.encode("returnType","UTF-8") + "=" + URLEncoder.encode("JSON", "UTF-8")); /*XML 또는 JSON*/
        urlBuilder.append("&page=" + page); /*한 페이지 결과 수*/
        urlBuilder.append("&perPage=" + perPage); /*페이지 번호*/
        //urlBuilder.append("&" + URLEncoder.encode("cond[country_nm::EQ]","UTF-8") + "=" + URLEncoder.encode("가나", "UTF-8")); /*한글 국가명*/
        //urlBuilder.append("&" + URLEncoder.encode("cond[country_iso_alp2::EQ]","UTF-8") + "=" + URLEncoder.encode("GH", "UTF-8")); /*ISO 2자리코드*/
        // 3. URL 객체 생성.
        
//        System.out.println("요청URL : " + urlBuilder);
        
        URL url = new URL(urlBuilder.toString());
        // 4. 요청하고자 하는 URL과 통신하기 위한 Connection 객체 생성.
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        // 5. 통신을 위한 메소드 SET.
        conn.setRequestMethod("GET");
        // 6. 통신을 위한 Content-type SET. 
        conn.setRequestProperty("Content-type", "application/json");
        // 7. 통신 응답 코드 확인.
        System.out.println("Response code: " + conn.getResponseCode());
        // 8. 전달받은 데이터를 BufferedReader 객체로 저장.
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        // 9. 저장된 데이터를 라인별로 읽어 StringBuilder 객체로 저장.
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        // 10. 객체 해제.
        rd.close();
        conn.disconnect();
        // 11. 전달받은 데이터 확인.
//        System.out.println(sb.toString());
        
        // 1. 문자열 형태의 JSON을 파싱하기 위한 JSONParser 객체 생성.
        JSONParser parser = new JSONParser();
        // 2. 문자열을 JSON 형태로 JSONObject 객체에 저장. 	
        JSONObject obj = (JSONObject)parser.parse(sb.toString());
        // 3. 필요한 리스트 데이터 부분만 가져와 JSONArray로 저장.
        JSONArray dataArr = (JSONArray) obj.get("data");
        
//        System.out.println(obj);
        
//        System.out.println(obj.get("data"));
        
        
        for(int i=0; i<=dataArr.size()-1; i++) {
        	JSONObject o = (JSONObject) dataArr.get(i);
//        	System.out.println("["+i+"] " + o);
//        	System.out.println("house_manage_no : " + o.get("HOUSE_MANAGE_NO"));
//        	System.out.println("house_ty : " + o.get("HOUSE_TY"));
        	String houseManageNo = (String)o.get("HOUSE_MANAGE_NO");
        	String pblancNo = (String)o.get("PBLANC_NO");
        	String modelNo = (String)o.get("MODEL_NO");
        	String houseTy = (String)o.get("HOUSE_TY");
        	long suplyHshldco = (Long)o.get("SUPLY_HSHLDCO");
        	long subscrptRankCode = (Long)o.get("SUBSCRPT_RANK_CODE");
        	String resideSecd = (String)o.get("RESIDE_SECD");
        	String resideSenm = (String)o.get("RESIDE_SENM");
        	String reqCnt = (String)o.get("REQ_CNT");
        	String cmpetRate = (String)o.get("CMPET_RATE");
        	AptSubscriptionCompeteRateVo vo = new AptSubscriptionCompeteRateVo(houseManageNo, pblancNo, modelNo, houseTy, suplyHshldco, subscrptRankCode, resideSecd, resideSenm, reqCnt, cmpetRate);
        	listCompeteRateVo.add(vo);
        }
    	
    }
}

public class TestApi2 {
	public static void main(String[] args) throws Exception {
		ApiAptSubscriptionCompeteRate api1 = new ApiAptSubscriptionCompeteRate();
		for(int i=1; i<=4; i++) {
			api1.request(i, 10000);
		}
        System.out.println(api1.listCompeteRateVo.size());
        //System.out.println(listCompeteRateVo.size());
	}

}
