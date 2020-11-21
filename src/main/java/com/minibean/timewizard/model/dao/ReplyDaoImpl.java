package com.minibean.timewizard.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.minibean.timewizard.model.dto.ReplyDto;

@Repository
public class ReplyDaoImpl implements ReplyDao {

	Logger logger = LoggerFactory.getLogger(ReplyDaoImpl.class);

	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public List<ReplyDto> replyList(int notice_no) {
		logger.info("< Reply List > ");
		List<ReplyDto> list = new ArrayList<ReplyDto>();
		try {
			list = sqlSession.selectList(NAMESPACE + "replyList", notice_no);

		} catch (Exception e) {
			logger.info("[error : Reply List]");
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int insertReply(ReplyDto dto) {
		logger.info("< Insert Reply > ");
		int res = 0;
		try {
			res = sqlSession.insert(NAMESPACE + "insertReply", dto);
		} catch (Exception e) {
			logger.info(" [error : Insert Reply ]");
			e.printStackTrace();
		}

		return res;
	}

	@Override
	public int updateReply(ReplyDto dto) {

		logger.info("< Update Reply > ");
		int res = 0;
		try {
			res = sqlSession.update(NAMESPACE + "updateReply", dto);
		} catch (Exception e) {
			logger.info(" [error : Update Reply ]");
			e.printStackTrace();
		}

		return res;
	}

	@Override
	public int deleteReply(int reply_no) {

		logger.info("< Delete Reply > ");
		int res = 0;
		try {
			res = sqlSession.delete(NAMESPACE + "deleteReply", reply_no);
		} catch (Exception e) {
			logger.info(" [error : Delete Reply ]");
			e.printStackTrace();
		}

		return res;
	}
}
