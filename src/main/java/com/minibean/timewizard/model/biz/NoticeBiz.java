package com.minibean.timewizard.model.biz;

import java.util.List;

import com.minibean.timewizard.model.dto.NoticeDto;
import com.minibean.timewizard.model.dto.PagingDto;

public interface NoticeBiz {
	
	public List<NoticeDto> selectList(PagingDto pagindto);
	public NoticeDto selectOne(int notice_no);
	public int insert(NoticeDto dto);
	public int update(NoticeDto dto);
	public int delete(int notice_no);
	
	public int countNotice();
	
	public List<NoticeDto> selectSearchTitle(String search_text, PagingDto pagingdto);
	public List<NoticeDto> selectSearchContent(String search_text, PagingDto pagingdto);
	
	public int countSearchTitle(String search_text);
	public int countSearchContent(String search_text);

}
