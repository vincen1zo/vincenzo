package vo;

public class NoticeVo {
	private int noticeIdx;
	private String title;
	private String writedate;
	private String content;
	
	public NoticeVo(int noticeIdx, String title, String writedate, String content) {
		this.noticeIdx = noticeIdx;
		this.title = title;
		this.writedate = writedate;
		this.content = content;
	}

	public int getNoticeIdx() {
		return noticeIdx;
	}

	public String getTitle() {
		return title;
	}

	public String getWritedate() {
		return writedate;
	}
	
	public String getContent() {
		return content;
	}
}
