package vo;

public class ConReviewListVo {
	private String memberId;
	private String content;
	private String imgUrl;
	
	public ConReviewListVo(String memberId, String content, String imgUrl) {
		this.memberId = memberId;
		this.content = content;
		this.imgUrl = imgUrl;
	}

	public String getMemberId() {
		return memberId;
	}

	public String getContent() {
		return content;
	}

	public String getImgUrl() {
		return imgUrl;
	}
	
	
}
