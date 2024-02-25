package vo;

public class InteriorMainVo {
	private int interiorIdx;
	private int imgOrder;
	private String imgUrl;
	private int oStandard;
	private String name;
	private int guarantee;
	private Double starpointAvg;
	private int conReview;
	private int recentContracts;
	private String priceRange;
	private String title;
	private String content;
	private double distance;
	
	public InteriorMainVo(int interiorIdx, int imgOrder, String imgUrl, int oStandard, String name, int guarantee,
			Double starpointAvg, int conReview, int recentContracts, String priceRange, String title, String content,
			double distance) {
		this.interiorIdx = interiorIdx;
		this.imgOrder = imgOrder;
		this.imgUrl = imgUrl;
		this.oStandard = oStandard;
		this.name = name;
		this.guarantee = guarantee;
		this.starpointAvg = starpointAvg;
		this.conReview = conReview;
		this.recentContracts = recentContracts;
		this.priceRange = priceRange;
		this.title = title;
		this.content = content;
		this.distance = distance;
	}

	public int getInteriorIdx() {
		return interiorIdx;
	}

	public int getImgOrder() {
		return imgOrder;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public int getoStandard() {
		return oStandard;
	}

	public String getName() {
		return name;
	}

	public int getGuarantee() {
		return guarantee;
	}

	public Double getStarpointAvg() {
		return starpointAvg;
	}

	public int getConReview() {
		return conReview;
	}

	public int getRecentContracts() {
		return recentContracts;
	}

	public String getPriceRange() {
		return priceRange;
	}

	public String getTitle() {
		return title;
	}

	public String getContent() {
		return content;
	}

	public double getDistance() {
		return distance;
	}
	
	
}
