package vo;

public class HousepartyVo {
	private int housepartyIdx;
	private String coverImg;
	private String title;
	private String name;
	private String profileImg;
	private int likeyCount;
	private int hitCount;
	private String writeDate;
	
	public HousepartyVo(int housepartyIdx, String coverImg, String title, String name, String profileImg,
			int likeyCount, int hitCount, String writeDate) {
		this.housepartyIdx = housepartyIdx;
		this.coverImg = coverImg;
		this.title = title;
		this.name = name;
		this.profileImg = profileImg;
		this.likeyCount = likeyCount;
		this.hitCount = hitCount;
		this.writeDate = writeDate;
	}

	public int getHousepartyIdx() {
		return housepartyIdx;
	}

	public String getCoverImg() {
		return coverImg;
	}

	public String getTitle() {
		return title;
	}

	public String getName() {
		return name;
	}

	public String getProfileImg() {
		return profileImg;
	}

	public int getLikeyCount() {
		return likeyCount;
	}

	public int getHitCount() {
		return hitCount;
	}

	public String getWriteDate() {
		return writeDate;
	}
	
	
}
