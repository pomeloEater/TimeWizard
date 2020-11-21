package com.minibean.timewizard.model.biz;

import java.util.List;

import com.minibean.timewizard.model.dto.FriendDto;
import com.minibean.timewizard.model.dto.UserInfoDto;

public interface FriendBiz {

	// 나와 친구인 유저들 목록
	public List<FriendDto> selectListF(int user_no);

	// 나와 친구가 아닌 유저들 목록
	public List<FriendDto> selectListN(int user_no);
	
	public int DeleteFriend(FriendDto dto);

	
	//친구추가 -> 친구 요청 -> status : send
	//insert 2번
	public int SendInsert(FriendDto dto);
	
	//친구추가-> 친구 요청 수락 -> status : accept
	//update 2번
	public int AcceptUpdate(FriendDto dto);
	
	//친구 거절 -> status : deny
	//update하고 delete한다.
	public int DenyUpAndDel(FriendDto dto);
	//public int DenyUpdate(FriendDto dto);
	//public int DenyDelete(int user_no);
	
	//친구 차단 -> status : block
	//update 2번
	public int BlockUpdate(FriendDto dto);
	
	
	//유저찾는 리스트
	public List<UserInfoDto> searchList(UserInfoDto dto);

	public List<UserInfoDto> searchListN(UserInfoDto dto);
	
}
