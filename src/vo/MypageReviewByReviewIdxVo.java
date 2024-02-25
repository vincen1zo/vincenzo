package vo;

public class MypageReviewByReviewIdxVo {
	int reviewIdx;
	String brandName;
	String name;
	String option1Value;
	String content;
	int starDurability;
	int starPrice;
	int starDesign;
	int starDelivery;
	String imgUrl;
	
	public MypageReviewByReviewIdxVo(int reviewIdx, String brandName, String name, String option1Value, String content,
			int starDurability, int starPrice, int starDesign, int starDelivery, String imgUrl) {
		this.reviewIdx = reviewIdx;
		this.brandName = brandName;
		this.name = name;
		this.option1Value = option1Value;
		this.content = content;
		this.starDurability = starDurability;
		this.starPrice = starPrice;
		this.starDesign = starDesign;
		this.starDelivery = starDelivery;
		this.imgUrl = imgUrl;
	}

	public int getReviewIdx() {
		return reviewIdx;
	}

	public String getBrandName() {
		return brandName;
	}

	public String getName() {
		return name;
	}

	public String getOption1Value() {
		return option1Value;
	}

	public String getContent() {
		return content;
	}

	public int getStarDurability() {
		return starDurability;
	}

	public int getStarPrice() {
		return starPrice;
	}

	public int getStarDesign() {
		return starDesign;
	}

	public int getStarDelivery() {
		return starDelivery;
	}

	public String getImgUrl() {
		return imgUrl;
	}
}
