package vo;

public class AptConReviewVo {
	private String name;
	private Double starPoingAvg; 
	private int aptIdx;
	private int reviewIdx;  
	private int interiorIdx;
	private String profileImg;
	private String memberId;
	private int conReview;
	private String writedate;
	private int oCon;
	private String conTime;
	private int conPriceLow;
	private int conPriceHigh;
	private String address;
	private String homeType;
	private String conField;
	private String py;
	private String content;
	private int likeyCoun;
	
	public AptConReviewVo(String name, Double starPoingAvg, int aptIdx, int reviewIdx, int interiorIdx,
			String profileImg, String memberId, int conReview, String writedate, int oCon, String conTime,
			int conPriceLow, int conPriceHigh, String address, String homeType, String conField, String py,
			String content, int likeyCoun) {
		this.name = name;
		this.starPoingAvg = starPoingAvg;
		this.aptIdx = aptIdx;
		this.reviewIdx = reviewIdx;
		this.interiorIdx = interiorIdx;
		this.profileImg = profileImg;
		this.memberId = memberId;
		this.conReview = conReview;
		this.writedate = writedate;
		this.oCon = oCon;
		this.conTime = conTime;
		this.conPriceLow = conPriceLow;
		this.conPriceHigh = conPriceHigh;
		this.address = address;
		this.homeType = homeType;
		this.conField = conField;
		this.py = py;
		this.content = content;
		this.likeyCoun = likeyCoun;
	}
	
	public String getName() {
		return name;
	}
	public Double getStarPoingAvg() {
		return starPoingAvg;
	}
	public int getAptIdx() {
		return aptIdx;
	}
	public int getReviewIdx() {
		return reviewIdx;
	}
	public int getInteriorIdx() {
		return interiorIdx;
	}
	public String getProfileImg() {
		return profileImg;
	}
	public String getMemberId() {
		return memberId;
	}
	public int getConReview() {
		return conReview;
	}
	public String getWritedate() {
		return writedate;
	}
	public int getoCon() {
		return oCon;
	}
	public String getConTime() {
		return conTime;
	}
	public int getConPriceLow() {
		return conPriceLow;
	}
	public int getConPriceHigh() {
		return conPriceHigh;
	}
	public String getAddress() {
		return address;
	}
	public String getHomeType() {
		return homeType;
	}
	public String getConField() {
		return conField;
	}
	public String getPy() {
		return py;
	}
	public String getContent() {
		return content;
	}
	public int getLikeyCoun() {
		return likeyCoun;
	}
}
