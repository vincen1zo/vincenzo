package vo;

public class ProductAllVo {
	private int productIdx;
	private String brandName;
	private String name;
	private int discount;
	private int afterPrice;
	private double starReviewAvg;
	private String imgUrl;
	private int imgIdx;
	
	public ProductAllVo(int productIdx, String barndName, String name, int discount, int afterPrice,
			double starReviewAvg, String imgUrl, int imgIdx) {
		this.productIdx = productIdx;
		this.brandName = barndName;
		this.name = name;
		this.discount = discount;
		this.afterPrice = afterPrice;
		this.starReviewAvg = starReviewAvg;
		this.imgUrl = imgUrl;
		this.imgIdx = imgIdx;
	}

	public int getProductIdx() {
		return productIdx;
	}

	public String getBarndName() {
		return brandName;
	}

	public String getName() {
		return name;
	}

	public int getDiscount() {
		return discount;
	}

	public int getAfterPrice() {
		return afterPrice;
	}

	public double getStarReviewAvg() {
		return starReviewAvg;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public int getImgIdx() {
		return imgIdx;
	}
}
