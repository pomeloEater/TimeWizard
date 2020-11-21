package com.minibean.timewizard.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.minibean.timewizard.model.dto.UserTodoDto;
import com.minibean.timewizard.model.dto.WeeklyDto;

@Repository
public class UserTodoDaoImpl implements UserTodoDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	private Logger logger = LoggerFactory.getLogger(UserTodoDaoImpl.class);
	

	@Override
	public List<UserTodoDto> selectList(int user_no) {
		logger.info(">> [USERTODO] selectList");
		List<UserTodoDto> result = new ArrayList<UserTodoDto>();
		try {
			result = sqlSession.selectList(NAMESPACE+"selectList", user_no);
		} catch (Exception e) {
			logger.info("[ERROR] USERTODO :: selectList");
			e.printStackTrace();
		}
		return result;
	}
	@Override
	public int countList(int user_no) {
		logger.info(">> [USERTODO] countList");
		int res = 0;
		try {
			res = sqlSession.selectOne(NAMESPACE+"countList", user_no);
		} catch (Exception e) {
			logger.info("[ERROR] USERTODO :: countList");
			e.printStackTrace();
		}
		return res;
	}
	
	@Override
	public List<UserTodoDto> selectList(HashMap<String, Object> params) {
		logger.info(">> [USERTODO] selectList By todo_date");
		List<UserTodoDto> result = new ArrayList<UserTodoDto>();
		try {
			result = sqlSession.selectList(NAMESPACE+"selectListTodoDate", params);
		} catch (Exception e) {
			logger.info("[ERROR] USERTODO :: selectList By todo_date");
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public UserTodoDto selectOne(int todo_no) {
		logger.info(">> [USERTODO] selectOne by todo number - " + todo_no);
		UserTodoDto result = null;
		try {
			result = sqlSession.selectOne(NAMESPACE+"selectOne", todo_no);
		} catch (Exception e) {
			logger.info("[ERROR] USERTODO :: selectOne by todo number - " + todo_no);
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int insert(UserTodoDto dto) {
		logger.info(">> [USERTODO] insert");
		int res = 0;
		
		try {
			res = sqlSession.insert(NAMESPACE+"insert", dto);
		} catch (Exception e) {
			logger.info("[ERROR] USERTODO :: insert");
			e.printStackTrace();
		}
		
		return res;
	}
	
	@Override
	public int insertExample(int user_no) {
		logger.info(">> [USERTODO] insert Example");
		int res = 0;
		
		try {
			res = sqlSession.insert(NAMESPACE+"insertExample", user_no);
		} catch (Exception e) {
			logger.info("[ERROR] USERTODO :: insert Example");
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int update(UserTodoDto dto) {
		logger.info(">> [USERTODO] update - " + dto.getTodo_no());
		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE+"update", dto);
		} catch (Exception e) {
			logger.info("[ERROR] USERTODO :: update");
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int delete(int todo_no) {
		logger.info(">> [USERTODO] delete - " + todo_no);
		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE+"delete", todo_no);
		} catch (Exception e) {
			logger.info("[ERROR] USERTODO :: delete - " + todo_no);
			e.printStackTrace();
		}
		
		return res;
	}
	
	//weekly
	@Override
	public WeeklyDto chart(int user_no) {
		logger.info(">> [USERTODO] chart - " + user_no);
		
		WeeklyDto dto = null;
		try {
			dto = sqlSession.selectOne(NAMESPACE+"WeeklyChart", user_no);
		} catch (Exception e) {
			logger.info("[ERROR] USERTODO :: chart - " + user_no);
			e.printStackTrace();
		}
		
		return dto;
	}

}
