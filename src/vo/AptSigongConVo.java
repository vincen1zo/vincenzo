package vo;

public class AptSigongConVo {
	private int interiorIdx;
	private String name;
	private String exp;
	private int housepartyIdx;
	private int hInteriorIdx;
	private String coverImg;
	
	public AptSigongConVo(int interiorIdx, String name, String exp, int housepartyIdx, int hInteriorIdx,
			String coverImg) {
		this.interiorIdx = interiorIdx;
		this.name = name;
		this.exp = exp;
		this.housepartyIdx = housepartyIdx;
		this.hInteriorIdx = hInteriorIdx;
		this.coverImg = coverImg;
	}

	public int getInteriorIdx() {
		return interiorIdx;
	}

	public String getName() {
		return name;
	}

	public String getExp() {
		return exp;
	}

	public int getHousepartyIdx() {
		return housepartyIdx;
	}

	public int gethInteriorIdx() {
		return hInteriorIdx;
	}

	public String getCoverImg() {
		return coverImg;
	}
	
}
