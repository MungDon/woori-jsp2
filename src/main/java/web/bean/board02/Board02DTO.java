package web.bean.board02;
/*
create table board02(
	num			number			primary key,
	writer		varchar2(100)	not null,
	title		varchar2(100)	not null,
	content		varchar2(4000)	not null,
	passwd		varchar2(100),	
	readCount	number			default 0,
	ref			number,
	re_step		number,
	re_level	number,
	reg			date			default sysdate
);
create sequence board02_seq nocache;
commit; 
*/
import java.sql.Timestamp;

public class Board02DTO {
	private int num;			// 글번호
	private String writer;	// 작성자
	private String title;		// 글제목
	private String content;	// 글내용
	private String passwd;	// 비밀번호
	private int readCount;	// 조회수
    private int ref;				// 글 그룹 - 새로 글을쓰면 하나하나의 그룹이됨
    private int re_step;		// 스텝 - 최신글올라올때마다 스텝증가
    private int re_level;		// 레벨 -  새글,댓글 , 대댓글 위치구분
	private Timestamp reg;// 작성날짜
	
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
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public int getReadCount() {
		return readCount;
	}
	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getRe_step() {
		return re_step;
	}
	public void setRe_step(int re_step) {
		this.re_step = re_step;
	}
	public int getRe_level() {
		return re_level;
	}
	public void setRe_level(int re_level) {
		this.re_level = re_level;
	}
	public Timestamp getReg() {
		return reg;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
}