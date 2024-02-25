package vo;

public class InteriorPhotoVo {
	private int interiorIdx;
	private int interiorImgIdx;
	private int orderImgIdx;
	private String imgUrl;
	
	public InteriorPhotoVo(int interiorIdx, int interiorImgIdx, int orderImgIdx, String imgUrl) {
		this.interiorIdx = interiorIdx;
		this.interiorImgIdx = interiorImgIdx;
		this.orderImgIdx = orderImgIdx;
		this.imgUrl = imgUrl;
	}

	public int getInteriorIdx() {
		return interiorIdx;
	}

	public int getInteriorImgIdx() {
		return interiorImgIdx;
	}

	public int getOrderImgIdx() {
		return orderImgIdx;
	}

	public String getImgUrl() {
		return imgUrl;
	}
	
}
