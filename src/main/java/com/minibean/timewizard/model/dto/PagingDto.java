package com.minibean.timewizard.model.dto;

public class PagingDto {
	private int nowpage;
	private int startpage;
	private int endpage;
	private int total;
	private int cntPerpage;
	private int lastpage;
	private int start;
	private int end;
	private int cntpage=5;
	
	
public PagingDto() {}
	
	public PagingDto(int total, int nowpage, int cntPerpage) {
		setNowpage(nowpage);
		setCntPerpage(cntPerpage);
		setTotal(total);
		calcLastPage(getTotal(), getCntPerpage());
		calcStartEndPage(getNowpage(), cntpage);
		calcStartEnd(getNowpage(), getCntPerpage());
	}

	//마지막 페이지 계산
	public void calcLastPage(int total, int cntPerpage) {
		setLastpage((int)Math.ceil((double)total / (double)cntPerpage));
	}
	
	//시작, 끝 페이지 계산
	public void calcStartEndPage(int nowpage, int cntpage) {
		setEndpage(((int)Math.ceil((double)nowpage / (double)cntpage)) * cntpage);
		if(getLastpage() < getEndpage()) {
			setEndpage(getLastpage());
		}
		setStartpage(getEndpage() - cntpage + 1);
		if(getStartpage() < 1) {
			setStartpage(1);	
		}
	}
	
	//DB쿼리에서 계산할  start, end 계산
	public void calcStartEnd(int nowpage, int cntPerpage) {
		setEnd(nowpage * cntPerpage);
		setStart(getEnd() - cntPerpage + 1);
	}

	public int getNowpage() {
		return nowpage;
	}

	public void setNowpage(int nowpage) {
		this.nowpage = nowpage;
	}

	public int getStartpage() {
		return startpage;
	}

	public void setStartpage(int startpage) {
		this.startpage = startpage;
	}

	public int getEndpage() {
		return endpage;
	}

	public void setEndpage(int endpage) {
		this.endpage = endpage;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getCntPerpage() {
		return cntPerpage;
	}

	public void setCntPerpage(int cntPerpage) {
		this.cntPerpage = cntPerpage;
	}

	public int getLastpage() {
		return lastpage;
	}

	public void setLastpage(int lastpage) {
		this.lastpage = lastpage;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	public int getCntpage() {
		return cntpage;
	}

	public void setCntpage(int cntpage) {
		this.cntpage = cntpage;
	}



}
