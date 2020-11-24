package com.minibean.timewizard.model.dao;

import java.util.HashMap;
import java.util.List;

import com.minibean.timewizard.model.dto.UserInfoDto;

public interface UserInfoDao {

	String NAMESPACE = "com.minibean.timewizard.userinfo.";
	
	public List<UserInfoDto> selectList();
	public UserInfoDto selectOne(int user_no); /* session용 */
	public UserInfoDto selectOne(String user_distinct); /* personal용 */
	public UserInfoDto selectOne(UserInfoDto dto); /* 기타용 */
	public int insert(UserInfoDto dto);
	public int update(UserInfoDto dto);
	public int delete(int user_no);
	public int idCheck(String id);
	public int updateRoleRes(UserInfoDto dto);
	public int pwChangeRes(UserInfoDto dto);
	public int userInfoChange(UserInfoDto dto);
	public int profileChange(UserInfoDto dto);
	//비밀번호 암호화한 후 로그인
	public UserInfoDto login(UserInfoDto dto);
	
	//아이디 찾기
	public UserInfoDto findID(String user_email);
	//비밀번호 찾기
	public UserInfoDto findPW(HashMap<String, Object> map);
	
	public UserInfoDto CheckPW(UserInfoDto dto);
}
