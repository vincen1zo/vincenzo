package vo;

public class AptReveiwPhotoVo {
	private int reviewIdx;
	private int imgOrder;
	private String imgUrl;
	
	public AptReveiwPhotoVo(int reviewIdx, int imgOrder, String imgUrl) {
		this.reviewIdx = reviewIdx;
		this.imgOrder = imgOrder;
		this.imgUrl = imgUrl;
	}
	public int getReviewIdx() {
		return reviewIdx;
	}
	public int getImgOrder() {
		return imgOrder;
	}
	public String getImgUrl() {
		return imgUrl;
	}
}
