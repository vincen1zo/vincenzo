package vo;

public class OzipDetailVo {
	private int ozipIdx;
	private String ozipDetailImgUrl;
	private String ozipDetailDescription;
	
	public OzipDetailVo(int ozipIdx, String ozipDetailImgUrl, String ozipDetailDescription) {
		this.ozipIdx = ozipIdx;
		this.ozipDetailImgUrl = ozipDetailImgUrl;
		this.ozipDetailDescription = ozipDetailDescription;
		
	}

	public int getOzipIdx() {
		return ozipIdx;
	}

	public String getOzipDetailImgUrl() {
		return ozipDetailImgUrl;
	}

	public String getOzipDetailDescription() {
		return ozipDetailDescription;
	}
	
}
