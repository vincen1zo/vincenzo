package vo;

public class OzipModifyVo {
	private int ozipIdx;
	private	String ozipTitle;
	private String ozipHashtag;
	
	public OzipModifyVo(int ozipIdx, String title, String hashtag) {
		this.ozipIdx = ozipIdx;
		this.ozipTitle = title;
		this.ozipHashtag = hashtag;
	}

	public int getOzipIdx() {
		return ozipIdx;
	}

	public String getTitle() {
		return ozipTitle;
	}

	public String getHashtag() {
		return ozipHashtag;
	}
}
