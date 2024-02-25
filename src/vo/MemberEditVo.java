package vo;

public class MemberEditVo {
	private String email;
	private String memberId;
	private String homepage;
	private int gender;
	private String birthday;
	private String profileImg;
	private String oneLiner;
	
	public MemberEditVo(String email, String memberId, String homepage, int gender, String birthday, String proFileImg,
			String oneLiner) {
		this.email = email;
		this.memberId = memberId;
		this.homepage = homepage;
		this.gender = gender;
		this.birthday = birthday;
		this.profileImg = proFileImg;
		this.oneLiner = oneLiner;
	}

	public String getEmail() {
		return email;
	}

	public String getMemberId() {
		return memberId;
	}

	public String getHomepage() {
		return homepage;
	}

	public int getGender() {
		return gender;
	}

	public String getBirthday() {
		return birthday;
	}

	public String getProfileImg() {
		return profileImg;
	}

	public String getOneLiner() {
		return oneLiner;
	}
}
