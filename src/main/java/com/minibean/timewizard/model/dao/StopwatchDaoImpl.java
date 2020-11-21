package com.minibean.timewizard.model.dao;

import java.util.Date;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.LoggerFactory;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.minibean.timewizard.model.dto.StopwatchDto;

@Repository
public class StopwatchDaoImpl implements StopwatchDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	private Logger logger = LoggerFactory.getLogger(StopwatchDaoImpl.class);
	
	@Override
	public List<StopwatchDto> selectList(Date date) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<StopwatchDto> selectOne(int todo_no) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insert(StopwatchDto dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int update(StopwatchDto dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(int todo_no) {
		// TODO Auto-generated method stub
		return 0;
	}

}
