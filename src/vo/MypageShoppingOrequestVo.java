package vo;

public class MypageShoppingOrequestVo {
	private String name;
	private String brandName;
	private int inquiryIdx;
	private int productIdx;
	private int orderIdx;
	private int orderProductOption;
	private String category;
	private String status;
	private String memberId;
	private String q;
	private String qWritedate;
	private String a;
	private String aWritedate;
	private String processedState;
	private String option1Value;
	private String option2Value;
	private String option3Value;
	
	public MypageShoppingOrequestVo(String name, String brandName, int inquiryIdx, int productIdx, int orderIdx,
			int orderProductOption, String category, String status, String memberId, String q, String qWritedate,
			String a, String aWritedate, String processedState, String option1Value, String option2Value,
			String option3Value) {
	
		this.name = name;
		this.brandName = brandName;
		this.inquiryIdx = inquiryIdx;
		this.productIdx = productIdx;
		this.orderIdx = orderIdx;
		this.orderProductOption = orderProductOption;
		this.category = category;
		this.status = status;
		this.memberId = memberId;
		this.q = q;
		this.qWritedate = qWritedate;
		this.a = a;
		this.aWritedate = aWritedate;
		this.processedState = processedState;
		this.option1Value = option1Value;
		this.option2Value = option2Value;
		this.option3Value = option3Value;
	}

	public String getName() {
		return name;
	}

	public String getBrandName() {
		return brandName;
	}

	public int getInquiryIdx() {
		return inquiryIdx;
	}

	public int getProductIdx() {
		return productIdx;
	}

	public int getOrderIdx() {
		return orderIdx;
	}

	public int getOrderProductOption() {
		return orderProductOption;
	}

	public String getCategory() {
		return category;
	}

	public String getStatus() {
		return status;
	}

	public String getMemberId() {
		return memberId;
	}

	public String getQ() {
		return q;
	}

	public String getqWritedate() {
		return qWritedate;
	}

	public String getA() {
		return a;
	}

	public String getaWritedate() {
		return aWritedate;
	}

	public String getProcessedState() {
		return processedState;
	}

	public String getOption1Value() {
		return option1Value;
	}

	public String getOption2Value() {
		return option2Value;
	}

	public String getOption3Value() {
		return option3Value;
	}
	
}
