package vo;

public class AptSigongReviewVo {
	private int imgReviewIdx;
	private int imgOrder;
	private String imgUrl;
	private int reviewIdx;
	private int aptIdx;
	private String py;
	private int conPriceLow;
	private int conPriceHigh;
	private String content;
	private String memberId;
	private String writedate;
	
	public AptSigongReviewVo(int imgReviewIdx, int imgOrder, String imgUrl, int reviewIdx, int aptIdx, String py,
			int conPriceLow, int conPriceHigh, String content, String memberId, String writedate) {
		this.imgReviewIdx = imgReviewIdx;
		this.imgOrder = imgOrder;
		this.imgUrl = imgUrl;
		this.reviewIdx = reviewIdx;
		this.aptIdx = aptIdx;
		this.py = py;
		this.conPriceLow = conPriceLow;
		this.conPriceHigh = conPriceHigh;
		this.content = content;
		this.memberId = memberId;
		this.writedate = writedate;
	}
	
	public int getImgReviewIdx() {
		return imgReviewIdx;
	}
	public int getImgOrder() {
		return imgOrder;
	}
	public String getImgUrl() {
		return imgUrl;
	}
	public int getReviewIdx() {
		return reviewIdx;
	}
	public int getAptIdx() {
		return aptIdx;
	}
	public String getPy() {
		return py;
	}
	public int getConPriceLow() {
		return conPriceLow;
	}
	public int getConPriceHigh() {
		return conPriceHigh;
	}
	public String getContent() {
		return content;
	}
	public String getMemberId() {
		return memberId;
	}
	public String getWritedate() {
		return writedate;
	}
	
}
