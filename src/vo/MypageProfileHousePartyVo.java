package vo;

public class MypageProfileHousePartyVo {
	private int housePartyIdx;
	private String coverImg;
	private String title;
	private String memberId;
	private int shareCount;
	private int hitCount;
	
	public MypageProfileHousePartyVo(int housePartyIdx, String coverImg, String title, String memberId, int shareCount, int hitCount) {
		this.housePartyIdx = housePartyIdx;
		this.coverImg = coverImg;
		this.title = title;
		this.memberId = memberId;
		this.shareCount = shareCount;
		this.hitCount = hitCount;
	}

	public int getHousepartyIdx() {
		return housePartyIdx;
	}

	public String getCoverImg() {
		return coverImg;
	}

	public String getTitle() {
		return title;
	}

	public String getMemberId() {
		return memberId;
	}
	
	public int getShareCount() {
		return shareCount;
	}
	
	public int getHitCount() {
		return hitCount;
	}
}
