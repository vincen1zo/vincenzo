package vo;

public class ProductMainImgVo {
	private int productIdx;
	private int imgIdx;
	private String imgUrl;
	
	public ProductMainImgVo(int productIdx, int imgIdx, String imgUrl) {
		this.productIdx = productIdx;
		this.imgIdx = imgIdx;
		this.imgUrl = imgUrl;
	}

	public int getProductIdx() {
		return productIdx;
	}

	public int getImgIdx() {
		return imgIdx;
	}

	public String getImgUrl() {
		return imgUrl;
	}
	
}
