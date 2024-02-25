package vo;

public class ODealVo {
	private int productIdx;
	private String brandName;
	private String name;
	private int discount;
	private int afterPrice;
	private double starReviewAvg;
	private int freeDeli;
	private String openDate;
	private String closeDate;
	
	public ODealVo(int productIdx, String brandName, String name, int discount, int afterPrice, double starReviewAvg,
			int freeDeli, String openDate, String closeDate) {
		this.productIdx = productIdx;
		this.brandName = brandName;
		this.name = name;
		this.discount = discount;
		this.afterPrice = afterPrice;
		this.starReviewAvg = starReviewAvg;
		this.freeDeli = freeDeli;
		this.openDate = openDate;
		this.closeDate = closeDate;
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

	public int getAfterPrice() {
		return afterPrice;
	}

	public double getStarReviewAvg() {
		return starReviewAvg;
	}

	public int getFreeDeli() {
		return freeDeli;
	}

	public String getOpenDate() {
		return openDate;
	}

	public String getCloseDate() {
		return closeDate;
	}
}
