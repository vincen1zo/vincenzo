package vo;

public class MypageShoppingListVo {
	private String memberId;
	private int orderIdx;
	private int productIdx;
	private int imgIdx;
	private String imgUrl;
	private String brandName;
	private String name;
	private int optionIdx;
	private String optionValue;
	private String processedState;
	private String orderDate;
	private String paymentDate;
	private int qty;
	private int afterPrice;
	
	public MypageShoppingListVo(String memberId, int orderIdx, int productIdx, int imgIdx, String imgUrl,
			String brandName, String name, int optionIdx, String optionValue, String processedState, String orderDate,
			String paymentDate, int qty, int afterPrice) {
		this.memberId = memberId;
		this.orderIdx = orderIdx;
		this.productIdx = productIdx;
		this.imgIdx = imgIdx;
		this.imgUrl = imgUrl;
		this.brandName = brandName;
		this.name = name;
		this.optionIdx = optionIdx;
		this.optionValue = optionValue;
		this.processedState = processedState;
		this.orderDate = orderDate;
		this.paymentDate = paymentDate;
		this.qty = qty;
		this.afterPrice = afterPrice;
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

	public String getOptionValue() {
		return optionValue;
	}

	public String getProcessedState() {
		return processedState;
	}

	public String getOrderDate() {
		return orderDate;
	}

	public String getPaymentDate() {
		return paymentDate;
	}

	public int getQty() {
		return qty;
	}

	public int getAfterPrice() {
		return afterPrice;
	}
	
	
}
