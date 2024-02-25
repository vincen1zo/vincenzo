package vo;

public class OzipReplyVo {
	private int commentIdx;
	private int recommentIdx;
	private int ozipIdx;
	private int commentOrder;
	private String memberId;
	private String content;
	private String imgUrl;
	private String writedate;
	
	public OzipReplyVo(int commentIdx, int recommentIdx, int ozipIdx, int commentOrder, String memberId,
			String content, String imgUrl, String writedate) {
		this.commentIdx = commentIdx;
		this.recommentIdx = recommentIdx;
		this.ozipIdx = ozipIdx;
		this.commentOrder = commentOrder;
		this.memberId = memberId;
		this.content = content;
		this.imgUrl = imgUrl;
		this.writedate = writedate;
	}

	public int getCommentIdx() {
		return commentIdx;
	}

	public int getRecommentIdx() {
		return recommentIdx;
	}

	public int getOzipIdx() {
		return ozipIdx;
	}

	public int getCommentOrder() {
		return commentOrder;
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

	public String getWritedate() {
		return writedate;
	}

	
	
}
