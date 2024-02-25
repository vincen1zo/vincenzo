package vo;

public class OzipModifyVo2 {
	private int imgIdx;
	private int ozipIdx;
	private String imgUrl;
	private String description;
	public OzipModifyVo2(int imgIdx, int ozipIdx, String imgUrl, String description) {
		this.imgIdx = imgIdx;
		this.ozipIdx = ozipIdx;
		this.imgUrl = imgUrl;
		this.description = description;
	}
	public int getImgIdx() {
		return imgIdx;
	}
	public int getOzipIdx() {
		return ozipIdx;
	}
	public String getImgUrl() {
		return imgUrl;
	}
	public String getDescription() {
		return description;
	}
}
