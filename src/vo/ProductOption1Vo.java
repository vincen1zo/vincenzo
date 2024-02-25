package vo;

public class ProductOption1Vo {
	private int optionIdx;
	private String option1Value;
	private int option1Price;
	
	public ProductOption1Vo(int optionIdx, String option1Value, int option1Price) {
		this.optionIdx = optionIdx;
		this.option1Value = option1Value;
		this.option1Price = option1Price;
	}

	public int getOptionIdx() {
		return optionIdx;
	}

	public String getOption1Value() {
		return option1Value;
	}

	public int getOption1Price() {
		return option1Price;
	}
}
