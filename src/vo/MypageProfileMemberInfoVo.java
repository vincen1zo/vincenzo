package vo;

public class MypageProfileMemberInfoVo {
	private String memberId;
	private String profileImg;
	private String oneLiner;
	private int followCount;
	private int followerCount;
	
	public MypageProfileMemberInfoVo(String memberId, String profileImg, String oneLiner, int followCount, int followerCount) {
		this.memberId = memberId;
		this.profileImg = profileImg;
		this.oneLiner = oneLiner;
		this.followCount = followCount;
		this.followerCount = followerCount;
	}

	public String getMemberId() {
		return memberId;
	}

	public String getProfileImg() {
		return profileImg;
	}

	public String getOneLiner() {
		return oneLiner;
	}
	
	public int getFollowCount() {
		return followCount;
	}
	
	public int getFollowerCount() {
		return followerCount;
	}
}
