package com.minibean.timewizard.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.minibean.timewizard.model.dao.PayDao;
import com.minibean.timewizard.model.dto.PayDto;

@Service
public class PayBizImpl implements PayBiz {
	
	@Autowired
	private PayDao paydao;

	@Override
	public List<PayDto> selectList() {
		
		return paydao.selectList();
	}

	@Override
	public PayDto selectOne(int user_no) {
		
		return paydao.selectOne(user_no);
	}

	@Override
	public int updateMembership(PayDto dto) {
		
		return paydao.updateMembership(dto);
	}

	@Override
	public int updateTimelapse(PayDto dto) {
		return paydao.updateTimelapse(dto);
	}

	@Override
	public int insertPay(PayDto dto) {
		return paydao.insertPay(dto);
	}
	
	


}
