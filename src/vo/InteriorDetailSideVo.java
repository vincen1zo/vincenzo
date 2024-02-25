package vo;

public class InteriorDetailSideVo {
	private int interiorIdx;
	private String name;
	private int guarantee;
	private String exp;
	private double starpointAvg;
	private int conReview;
	private double starCommu;
	private double starPrice;
	private double starResult;
	private double starSchedule;
	private double starAs;
	private String title;
	private String content;
	private int oStandard;
	private int professional;
	public InteriorDetailSideVo(int interiorIdx, String name, int guarantee, String exp, double starpointAvg,
			int conReview, double starCommu, double starPrice, double starResult, double starSchedule, double starAs,
			String title, String content, int oStandard, int professional) {
		super();
		this.interiorIdx = interiorIdx;
		this.name = name;
		this.guarantee = guarantee;
		this.exp = exp;
		this.starpointAvg = starpointAvg;
		this.conReview = conReview;
		this.starCommu = starCommu;
		this.starPrice = starPrice;
		this.starResult = starResult;
		this.starSchedule = starSchedule;
		this.starAs = starAs;
		this.title = title;
		this.content = content;
		this.oStandard = oStandard;
		this.professional = professional;
	}
	public int getInteriorIdx() {
		return interiorIdx;
	}
	public String getName() {
		return name;
	}
	public int getGuarantee() {
		return guarantee;
	}
	public String getExp() {
		return exp;
	}
	public double getStarpointAvg() {
		return starpointAvg;
	}
	public int getConReview() {
		return conReview;
	}
	public double getStarCommu() {
		return starCommu;
	}
	public double getStarPrice() {
		return starPrice;
	}
	public double getStarResult() {
		return starResult;
	}
	public double getStarSchedule() {
		return starSchedule;
	}
	public double getStarAs() {
		return starAs;
	}
	public String getTitle() {
		return title;
	}
	public String getContent() {
		return content;
	}
	public int getoStandard() {
		return oStandard;
	}
	public int getProfessional() {
		return professional;
	}
	
}
