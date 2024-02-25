package vo;

public class ConReviewVo {
	private String name;// 업체이름
	private int reviewIdx;   // 리뷰번호
	private int interiorIdx;   // 업체번호
	private String profileImg;
	private String memberId;
	private int conReview;    // 계약여부(1:true,0:false)
	private String writedate; // 작성일자
	private int oCon;		  // 오늘의집통해서계약여부(1:true,0:false)
	private String conTime;   // 시공시기(ex. "2021.04")
	private int conPriceLow;  // 시공가격
	private int conPriceHigh;  // 시공가격
	private String address;
	private String homeType;   // ex. "아파트"
	private String conField;   // 시공분야
	private String py;			// 평수 (ex. "30평대")
	private int imgOrder;		// 이미지순서번호
	private String imgUrl;		
	private String content;
	private int likeyCount;     // 좋아요 개수(likey 테이블에서 조회)
	
	public ConReviewVo(String name, int reviewIdx, int interiorIdx, String profileImg, String memberId, int conReview,
			String writedate, int oCon, String conTime, int conPriceLow, int conPriceHigh, String address,
			String homeType, String conField, String py, int imgOrder, String imgUrl, String content, int likeyCount) {
		super();
		this.name = name;
		this.reviewIdx = reviewIdx;
		this.interiorIdx = interiorIdx;
		this.profileImg = profileImg;
		this.memberId = memberId;
		this.conReview = conReview;
		this.writedate = writedate;
		this.oCon = oCon;
		this.conTime = conTime;
		this.conPriceLow = conPriceLow;
		this.conPriceHigh = conPriceHigh;
		this.address = address;
		this.homeType = homeType;
		this.conField = conField;
		this.py = py;
		this.imgOrder = imgOrder;
		this.imgUrl = imgUrl;
		this.content = content;
		this.likeyCount = likeyCount;
	}
	
	public String getName() {
		return name;
	}
	public int getReviewIdx() {
		return reviewIdx;
	}
	public int getInteriorIdx() {
		return interiorIdx;
	}
	public String getProfileImg() {
		return profileImg;
	}
	public String getMemberId() {
		return memberId;
	}
	public int getConReview() {
		return conReview;
	}
	public String getWritedate() {
		return writedate;
	}
	public int getoCon() {
		return oCon;
	}
	public String getConTime() {
		return conTime;
	}
	public int getConPriceLow() {
		return conPriceLow;
	}
	public int getConPriceHigh() {
		return conPriceHigh;
	}
	public String getAddress() {
		return address;
	}
	public String getHomeType() {
		return homeType;
	}
	public String getConField() {
		return conField;
	}
	public String getPy() {
		return py;
	}
	public int getImgOrder() {
		return imgOrder;
	}
	public String getImgUrl() {
		return imgUrl;
	}
	public String getContent() {
		return content;
	}
	public int getLikeyCount() {
		return likeyCount;
	}
	
}