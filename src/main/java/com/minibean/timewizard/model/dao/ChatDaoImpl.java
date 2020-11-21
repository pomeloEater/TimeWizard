package com.minibean.timewizard.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.minibean.timewizard.model.dto.ChatDto;

@Repository
public class ChatDaoImpl implements ChatDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int chatInsert(ChatDto dto) {
		// TODO Auto-generated method stub
		int res = 0;
		try {
			res = sqlSession.insert(namespace+"insert",dto);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}


}
