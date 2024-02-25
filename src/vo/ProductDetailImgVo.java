package vo;

public class ProductDetailImgVo {
	private int productIdx;
	private int imgOrder;
	private String imgUrl;
	private String externalUrl;
	private String imgUnderText;
	
	public ProductDetailImgVo(int productIdx, int imgOrder, String imgUrl, String externalUrl, String imgUnderText) {
		this.productIdx = productIdx;
		this.imgOrder = imgOrder;
		this.imgUrl = imgUrl;
		this.externalUrl = externalUrl;
		this.imgUnderText = imgUnderText;
	}

	public int getProductIdx() {
		return productIdx;
	}

	public int getImgOrder() {
		return imgOrder;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public String getExternalUrl() {
		return externalUrl;
	}

	public String getImgUnderText() {
		return imgUnderText;
	}
}
