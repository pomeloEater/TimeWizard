package com.minibean.timewizard.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.minibean.timewizard.model.dao.FriendDao;
import com.minibean.timewizard.model.dto.FriendDto;
import com.minibean.timewizard.model.dto.UserInfoDto;

@Service
public class FriendBizImpl implements FriendBiz {
	
	@Autowired
	private FriendDao friendDao;

	@Override
	public List<FriendDto> selectListF(int user_no) {
	
		return friendDao.selectListF(user_no);
	}

	@Override
	public List<FriendDto> selectListN(int user_no) {
		
		return friendDao.selectListN(user_no);
	}

	//친구추가 -> 친구 요청 -> status : send
	//insert 2번?
	@Override
	public int SendInsert(FriendDto dto) {
		
		return friendDao.SendInsert(dto);
	}

	//친구추가-> 친구 요청 수락 -> status : accept
	//update 2번
	@Override
	public int AcceptUpdate(FriendDto dto) {
		
		return friendDao.AcceptUpdate(dto);
	}

	
	//친구 거절 -> status : deny
	//update 2번
	//delete
	//update하고 delete하기
	@Override
	public int DenyUpAndDel(FriendDto dto) {
		
		int update = friendDao.DenyUpdate(dto);
		int delete = friendDao.DenyDelete(dto);
		
		return update+delete;
	}
	

	//친구 차단 -> status : block
	//update 2번
	@Override
	public int BlockUpdate(FriendDto dto) {
		
		return friendDao.BlockUpdate(dto);
	}

	@Override
	public int DeleteFriend(FriendDto dto) {
		// TODO Auto-generated method stub
		return friendDao.DeleteFriend(dto);
	}

	@Override
	public List<UserInfoDto> searchList(UserInfoDto dto) {
		// TODO Auto-generated method stub
		return friendDao.searchList(dto);
	}

	@Override
	public List<UserInfoDto> searchListN(UserInfoDto dto) {
		// TODO Auto-generated method stub
		return friendDao.searchListN(dto);
	}




}
