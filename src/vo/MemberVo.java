package vo;

public class MemberVo {
	private String memberId;
	private String email;
	private int authenticationCode;
	private String authenticationExpire;
	private String password;
	private int agree1;
	private int agree2;
	private int agree3;
	private int agree4;
	private int agree5;
	private String profileImg;
	private String homepage;
	private String birthday;
	private int gender;
	private String oneLiner;
	private int admin;
	private long kakaoId;
	
	public MemberVo(String memberId, String email, int authenticationCode, String authenticationExpire, String password,
			int agree1, int agree2, int agree3, int agree4, int agree5, String profileImg, String homepage,
			String birthday, int gender, String oneLiner, int admin, long kakaoId) {
		this.memberId = memberId;
		this.email = email;
		this.authenticationCode = authenticationCode;
		this.authenticationExpire = authenticationExpire;
		this.password = password;
		this.agree1 = agree1;
		this.agree2 = agree2;
		this.agree3 = agree3;
		this.agree4 = agree4;
		this.agree5 = agree5;
		this.profileImg = profileImg;
		this.homepage = homepage;
		this.birthday = birthday;
		this.gender = gender;
		this.oneLiner = oneLiner;
		this.admin = admin;
		this.kakaoId = kakaoId;
	}

	public String getMemberId() {
		return memberId;
	}

	public String getEmail() {
		return email;
	}

	public int getAuthenticationCode() {
		return authenticationCode;
	}

	public String getAuthenticationExpire() {
		return authenticationExpire;
	}

	public String getPassword() {
		return password;
	}

	public int getAgree1() {
		return agree1;
	}

	public int getAgree2() {
		return agree2;
	}

	public int getAgree3() {
		return agree3;
	}

	public int getAgree4() {
		return agree4;
	}

	public int getAgree5() {
		return agree5;
	}

	public String getProfileImg() {
		return profileImg;
	}

	public String getHomepage() {
		return homepage;
	}

	public String getBirthday() {
		return birthday;
	}

	public int getGender() {
		return gender;
	}

	public String getOneLiner() {
		return oneLiner;
	}

	public int getAdmin() {
		return admin;
	}

	public long getKakaoId() {
		return kakaoId;
	}

}
