package com.minibean.timewizard.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.minibean.timewizard.model.dto.NoticeDto;
import com.minibean.timewizard.model.dto.PagingDto;


@Repository
public class NoticeDaoImpl implements NoticeDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	private static final Logger logger = LoggerFactory.getLogger(NoticeDaoImpl.class);
	
	@Override
	public List<NoticeDto> selectList(PagingDto pagingdto) {
		List<NoticeDto> list = new ArrayList<NoticeDto>();
		
		try {
			list = sqlSession.selectList(NAMESPACE+"selectList", pagingdto);
		} catch (Exception e) {
			logger.info("[ERROR] Notice :: selectList");
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public NoticeDto selectOne(int notice_no) {
		NoticeDto dto = null;
		
		try {
			dto = sqlSession.selectOne(NAMESPACE+"selectOne", notice_no);
		} catch (Exception e) {
			logger.info("[ERROR] Notice :: selectOne");
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public int insert(NoticeDto dto) {
		int res = 0;
		
		try {
			res = sqlSession.insert(NAMESPACE+"insert", dto);
		} catch (Exception e) {
			logger.info("[ERROR] Notice :: insert");
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int update(NoticeDto dto) {
		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE+"update", dto);
		} catch (Exception e) {
			logger.info("[ERROR] Notice :: update");
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int delete(int notice_no) {
		int res = 0;
		
		try {
			res = sqlSession.delete(NAMESPACE+"delete", notice_no);
		} catch (Exception e) {
			logger.info("[ERROR] Notice :: delete");
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int countNotice() {
		int res = 0;
		
		try {
			res = sqlSession.selectOne(NAMESPACE+"countNotice");
		} catch (Exception e) {
			logger.info("[ERROR] Notice :: countNotice");
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public List<NoticeDto> selectSearchTitle(String search_text, PagingDto pagingdto) {
		List<NoticeDto> list = new ArrayList<NoticeDto>();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("nt_title", search_text);
		map.put("pagingdto", pagingdto);
		
		try {
			list = sqlSession.selectList(NAMESPACE+"selectSearchTitle",map);
		} catch (Exception e) {
			logger.info("[ERROR] selectSearchTitle DaoImpl");
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public List<NoticeDto> selectSearchContent(String search_text, PagingDto pagingdto) {
		List<NoticeDto> list = new ArrayList<NoticeDto>();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("nt_content", search_text);
		map.put("pagingdto", pagingdto);
		
		logger.info("daodaodao nt_content : "+search_text);
		try {
			list = sqlSession.selectList(NAMESPACE+"selectSearchContent",map);
		} catch (Exception e) {
			logger.info("[ERROR] selectSearchContent DaoImpl");
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int countSearchTitle(String search_text) {
		int res = 0;
		
		try {
			res = sqlSession.selectOne(NAMESPACE+"searchcountTitle",search_text);
		} catch (Exception e) {
			logger.info("[ERROR] countSearchTitle DaoImpl");
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int countSearchContent(String search_text) {
		int res = 0;
		
		try {
			res = sqlSession.selectOne(NAMESPACE+"searchcountContent",search_text);
		} catch (Exception e) {
			logger.info("[ERROR] countSearchContent DaoImpl");
			e.printStackTrace();
		}
		return res;
	}

}






