package vo;

public class HousepartyPlusIconVo {
	private int picWriteIdx;
	private int productIdx;
	private double xCoordinates;
	private double yCoordinates;
	private String note;
	
	public HousepartyPlusIconVo(int picWriteIdx, int productIdx, double xCoordinates, double yCoordinates,
			String note) {
		this.picWriteIdx = picWriteIdx;
		this.productIdx = productIdx;
		this.xCoordinates = xCoordinates;
		this.yCoordinates = yCoordinates;
		this.note = note;
	}

	public int getPicWriteIdx() {
		return picWriteIdx;
	}

	public int getProductIdx() {
		return productIdx;
	}

	public double getxCoordinates() {
		return xCoordinates;
	}

	public double getyCoordinates() {
		return yCoordinates;
	}

	public String getNote() {
		return note;
	}
}
