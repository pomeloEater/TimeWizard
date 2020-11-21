package com.minibean.timewizard.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.minibean.timewizard.model.dao.FileUploadDao;
import com.minibean.timewizard.model.dto.FileUploadDto;

@Service
public class FileUploadBizImpl implements FileUploadBiz {

	@Autowired
	private FileUploadDao fileUploadDao;
	
	@Override
	public List<FileUploadDto> selectVideoList(int user_no) {
		return fileUploadDao.selectVideoList(user_no);
	}

	@Override
	public FileUploadDto selectImageOne(int user_no) {
		return fileUploadDao.selectImageOne(user_no);
	}
	
	@Override
	public FileUploadDto selectVideoOne(int file_no) {
		return fileUploadDao.selectVideoOne(file_no);
	}
	
	@Override
	public FileUploadDto selectOne(int file_no) {
		return fileUploadDao.selectOne(file_no);
	}

	@Override
	public int insert(FileUploadDto dto) {
		return fileUploadDao.insert(dto);
	}

}
