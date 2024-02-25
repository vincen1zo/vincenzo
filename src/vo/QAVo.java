package vo;

public class QAVo {
	private int qaId;
	private String category;
	private String question;
	private String answer;

	public QAVo(int qaId, String category, String question, String answer) {
		this.qaId = qaId;
		this.category = category;
		this.question = question;
		this.answer = answer;
	}

	public int getQaId() {
		return qaId;
	}

	public String getCategory() {
		return category;
	}

	public String getQuestion() {
		return question;
	}

	public String getAnswer() {
		return answer;
	}
	
}
