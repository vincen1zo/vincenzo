// https://api.odcloud.kr/api/ApplyhomeInfoDetailSvc/v1/getAPTLttotPblancDetail?page=1&perPage=10&serviceKey=d8BGrUbjrluAJ7vMGvpM3M%2FAy%2FAQwMdpovd1%2BknX5Q99k4oRrLcN%2F37ZuH17qC4sD0lHjfCnHpnmSf27rZ0TnQ%3D%3D
// 청약정보1
package api;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import vo.AptSubscriptionDetailVo;

// APT 분양정보 상세조회. 
class ApiAptSubscriptionDetail {
    ArrayList<AptSubscriptionDetailVo> listSubscriptionDetail = new ArrayList<AptSubscriptionDetailVo>();

    void request(int page, int perPage) throws Exception {
		// 1. URL을 만들기 위한 StringBuilder.
        StringBuilder urlBuilder = new StringBuilder("https://api.odcloud.kr/api/ApplyhomeInfoDetailSvc/v1/getAPTLttotPblancDetail"); /*URL*/
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
        //sssSystem.out.println(sb.toString());
        
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
//        	System.out.println("["+i+"]");
//        	System.out.println("이름 : " + o.get("HOUSE_NM"));
//        	System.out.println("address : " + o.get("HSSPLY_ADRES"));
        	long houseManageNo = (Long) o.get("HOUSE_MANAGE_NO");   // 주택관리번호 
        	long pblancNo = (Long) o.get("PBLANC_NO");     // 공고번호 
        	String houseNm = (String) o.get("HOUSE_NM");    // 주택명  ex. 창동 다우아트리체 주상복합 아파트
        	String houseSecdNm = (String) o.get("HOUSE_SECD_NM");  // 주택구분코드명  (ex. APT)
        	String houseDtlSecdNm = (String) o.get("HOUSE_DTL_SECD_NM"); // 구택상세구분코드명 (ex. 민영)
        	String rentSecdNm = (String) o.get("RENT_SECD_NM");   // 분양구분코드명 (ex. 분양주택)
        	String subscrptAreaCodeNm = (String) o.get("SUBSCRPT_AREA_CODE_NM");  // 공급지역명 (ex. 서울)
        	String hssplyZip = (String) o.get("HSSPLY_ZIP");      // 공급위치 우편번호 
        	String hssplyAdres = (String) o.get("HSSPLY_ADRES");    // 공급위치 (ex. 서울특별시 도봉구 창동 662-7번지 외 12필지)
        	String pblancUrl = (String) o.get("PBLANC_URL");      // 청약홈 분양정보 페이지 연결 URL.  (ex. https://www.applyhome.co.kr/ai/aia/selectAPTLttotPblancDetail.do?houseManageNo=2022000248&pblancNo=2022000248)
        	AptSubscriptionDetailVo vo = new AptSubscriptionDetailVo(houseManageNo, pblancNo, houseNm, houseSecdNm, houseDtlSecdNm, rentSecdNm, subscrptAreaCodeNm, hssplyZip, hssplyAdres, pblancUrl);
        	
        	listSubscriptionDetail.add(vo);
        }
    	
    }
}
public class TestApi1 {
	public static void main(String[] args) throws Exception {
		ApiAptSubscriptionDetail api2 = new ApiAptSubscriptionDetail();
		api2.request(1,  1817);
		
		System.out.println(api2.listSubscriptionDetail.size());
	}

}
