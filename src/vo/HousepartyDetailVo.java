package vo;

public class HousepartyDetailVo {
	private int housepartyIdx;
	private String coverImg;
	private String title;
	private String memberId;
	private int interiorIdx;
	private String writeDate;
	private int likeyCount;
	private int commentCount;
	private int hitCount;
	private int shareCount;
	private String homeType;
	private int py;
	private String part;
	private String familyType;
	private String worker;
	private int room;
	private String direction;
	private String year;
	private String area;
	private String style;
	private String pet;
	private int familyNum;
	private String detailConScope;
	private String period;
	private int budgetLow;
	private int budgetHigh;
	private String profileImg;
	
	public HousepartyDetailVo(int housepartyIdx, String coverImg, String title, String memberId, int interiorIdx,
			String writeDate, int likeyCount, int commentCount, int hitCount, int shareCount, String homeType, int py,
			String part, String familyType, String worker, int room, String direction, String year, String area,
			String style, String pet, int familyNum, String detailConScope, String period, int budgetLow,
			int budgetHigh, String profileImg) {
		this.housepartyIdx = housepartyIdx;
		this.coverImg = coverImg;
		this.title = title;
		this.memberId = memberId;
		this.interiorIdx = interiorIdx;
		this.writeDate = writeDate;
		this.likeyCount = likeyCount;
		this.commentCount = commentCount;
		this.hitCount = hitCount;
		this.shareCount = shareCount;
		this.homeType = homeType;
		this.py = py;
		this.part = part;
		this.familyType = familyType;
		this.worker = worker;
		this.room = room;
		this.direction = direction;
		this.year = year;
		this.area = area;
		this.style = style;
		this.pet = pet;
		this.familyNum = familyNum;
		this.detailConScope = detailConScope;
		this.period = period;
		this.budgetLow = budgetLow;
		this.budgetHigh = budgetHigh;
		this.profileImg = profileImg;
	}

	public int getHousepartyIdx() {
		return housepartyIdx;
	}

	public String getCoverImg() {
		return coverImg;
	}

	public String getTitle() {
		return title;
	}

	public String getMemberId() {
		return memberId;
	}

	public int getInteriorIdx() {
		return interiorIdx;
	}

	public String getWriteDate() {
		return writeDate;
	}

	public int getLikeyCount() {
		return likeyCount;
	}

	public int getCommentCount() {
		return commentCount;
	}

	public int getHitCount() {
		return hitCount;
	}

	public int getShareCount() {
		return shareCount;
	}

	public String getHomeType() {
		return homeType;
	}

	public int getPy() {
		return py;
	}

	public String getPart() {
		return part;
	}

	public String getFamilyType() {
		return familyType;
	}

	public String getWorker() {
		return worker;
	}

	public int getRoom() {
		return room;
	}

	public String getDirection() {
		return direction;
	}

	public String getYear() {
		return year;
	}

	public String getArea() {
		return area;
	}

	public String getStyle() {
		return style;
	}

	public String getPet() {
		return pet;
	}

	public int getFamilyNum() {
		return familyNum;
	}

	public String getDetailConScope() {
		return detailConScope;
	}

	public String getPeriod() {
		return period;
	}

	public int getBudgetLow() {
		return budgetLow;
	}

	public int getBudgetHigh() {
		return budgetHigh;
	}
	
	public String getProfileImg() {
		return profileImg;
	}
}
