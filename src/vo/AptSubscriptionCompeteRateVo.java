package vo;

public class AptSubscriptionCompeteRateVo {
	private String houseManageNo;  // 주택관리번호 
	private String pblancNo;   // 공고번호 
	private String modelNo;   // 모델번호 
	private String houseTy;   // 주택형 
	private long suplyHshldco;   // 공급세대수 
	private long subscrptRankCode;  // 순위 
	private String resideSecd;  // 거주코드 
	private String resideSenm;  // 거주지역 
	private String reqCnt;     // 접수건수 
	private String cmpetRate;  // 경쟁률
	
	public AptSubscriptionCompeteRateVo(String houseManageNo, String pblancNo, String modelNo, String houseTy,
			long suplyHshldco, long subscrptRankCode, String resideSecd, String resideSenm, String reqCnt,
			String cmpetRate) {
		this.houseManageNo = houseManageNo;
		this.pblancNo = pblancNo;
		this.modelNo = modelNo;
		this.houseTy = houseTy;
		this.suplyHshldco = suplyHshldco;
		this.subscrptRankCode = subscrptRankCode;
		this.resideSecd = resideSecd;
		this.resideSenm = resideSenm;
		this.reqCnt = reqCnt;
		this.cmpetRate = cmpetRate;
	}

	public String getHouseManageNo() {
		return houseManageNo;
	}

	public String getPblancNo() {
		return pblancNo;
	}

	public String getModelNo() {
		return modelNo;
	}

	public String getHouseTy() {
		return houseTy;
	}

	public long getSuplyHshldco() {
		return suplyHshldco;
	}

	public long getSubscrptRankCode() {
		return subscrptRankCode;
	}

	public String getResideSecd() {
		return resideSecd;
	}

	public String getResideSenm() {
		return resideSenm;
	}

	public String getReqCnt() {
		return reqCnt;
	}

	public String getCmpetRate() {
		return cmpetRate;
	}
	
	
	
}
