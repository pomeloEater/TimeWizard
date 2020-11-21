package com.minibean.timewizard.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.minibean.timewizard.model.dao.NoticeDao;
import com.minibean.timewizard.model.dto.NoticeDto;
import com.minibean.timewizard.model.dto.PagingDto;
@Service
public class NoticeBizImpl implements NoticeBiz {
	
	@Autowired
	private NoticeDao noticeDao;
	
	@Override
	public List<NoticeDto> selectList(PagingDto pagingdto) {
		return noticeDao.selectList(pagingdto);
	}

	@Override
	public NoticeDto selectOne(int notice_no) {
		return noticeDao.selectOne(notice_no);
	}

	@Override
	public int insert(NoticeDto dto) {
		return noticeDao.insert(dto);
	}

	@Override
	public int update(NoticeDto dto) {
		return noticeDao.update(dto);
	}

	@Override
	public int delete(int notice_no) {
		return noticeDao.delete(notice_no);
	}

	@Override
	public int countNotice() {
	
		return noticeDao.countNotice();
	}

	@Override
	public List<NoticeDto> selectSearchTitle(String search_text, PagingDto pagingdto) {
		
		return noticeDao.selectSearchTitle(search_text, pagingdto);
	}

	@Override
	public List<NoticeDto> selectSearchContent(String search_text, PagingDto pagingdto) {
		
		return noticeDao.selectSearchContent(search_text, pagingdto);
	}

	@Override
	public int countSearchTitle(String search_text) {
		
		return noticeDao.countSearchTitle(search_text);
	}

	@Override
	public int countSearchContent(String search_text) {
		
		return noticeDao.countSearchContent(search_text);
	}

}
