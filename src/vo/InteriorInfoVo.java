package vo;

public class InteriorInfoVo {
	private int interiorNoticeIdx;
	private String title;
	private String content;
	private String imgUrl;
	private int interiorIdx;
	private String field;
	private int recentContracts;
	private String AsYear;
	private String career;
	private String service;
	
	public InteriorInfoVo(int interiorNoticeIdx, String title, String content, String imgUrl, int interiorIdx,
			String field, int recentContracts, String asYear, String career, String service) {
		this.interiorNoticeIdx = interiorNoticeIdx;
		this.title = title;
		this.content = content;
		this.imgUrl = imgUrl;
		this.interiorIdx = interiorIdx;
		this.field = field;
		this.recentContracts = recentContracts;
		AsYear = asYear;
		this.career = career;
		this.service = service;
	}

	public int getInteriorNoticeIdx() {
		return interiorNoticeIdx;
	}

	public String getTitle() {
		return title;
	}

	public String getContent() {
		return content;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public int getInteriorIdx() {
		return interiorIdx;
	}

	public String getField() {
		return field;
	}

	public int getRecentContracts() {
		return recentContracts;
	}

	public String getAsYear() {
		return AsYear;
	}

	public String getCareer() {
		return career;
	}

	public String getService() {
		return service;
	}
}
