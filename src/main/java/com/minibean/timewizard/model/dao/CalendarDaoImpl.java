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

import com.minibean.timewizard.model.dto.CalendarDto;

@Repository
public class CalendarDaoImpl implements CalendarDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	Logger logger = LoggerFactory.getLogger(CalendarDaoImpl.class);
	
	public int insertCalBoard(CalendarDto dto) {
		logger.info(" < Calendar Insert > ");
		int res = 0;
		
		try {
			res =sqlSession.insert(NAMESPACE+"insertCalBoard",dto);
		} catch (Exception e) {
			logger.info(" [ Error : Calendar Insert ");
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public List<CalendarDto> getCalList(int user_no, String yyyyMMdd) {
		logger.info(" < getCalendarList > ");
		List<CalendarDto>list = new ArrayList<CalendarDto>();
		Map<Object, Object>map = new HashMap<Object, Object>();
		map.put("user_no",user_no);
		map.put("yyyyMMdd", yyyyMMdd);
		
		logger.info(" CalList에 담긴 map 값 : "+map);
	
		try {
			list =sqlSession.selectList(NAMESPACE+"getCalList",map);
		} catch (Exception e) {
			logger.info(" [ Error : getCalendarList ] ");
			e.printStackTrace();
		}
		
	
		return list;
	}

	@Override
	public List<CalendarDto> getViewList(int user_no, String yyyyMM) {
		
		logger.info(" < getViewList > ");
		List<CalendarDto>list = new ArrayList<CalendarDto>();
		Map<Object, Object>map = new HashMap<Object, Object>();
		
		map.put("user_no",user_no);
		map.put("yyyyMM", yyyyMM);
		logger.info(" ***********************************************값이 들어오는지 확인: "+map);
		
		
		try {
									
			list = sqlSession.selectList(NAMESPACE+"getViewList",map);
		} catch (Exception e) {
			//요 애러
			logger.info(" [ Error : getViewList ] ");
			e.printStackTrace();
		}
		
		return list;
	}

	@Override									//yyyyMMdd로도 해보고 yyyyMM으로도 해보자
	public int getViewCount(int user_no, String yyyyMM) {
		logger.info(" < getVieWCount > ");
		Map<Object, Object>map = new HashMap<Object, Object>();
		map.put("user_no",user_no);
		map.put("yyyyMM",yyyyMM);
		
		int count = 0;
		try {
			count= sqlSession.insert(NAMESPACE+"getViewCount",map);
		} catch (Exception e) {
			logger.info(" [ Error : getViewCount ] ");
			e.printStackTrace();
		}
		
		return count;
	}

	public CalendarDto selectOne(int cal_no) {
		CalendarDto dto = new CalendarDto();
		logger.info("< Select One > ");
		
		try {
			dto = sqlSession.selectOne(NAMESPACE+"selectOne",cal_no);
		} catch (Exception e) {
			logger.info(" [ Error : Select One ] ");
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public List<CalendarDto> getView(int user_no) {
		List<CalendarDto> list = new ArrayList<CalendarDto>();
		logger.info(" < Get View > ");
		try {
			list = sqlSession.selectList(NAMESPACE+"getView",user_no);
		} catch (Exception e) {
			logger.info(" [ Error : Get View ] " );
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public int update(CalendarDto dto) {
		logger.info(" < Update >");
		int res=0;
		try {
			res =sqlSession.update(NAMESPACE+"update",dto);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int delete(int cal_no) {
		logger.info(" < Delete > ");
		int res=0;
		try {
			res =sqlSession.delete(NAMESPACE+"delete",cal_no);
		} catch (Exception e) {
			logger.info(" [ Error : Delete ] ");
			e.printStackTrace();
		}
		return res;
	}
	
	

	
}
