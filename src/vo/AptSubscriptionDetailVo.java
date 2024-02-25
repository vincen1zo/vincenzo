package vo;

public class AptSubscriptionDetailVo {
	long houseManageNo;   // 주택관리번호 
	long pblancNo;     // 공고번호 
	String houseNm;    // 주택명  ex. 창동 다우아트리체 주상복합 아파트
	String houseSecdNm;  // 주택구분코드명  (ex. APT)
	String houseDtlSecdNm; // 구택상세구분코드명 (ex. 민영)
	String rentSecdNm;   // 분양구분코드명 (ex. 분양주택)
	String subscrptAreaCodeNm;  // 공급지역명 (ex. 서울)
	String hssplyZip;      // 공급위치 우편번호 
	String hssplyAdres;    // 공급위치 (ex. 서울특별시 도봉구 창동 662-7번지 외 12필지)
	String pblancUrl;      // 청약홈 분양정보 페이지 연결 URL.  (ex. https://www.applyhome.co.kr/ai/aia/selectAPTLttotPblancDetail.do?houseManageNo=2022000248&pblancNo=2022000248)
	
	public AptSubscriptionDetailVo(long houseManageNo, long pblancNo, String houseNm, String houseSecdNm,
			String houseDtlSecdNm, String rentSecdNm, String subscrptAreaCodeNm, String hssplyZip, String hssplyAdres,
			String pblancUrl) {
		this.houseManageNo = houseManageNo;
		this.pblancNo = pblancNo;
		this.houseNm = houseNm;
		this.houseSecdNm = houseSecdNm;
		this.houseDtlSecdNm = houseDtlSecdNm;
		this.rentSecdNm = rentSecdNm;
		this.subscrptAreaCodeNm = subscrptAreaCodeNm;
		this.hssplyZip = hssplyZip;
		this.hssplyAdres = hssplyAdres;
		this.pblancUrl = pblancUrl;
	}

	public long getHouseManageNo() {
		return houseManageNo;
	}

	public long getPblancNo() {
		return pblancNo;
	}

	public String getHouseNm() {
		return houseNm;
	}

	public String getHouseSecdNm() {
		return houseSecdNm;
	}

	public String getHouseDtlSecdNm() {
		return houseDtlSecdNm;
	}

	public String getRentSecdNm() {
		return rentSecdNm;
	}

	public String getSubscrptAreaCodeNm() {
		return subscrptAreaCodeNm;
	}

	public String getHssplyZip() {
		return hssplyZip;
	}

	public String getHssplyAdres() {
		return hssplyAdres;
	}

	public String getPblancUrl() {
		return pblancUrl;
	}

	
}
