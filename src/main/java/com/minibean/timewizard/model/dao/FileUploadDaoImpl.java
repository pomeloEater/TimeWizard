package com.minibean.timewizard.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.minibean.timewizard.model.dto.FileUploadDto;

@Repository
public class FileUploadDaoImpl implements FileUploadDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	private Logger logger = LoggerFactory.getLogger(FileUploadDaoImpl.class);

	@Override
	public List<FileUploadDto> selectVideoList(int user_no) {
		logger.info(">> [FILEUPLOAD] selectVideoList - " + user_no);
		List<FileUploadDto> list = new ArrayList<FileUploadDto>();
		try {
			list = sqlSession.selectList(NAMESPACE+"selectVideoList", user_no);
		} catch (Exception e) {
			logger.info("[ERROR] FILEUPLOAD :: selectList");
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public FileUploadDto selectImageOne(int user_no) {
		logger.info(">> [FILEUPLOAD] selectImageOne - " + user_no);
		FileUploadDto dto = null;
		try {
			dto = sqlSession.selectOne(NAMESPACE+"selectImageOne", user_no);
		} catch (Exception e) {
			logger.info("[ERROR] FILEUPLOAD :: selectOne");
			e.printStackTrace();
		}
		return dto;
	}
	
	@Override
	public FileUploadDto selectOne(int file_no) {
		logger.info(">> [FILEUPLOAD] selectOne - " + file_no);
		FileUploadDto dto = null;
		try {
			dto = sqlSession.selectOne(NAMESPACE+"selectOne", file_no);
		} catch (Exception e) {
			logger.info("[ERROR] FILEUPLOAD :: selectOne");
			e.printStackTrace();
		}
		return dto;
	}
	
	@Override
	public FileUploadDto selectVideoOne(int file_no) {
		logger.info(">> [FILEUPLOAD] selectOne - " + file_no);
		FileUploadDto dto = null;
		try {
			dto = sqlSession.selectOne(NAMESPACE+"selectVideoOne", file_no);
		} catch (Exception e) {
			logger.info("[ERROR] FILEUPLOAD :: selectOne");
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public int insert(FileUploadDto dto) {
		logger.info(">> [FILEUPLOAD] insert");
		int res = 0;
		try {
			res = sqlSession.insert(NAMESPACE+"insert", dto);
		} catch (Exception e) {
			logger.info("[ERROR] FILEUPLOAD :: insert");
			e.printStackTrace();
		}
		return res;
	}

}
