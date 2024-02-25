package vo;

public class MyWriteReviewVo {
	private int productIdx;
	private int reviewIdx;
	private String memberId;
	private String brandName;
	private String name;
	private String option1Value;
	private String writedate;
	private String conent;
	private double starAvg;
	private String imgUrl;
	public MyWriteReviewVo(int productIdx, int reviewIdx, String memberId, String brandName, String name,
			String option1Value, String writedate, String conent, double starAvg, String imgUrl) {
		this.productIdx = productIdx;
		this.reviewIdx = reviewIdx;
		this.memberId = memberId;
		this.brandName = brandName;
		this.name = name;
		this.option1Value = option1Value;
		this.writedate = writedate;
		this.conent = conent;
		this.starAvg = starAvg;
		this.imgUrl = imgUrl;
	}
	public int getProductIdx() {
		return productIdx;
	}
	public int getReviewIdx() {
		return reviewIdx;
	}
	public String getMemberId() {
		return memberId;
	}
	public String getBrandName() {
		return brandName;
	}
	public String getName() {
		return name;
	}
	public String getOption1Value() {
		return option1Value;
	}
	public String getWritedate() {
		return writedate;
	}
	public String getConent() {
		return conent;
	}
	public double getStarAvg() {
		return starAvg;
	}
	public String getImgUrl() {
		return imgUrl;
	}
	
	
	
	
}
