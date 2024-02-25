package vo;

public class BasketVo {
	private String memberId;
	private int orderIdx;
	private int productIdx;
	private int imgIdx;
	private String imgUrl;
	private String brandName;
	private String name;
	private int optioinIdx;
	private String option1Value;
	private String processedState;
	private String deli;
	private String deliCost;
	private int Qty;
	int option1Price;
	int freeDeli;
	
	public BasketVo(String memberId, int orderIdx, int productIdx, int imgIdx, String imgUrl, String brandName,
			String name, int optioinIdx, String option1Value, String processedState, String deli, String deliCost,
			int qty, int option1Price, int freeDeli) {
		this.memberId = memberId;
		this.orderIdx = orderIdx;
		this.productIdx = productIdx;
		this.imgIdx = imgIdx;
		this.imgUrl = imgUrl;
		this.brandName = brandName;
		this.name = name;
		this.optioinIdx = optioinIdx;
		this.option1Value = option1Value;
		this.processedState = processedState;
		this.deli = deli;
		this.deliCost = deliCost;
		Qty = qty;
		this.option1Price = option1Price;
		this.freeDeli = freeDeli;
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

	public int getOptioinIdx() {
		return optioinIdx;
	}

	public String getOption1Value() {
		return option1Value;
	}

	public String getProcessedState() {
		return processedState;
	}

	public String getDeli() {
		return deli;
	}

	public String getDeliCost() {
		return deliCost;
	}

	public int getQty() {
		return Qty;
	}

	public int getOption1Price() {
		return option1Price;
	}

	public int getFreeDeli() {
		return freeDeli;
	}
}
