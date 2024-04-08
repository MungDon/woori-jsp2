package web.bean.board01;

import java.sql.Timestamp;

public class Board01DTO {
	private int num;		// 글번호
	private String writer;	// 작성자
	private String title;	// 글제목
	private String content;	// 글내용
	private Timestamp reg;	// 작성날짜
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getReg() {
		return reg;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}	
}