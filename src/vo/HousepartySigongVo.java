package vo;

public class HousepartySigongVo {
	private int housepartyIdx;
	private String coverImg;
	private String title;
	private int likeyCount;
	private int hitCount;
	
	public HousepartySigongVo(int housepartyIdx, String coverImg, String title, int likeyCount, int hitCount) {
		this.housepartyIdx = housepartyIdx;
		this.coverImg = coverImg;
		this.title = title;
		this.likeyCount = likeyCount;
		this.hitCount = hitCount;
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

	public int getLikeyCount() {
		return likeyCount;
	}

	public int getHitCount() {
		return hitCount;
	}

	
}
