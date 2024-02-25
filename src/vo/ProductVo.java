package vo;

public class ProductVo {
	private int productIdx;
	private String brandName;
	private String name;
	private int discount;
	private int beforePrice;
	private int afterPrice;
	private double starReviewAvg;
	private int freeDeli;
	private int category;
	
	public ProductVo(int productIdx, String brandName, String name, int discount, int beforePrice, int afterPrice,
			double starReviewAvg, int freeDeli, int category) {
		this.productIdx = productIdx;
		this.brandName = brandName;
		this.name = name;
		this.discount = discount;
		this.beforePrice = beforePrice;
		this.afterPrice = afterPrice;
		this.starReviewAvg = starReviewAvg;
		this.freeDeli = freeDeli;
		this.category = category;
	}

	public int getProductIdx() {
		return productIdx;
	}

	public String getBrandName() {
		return brandName;
	}

	public String getName() {
		return name;
	}

	public int getDiscount() {
		return discount;
	}

	public int getBeforePrice() {
		return beforePrice;
	}

	public int getAfterPrice() {
		return afterPrice;
	}

	public double getStarReviewAvg() {
		return starReviewAvg;
	}

	public int getFreeDeli() {
		return freeDeli;
	}

	public int getCategory() {
		return category;
	}

	@Override
	public String toString() {
		return "ProductVo [productIdx=" + productIdx + ", brandName=" + brandName + ", name=" + name + ", discount="
				+ discount + ", beforePrice=" + beforePrice + ", afterPrice=" + afterPrice + ", starReviewAvg="
				+ starReviewAvg + ", freeDeli=" + freeDeli + ", category=" + category + "]";
	}
	
	
}
