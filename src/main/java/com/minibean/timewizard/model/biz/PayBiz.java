package com.minibean.timewizard.model.biz;

import java.util.List;

import com.minibean.timewizard.model.dto.PayDto;

public interface PayBiz {
	
	public List<PayDto> selectList();
	public PayDto selectOne(int user_no);
	
	public int insertPay(PayDto dto);
	
	public int updateMembership(PayDto dto);
	public int updateTimelapse(PayDto dto);
}
