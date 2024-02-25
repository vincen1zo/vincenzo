package vo;

public class OzipDetailVo2 {
	private int ozipIdx;
	private String ozipTitle;
	private String ozipMemberId;
	private String ozipWritedate;
	private int ozipCNum;
	private int ozipHitcount;
	private String ozipHashtag;
	
	public OzipDetailVo2(int ozipIdx, String ozipTitle, String ozipMemberId, String ozipWritedate, int ozipCNum,
			int ozipHitcount, String ozipHashtag) {
		this.ozipIdx = ozipIdx;
		this.ozipTitle = ozipTitle;
		this.ozipMemberId = ozipMemberId;
		this.ozipWritedate = ozipWritedate;
		this.ozipCNum = ozipCNum;
		this.ozipHitcount = ozipHitcount;
		this.ozipHashtag = ozipHashtag;
	}

	public int getOzipIdx() {
		return ozipIdx;
	}

	public String getOzipTitle() {
		return ozipTitle;
	}

	public String getOzipMemberId() {
		return ozipMemberId;
	}

	public String getOzipWritedate() {
		return ozipWritedate;
	}

	public int getOzipCNum() {
		return ozipCNum;
	}

	public int getOzipHitcount() {
		return ozipHitcount;
	}

	public String getOzipHashtag() {
		return ozipHashtag;
	}
}
