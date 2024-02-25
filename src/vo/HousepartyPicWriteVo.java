package vo;

public class HousepartyPicWriteVo {
	private int picWriteIdx;
	private int housepartyIdx;
	private String title;
	private String imgUrl;
	private String content;
	private String smallTalk;
	private String linkUrl;
	
	public HousepartyPicWriteVo(int picWriteIdx, int housepartyIdx, String title, String imgUrl, String content,
			String smallTalk, String linkUrl) {
		this.picWriteIdx = picWriteIdx;
		this.housepartyIdx = housepartyIdx;
		this.title = title;
		this.imgUrl = imgUrl;
		this.content = content;
		this.smallTalk = smallTalk;
		this.linkUrl = linkUrl;
	}

	public int getPicWriteIdx() {
		return picWriteIdx;
	}

	public int getHousepartyIdx() {
		return housepartyIdx;
	}

	public String getTitle() {
		return title;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public String getContent() {
		return content;
	}

	public String getSmallTalk() {
		return smallTalk;
	}

	public String getLinkUrl() {
		return linkUrl;
	}
}
