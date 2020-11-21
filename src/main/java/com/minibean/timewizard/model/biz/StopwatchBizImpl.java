package com.minibean.timewizard.model.biz;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.minibean.timewizard.model.dao.StopwatchDao;
import com.minibean.timewizard.model.dto.StopwatchDto;

@Service
public class StopwatchBizImpl implements StopwatchBiz {

	@Autowired private StopwatchDao stopwatchDao;
	
	@Override
	public List<StopwatchDto> selectList(Date date) {
		return stopwatchDao.selectList(date);
	}

	@Override
	public List<StopwatchDto> selectOne(int todo_no) {
		return stopwatchDao.selectOne(todo_no);
	}

	@Override
	public int insert(StopwatchDto dto) {
		return stopwatchDao.insert(dto);
	}

	@Override
	public int update(StopwatchDto dto) {
		return stopwatchDao.update(dto);
	}

	@Override
	public int delete(int todo_no) {
		return stopwatchDao.delete(todo_no);
	}

}
