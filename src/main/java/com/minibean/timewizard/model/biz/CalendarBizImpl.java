package com.minibean.timewizard.model.biz;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.minibean.timewizard.model.dao.CalendarDao;
import com.minibean.timewizard.model.dao.CalendarDaoImpl;
import com.minibean.timewizard.model.dto.CalendarDto;

@Service
public class CalendarBizImpl implements CalendarBiz{

	@Autowired
	CalendarDao calendarDao;
	
	Logger logger = LoggerFactory.getLogger(CalendarBizImpl.class);
	@Override
	public int insertCalBoard(CalendarDto dto) {
		
		return calendarDao.insertCalBoard(dto);
	}

	@Override
	public List<CalendarDto> getCalList(int user_no, String yyyymmdd) {
		
		return calendarDao.getCalList(user_no, yyyymmdd);
	}

	@Override
	public List<CalendarDto> getViewList(int user_no, String yyyyMM) {
		
		return calendarDao.getViewList(user_no, yyyyMM);
	}

	@Override
	public int getViewCount(int user_no, String yyyyMMdd) {
		
		return calendarDao.getViewCount(user_no, yyyyMMdd);
	}

	@Override

	public CalendarDto selectOne(int cal_no) {
			
		return calendarDao.selectOne( cal_no);
	}

	@Override
	public List<CalendarDto> getView(int user_no) {
		
		return calendarDao.getView(user_no);
	}

	@Override
	public int update(CalendarDto dto) {
	
		return calendarDao.update(dto);
	}

	@Override
	public int delete(int cal_no) {
		
		return calendarDao.delete(cal_no);

	}

	
}
