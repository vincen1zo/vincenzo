package vo;

public class UserSearchVo {
	private String profileImg;
	private String memberId;
	private boolean isFollowing;
	
	public UserSearchVo(String profileImg, String memberId, boolean isFollowing) {
		this.profileImg = profileImg;
		this.memberId = memberId;
		this.isFollowing = isFollowing;
	}

	public String getProfileImg() {
		return profileImg;
	}

	public String getMemberId() {
		return memberId;
	}

	public boolean isFollowing() {
		return isFollowing;
	}
}
