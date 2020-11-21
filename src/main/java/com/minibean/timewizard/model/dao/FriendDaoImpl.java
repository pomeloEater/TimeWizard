package com.minibean.timewizard.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.minibean.timewizard.model.dto.FriendDto;
import com.minibean.timewizard.model.dto.UserInfoDto;

@Repository
public class FriendDaoImpl implements FriendDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private static final Logger logger = LoggerFactory.getLogger(FriendDaoImpl.class);

	@Override
	public List<FriendDto> selectListF(int user_no) {
		
		List<FriendDto> list = new ArrayList<FriendDto>();
		
		try {
			list = sqlSession.selectList(NAMESPACE+"selectListF", user_no);
		} catch (Exception e) {
			logger.info("[ERROR] Friend SelectListF DaoImpl");
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public List<FriendDto> selectListN(int user_no) {
		
		List<FriendDto> list = new ArrayList<FriendDto>();
		
		try {
			list = sqlSession.selectList(NAMESPACE+"selectListN", user_no);
		} catch (Exception e) {
			logger.info("[ERROR] Friend SelectListN DaoImpl");
			e.printStackTrace();
		}
		
		return list;
	}

	//친구추가 -> 친구 요청 -> status : send
	//insert 2번
	@Override
	public int SendInsert(FriendDto dto) {
		int res = 0;
		
		try {
			res = sqlSession.insert(NAMESPACE+"insert", dto);
		} catch (Exception e) {
			logger.info("[ERROR] SendInsert DaoImpl");
			e.printStackTrace();
		}
		return res;
	}

	//친구추가-> 친구 요청 수락 -> status : accept
	//update 2번
	@Override
	public int AcceptUpdate(FriendDto dto) {
		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE+"updateAccept", dto);
		} catch (Exception e) {
			logger.info("[ERROR] AcceptUpdate DaoImpl");
			e.printStackTrace();
		}
		return res;
	}

	//친구 거절 -> status : deny
	//update하고 delete 한다.
	@Override
	public int DenyUpdate(FriendDto dto) {
		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE+"updateDeny", dto);
		} catch (Exception e) {
			logger.info("[ERROR] DenyUpdate DaoImpl");
			e.printStackTrace();
		}
		return res;
	}
	
	@Override
	public int DenyDelete(FriendDto dto) {
		int res = 0;
		
		try {
			res = sqlSession.delete(NAMESPACE+"deleteDeny", dto);
		} catch (Exception e) {
			logger.info("[ERROR] DenyDelete DaoImpl");
			e.printStackTrace();
		}
		return res;
	}


	//친구 차단 -> status : block
	//update 2번
	@Override
	public int BlockUpdate(FriendDto dto) {
		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE+"updateBlock", dto);
		} catch (Exception e) {
			logger.info("[ERRROR] BlockUpdate DaoImpl");
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int DeleteFriend(FriendDto dto) {
		// TODO Auto-generated method stub
		
		int res = 0;
		try {
			res = sqlSession.delete(NAMESPACE+"deleteFriend",dto);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public List<UserInfoDto> searchList(UserInfoDto dto) {
		// TODO Auto-generated method stub
		List<UserInfoDto> list = new ArrayList<UserInfoDto>();
		
		try {
			list = sqlSession.selectList(NAMESPACE+"searchList", dto);
		} catch (Exception e) {
			logger.info("[ERROR] Friend SearchList DaoImpl");
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public List<UserInfoDto> searchListN(UserInfoDto dto) {
		// TODO Auto-generated method stub
		List<UserInfoDto> list = new ArrayList<UserInfoDto>();

		try {
			list = sqlSession.selectList(NAMESPACE + "searchListN", dto);
		} catch (Exception e) {
			logger.info("[ERROR] Friend SearchList DaoImpl");
			e.printStackTrace();
		}

		return list;
	}

}
