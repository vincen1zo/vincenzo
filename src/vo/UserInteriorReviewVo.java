package vo;

public class UserInteriorReviewVo {
	private int reviewIdx;
	private String imgUrl;
	private String name;
	private String content;
	
	public UserInteriorReviewVo(int reviewIdx, String imgUrl, String name, String content) {
		this.reviewIdx = reviewIdx;
		this.imgUrl = imgUrl;
		this.name = name;
		this.content = content;
	}

	public int getReviewIdx() {
		return reviewIdx;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public String getName() {
		return name;
	}

	public String getContent() {
		return content;
	}
}
