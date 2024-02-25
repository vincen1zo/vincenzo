package vo;

public class QAMainVo {
	private int qa_id;
	private int qa_order_idx;
	private String q;
	
	public QAMainVo(int qa_id, int qa_order_idx, String q) {
		this.qa_id = qa_id;
		this.qa_order_idx = qa_order_idx;
		this.q = q;
	}
	public int getQa_id() {
		return qa_id;
	}
	public int getQa_order_idx() {
		return qa_order_idx;
	}
	public String getq() {
		return q;
	}
}
