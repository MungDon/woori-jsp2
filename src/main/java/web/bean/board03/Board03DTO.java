package web.bean.board03;

import java.sql.Timestamp;

public class Board03DTO {
	
	private int num;				// 글 번호
		
	private String title;			// 글 제목
	
	private String img;			// 이미지 이름
	
	private Timestamp reg;	// 생성일시
	
	
	/*setter()*/
	public void setNum(int num) {
		this.num = num;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public void setImg(String img) {
		this.img = img;
	}
	
	public void setReg(Timestamp reg) {
		this.reg  = reg;
	}
	
	/*getter()*/
	public int getNum() {
		return num;
	}
	
	public String getTitle() {
		return title;
	}
	
	public String getImg() {
		return img;
	}
	
	public Timestamp getReg() {
		return reg;
	}
}
