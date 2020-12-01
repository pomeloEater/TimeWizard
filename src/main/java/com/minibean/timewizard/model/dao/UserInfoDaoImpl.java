package com.minibean.timewizard.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.minibean.timewizard.model.dto.UserInfoDto;

@Repository
public class UserInfoDaoImpl implements UserInfoDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	private static final Logger logger = LoggerFactory.getLogger(UserInfoDaoImpl.class);

	@Override
	public List<UserInfoDto> selectList() {
		logger.info(">> [USERINFO] selectList");

		List<UserInfoDto> result = new ArrayList<UserInfoDto>();
		try {
			result = sqlSession.selectList(NAMESPACE + "selectList");
		} catch (Exception e) {
			logger.info("[ERROR] USERINFO :: selectList");
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public UserInfoDto selectOne(int user_no) {
		logger.info(">> [USERINFO] selectOne by user_no - " + user_no);
		UserInfoDto result = null;

		try {
			result = sqlSession.selectOne(NAMESPACE + "selectOneUserNo", user_no);
		} catch (Exception e) {
			logger.info("[ERROR] USERINFO :: selectOne by user_no");
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public UserInfoDto selectOne(String user_distinct) {
		logger.info(">> [USERINFO] selectOne by user_distinct");
		UserInfoDto result = null;

		try {
			result = sqlSession.selectOne(NAMESPACE + "selectOneUserDistinct", user_distinct);
		} catch (Exception e) {
			logger.info("[ERROR] USERINFO :: selectOne by user_distinct");
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public UserInfoDto selectOne(UserInfoDto dto) {
		UserInfoDto result = null;

		try {
			result = sqlSession.selectOne(NAMESPACE + "selectOneUserInfoDto", dto);
			logger.info(">> [USERINFO] selectOne by UserInfoDto - " + dto.getUser_no());
		} catch (Exception e) {
			logger.info("[ERROR] USERINFO :: selectOne by UserInfoDto");
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public int insert(UserInfoDto dto) {
		logger.info(">> [USERINFO] insert");
		int res = 0;

		try {
			res = sqlSession.insert(NAMESPACE + "insert", dto);
		} catch (Exception e) {
			logger.info("[ERROR] USERINFO :: insert");
			e.printStackTrace();
		}

		return res;
	}

	@Override
	public int update(UserInfoDto dto) {
		logger.info(">> [USERINFO] update : user_no - " + dto.getUser_no());
		int res = 0;

		try {
			res = sqlSession.update(NAMESPACE + "update", dto);
		} catch (Exception e) {
			logger.info("[ERROR] USERINFO :: update");
			e.printStackTrace();
		}

		return res;
	}

	@Override
	public int delete(int user_no) {
		logger.info(">> [USERINFO] user unscribe");
		int res = 0;

		try {
			res = sqlSession.update(NAMESPACE + "delete", user_no);
		} catch (Exception e) {
			logger.info("[ERROR] USERINFO :: unscribe");
			e.printStackTrace();
		}

		return res;
	}

	@Override
	public int idCheck(String id) {
		int cnt = sqlSession.selectOne(NAMESPACE + "idCheck", id);
		return cnt;
	}

	@Override
	public int updateRoleRes(UserInfoDto dto) {
		logger.info(">> [USERINFO] update : user_role - " + dto.getUser_role());
		int res = 0;

		try {
			res = sqlSession.update(NAMESPACE + "updateRoleRes", dto);
		} catch (Exception e) {
			logger.info("[ERROR] USERINFO :: updateRoleRes");
			e.printStackTrace();
		}

		return res;
	}

	@Override
	public int pwChangeRes(UserInfoDto dto) {
		logger.info(">> [USERINFO] update : user_pw - " + dto.getUser_newestpw());
		int res = 0;

		try {
			res = sqlSession.update(NAMESPACE + "pwChangeRes", dto);
		} catch (Exception e) {
			logger.info("[ERROR] USERINFO :: pwChangeRes");
			e.printStackTrace();
		}

		return res;
	}

	@Override
	public int userInfoChange(UserInfoDto dto) {
		logger.info(
				">> [USERINFO] update : user_name & user_email - " + dto.getUser_name() + " & " + dto.getUser_email());
		int res = 0;

		try {
			res = sqlSession.update(NAMESPACE + "userInfoChange", dto);
		} catch (Exception e) {
			logger.info("[ERROR] USERINFO :: userInfoChange");
			e.printStackTrace();
		}

		return res;
	}

	@Override
	public int profileChange(UserInfoDto dto) {
		logger.info(">> [USERINFO] update : user_photo - " + dto.getUser_photo());
		int res = 0;

		try {
			res = sqlSession.update(NAMESPACE + "profileChange", dto);
		} catch (Exception e) {
			logger.info("[ERROR] USERINFO :: profileChange");
			e.printStackTrace();
		}

		return res;
	}

	// 아이디 찾기
	// 이름, 이메일
	@Override
	public UserInfoDto findID(String user_email) {
		logger.info(">> [USERINFO] findID - user_email : " + user_email);
		UserInfoDto result = null;
		try {
			result = sqlSession.selectOne(NAMESPACE + "findID", user_email);
		} catch (Exception e) {
			logger.info("[ERROR] USERINFO :: findID");
			e.printStackTrace();
		}
		return result;
	}

	// 비밀번호 찾기
	// 이름,이메일,아이디
	@Override
	public UserInfoDto findPW(HashMap<String, Object> map) {
		logger.info(">> [USERINFO] findID : user_email & user_id  ");
		UserInfoDto result = null;
		try {
			result = sqlSession.selectOne(NAMESPACE + "findPW", map);
		} catch (Exception e) {
			logger.info("[ERROR] USERINFO :: findPW");
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public UserInfoDto login(UserInfoDto dto) {
		logger.info(">> [UserINFO] login : user_id & user+pw : " + dto.getUser_id() + ", " + dto.getUser_pw());
		UserInfoDto result = null;
		try {
			result = sqlSession.selectOne(NAMESPACE + "loginBcrypt", dto);
		} catch (Exception e) {
			logger.info("[ERROR] login ");
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public UserInfoDto CheckPW(UserInfoDto dto) {
		logger.info(">> [UserINFO] checkpw : user_no & user_pw : " + dto.getUser_no() + ", " + dto.getUser_pw());
		UserInfoDto result = null;
		try {
			result = sqlSession.selectOne(NAMESPACE + "checkPW", dto);
		} catch (Exception e) {
			logger.info("[ERROR] checkPw");
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int updateNewPW(int user_no) {
		logger.info(">> [UserINFO] updateNewPW : user_no  : " +user_no);
		int res = 0;
		try {
			res = sqlSession.update(NAMESPACE+"newPWchange", user_no);
		} catch (Exception e) {
			logger.info("[ERROR] updateNewPW");
			e.printStackTrace();
		}
		return res;
	}

}
