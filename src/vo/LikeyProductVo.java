package vo;

public class LikeyProductVo {
	private String memberId;
	private String likeDate;
	private int productIdx;
	private String brandName;
	private String name;
	private int discount;
	private int afterPrice;
	private double starReviewAvg;
	private int freeDeli;
	private int category;
	private int imgIdx;
	private String imgUrl;
	
	public LikeyProductVo(String memberId, String likeDate, int productIdx, 
			String brandName, String name, int discount, int afterPrice, 
			double starReviewAvg, int freeDeli, int category, int imgIdx, String imgUrl) {
		this.memberId = memberId;
		this.likeDate = likeDate;
		this.productIdx = productIdx;
		this.brandName = brandName;
		this.name = name;
		this.discount = discount;
		this.afterPrice = afterPrice;
		this.starReviewAvg = starReviewAvg;
		this.freeDeli = freeDeli;
		this.category = category;
		this.imgIdx = imgIdx;
		this.imgUrl = imgUrl;
	}

	public String getMemberId() {
		return memberId;
	}

	public String getLikeDate() {
		return likeDate;
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

	public int getCategory() {
		return category;
	}

	public int getImgIdx() {
		return imgIdx;
	}

	public String getImgUrl() {
		return imgUrl;
	}
}