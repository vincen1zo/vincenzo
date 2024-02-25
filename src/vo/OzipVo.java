package vo;

public class OzipVo {
	private int ozipIdx;
	private String title;
	private String memberId;
	private String writedate;
	private int cNum;
	private int hitcount;
	private String hashtag;
	private String imgUrl;
	private String description;
	
	public OzipVo(int ozipIdx, String title, String memberId, String writedate, int cNum, int hitcount, String hashtag,
			String imgUrl, String description) {
		this.ozipIdx = ozipIdx;
		this.title = title;
		this.memberId = memberId;
		this.writedate = writedate;
		this.cNum = cNum;
		this.hitcount = hitcount;
		this.hashtag = hashtag;
		this.imgUrl = imgUrl;
		this.description = description;
	}

	public int getOzipIdx() {
		return ozipIdx;
	}

	public String getTitle() {
		return title;
	}

	public String getMemberId() {
		return memberId;
	}

	public String getWritedate() {
		return writedate;
	}

	public int getcNum() {
		return cNum;
	}

	public int getHitcount() {
		return hitcount;
	}

	public String getHashtag() {
		return hashtag;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public String getDescription() {
		return description;
	}

	
	
}
