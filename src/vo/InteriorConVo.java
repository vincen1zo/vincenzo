package vo;
//HousepartySigonVO와 내용 같음
public class InteriorConVo {
	private int housepartyIdx;
	private String coverImg;
	private String title;
	private int likeyCount;
	private int hitCount;
	
	public InteriorConVo(int housepartyIdx, String coverImg, String title, int likeyCount, int hitCount) {
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
