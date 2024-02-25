package vo;

public class CategoryVo {
	private int categoryIdx;
	private String depth0;
	private String depth1;
	private String depth2;
	private String depth3;
	private int leaf;
	private int movingIdx;
	
	public CategoryVo(int categoryIdx, String depth0, String depth1, String depth2, String depth3, int leaf,
			int movingIdx) {
		this.categoryIdx = categoryIdx;
		this.depth0 = depth0;
		this.depth1 = depth1;
		this.depth2 = depth2;
		this.depth3 = depth3;
		this.leaf = leaf;
		this.movingIdx = movingIdx;
	}

	public int getCategoryIdx() {
		return categoryIdx;
	}

	public String getDepth0() {
		return depth0;
	}

	public String getDepth1() {
		return depth1;
	}

	public String getDepth2() {
		return depth2;
	}

	public String getDepth3() {
		return depth3;
	}

	public int getLeaf() {
		return leaf;
	}

	public int getMovingIdx() {
		return movingIdx;
	}
}
