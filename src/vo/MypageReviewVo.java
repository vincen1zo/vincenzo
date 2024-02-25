package vo;

public class MypageReviewVo {
	private String memberId;
	private int orderIdx;
	private int productIdx;
	private int imgIdx;
	private String imgUrl;
	private String brandName;
	private String name;
	private int optionIdx;
	private String option1Value;
	private String processedState;
	
	public MypageReviewVo(String memberId, int orderIdx, int productIdx, int imgIdx, String imgUrl, String brandName,
			String name, int optionIdx, String option1Value, String processedState) {
		super();
		this.memberId = memberId;
		this.orderIdx = orderIdx;
		this.productIdx = productIdx;
		this.imgIdx = imgIdx;
		this.imgUrl = imgUrl;
		this.brandName = brandName;
		this.name = name;
		this.optionIdx = optionIdx;
		this.option1Value = option1Value;
		this.processedState = processedState;
	}

	public String getMemberId() {
		return memberId;
	}

	public int getOrderIdx() {
		return orderIdx;
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

	public String getBrandName() {
		return brandName;
	}

	public String getName() {
		return name;
	}

	public int getOptionIdx() {
		return optionIdx;
	}

	public String getOption1Value() {
		return option1Value;
	}

	public String getProcessedState() {
		return processedState;
	}
}
