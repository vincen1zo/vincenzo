package vo;

public class HousepartyCommentVo {
	private int commentIdx;
	private int housepartyIdx;
	private int reCommentIdx;
	private int commentOrder;
	private String memberId;
	private String hpComment;
	private String writeDate;
	private String profileImg;
	
	public HousepartyCommentVo(int commentIdx, int housepartyIdx, int reCommentIdx, int commentOrder, String memberId,
			String hpComment, String writeDate, String profileImg) {
		this.commentIdx = commentIdx;
		this.housepartyIdx = housepartyIdx;
		this.reCommentIdx = reCommentIdx;
		this.commentOrder = commentOrder;
		this.memberId = memberId;
		this.hpComment = hpComment;
		this.writeDate = writeDate;
		this.profileImg = profileImg;
	}

	public int getCommentIdx() {
		return commentIdx;
	}

	public int getHousepartyIdx() {
		return housepartyIdx;
	}

	public int getReCommentIdx() {
		return reCommentIdx;
	}

	public int getCommentOrder() {
		return commentOrder;
	}

	public String getMemberId() {
		return memberId;
	}

	public String getHpComment() {
		return hpComment;
	}

	public String getWriteDate() {
		return writeDate;
	}

	public String getProfileImg() {
		return profileImg;
	}
	
	
}