package vo;

public class HomeMainHpVo {
	private int housepartyIdx;
	private String subheadColor;
	private String subhead;
	private String coverImg;
	
	public HomeMainHpVo(int housepartyIdx, String subheadColor, String subhead, String coverImg) {
		this.housepartyIdx = housepartyIdx;
		this.subheadColor = subheadColor;
		this.subhead = subhead;
		this.coverImg = coverImg;
	}

	public int getHousepartyIdx() {
		return housepartyIdx;
	}

	public String getSubheadColor() {
		return subheadColor;
	}

	public String getSubhead() {
		return subhead;
	}

	public String getCoverImg() {
		return coverImg;
	}
}
