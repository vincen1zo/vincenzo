package vo;

public class AptDetailVo {
	private int aptIdx; // 아파트 idx
	private String homeType;
	private String name; //아파트이름
	private int noh; // 세대 수
	private String dateCompletion; //준공일자
	private int aptPyIdx; //아파트평수 idx
	private int py; //평수
	private String pyType; //평수타입
	private String imgUrl; //평수타입별 평면도
	private double py1; //공급면적
	private double py2; //전용면적
	private int pyTypeNoh; // 평수타입별 세대 수
	private int room;
	private int bath;
	private int housePartyIdx;
	private String coverImg;
	private String title;
	
	public AptDetailVo(int aptIdx, String homeType, String name, int noh, String dateCompletion, int aptPyIdx, int py,
			String pyType, String imgUrl, double py1, double py2, int pyTypeNoh, int room, int bath, int housePartyIdx,
			String coverImg, String title) {
		this.aptIdx = aptIdx;
		this.homeType = homeType;
		this.name = name;
		this.noh = noh;
		this.dateCompletion = dateCompletion;
		this.aptPyIdx = aptPyIdx;
		this.py = py;
		this.pyType = pyType;
		this.imgUrl = imgUrl;
		this.py1 = py1;
		this.py2 = py2;
		this.pyTypeNoh = pyTypeNoh;
		this.room = room;
		this.bath = bath;
		this.housePartyIdx = housePartyIdx;
		this.coverImg = coverImg;
		this.title = title;
	}

	public int getAptIdx() {
		return aptIdx;
	}

	public String getHomeType() {
		return homeType;
	}

	public String getName() {
		return name;
	}

	public int getNoh() {
		return noh;
	}

	public String getDateCompletion() {
		return dateCompletion;
	}

	public int getAptPyIdx() {
		return aptPyIdx;
	}

	public int getPy() {
		return py;
	}

	public String getPyType() {
		return pyType;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public double getPy1() {
		return py1;
	}

	public double getPy2() {
		return py2;
	}

	public int getPyTypeNoh() {
		return pyTypeNoh;
	}

	public int getRoom() {
		return room;
	}

	public int getBath() {
		return bath;
	}

	public int getHousePartyIdx() {
		return housePartyIdx;
	}

	public String getCoverImg() {
		return coverImg;
	}

	public String getTitle() {
		return title;
	}
}
