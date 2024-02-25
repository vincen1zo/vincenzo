package vo;

public class newVo {
	String profileImg;
	String memberId;
	String whoMemberId;
	String sentence;
	String wheen;
	
	public newVo(String profileImg, String memberId, String whoMemberId, String sentence, String wheen) {
		this.profileImg = profileImg;
		this.memberId = memberId;
		this.whoMemberId = whoMemberId;
		this.sentence = sentence;
		this.wheen = wheen;
	}
	
	public String getProfileImg() {
		return profileImg;
	}
	public String getMemberId() {
		return memberId;
	}
	public String getWhoMemberId() {
		return whoMemberId;
	}
	public String getSentence() {
		return sentence;
	}
	public String getWheen() {
		return wheen;
	}
}
