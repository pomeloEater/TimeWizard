package com.minibean.timewizard.model.dao;

import java.util.List;

import com.minibean.timewizard.model.dto.FileUploadDto;

public interface FileUploadDao {

	String NAMESPACE="com.minibean.timewizard.fileupload.";
	
	public List<FileUploadDto> selectVideoList(int user_no);
	public FileUploadDto selectImageOne(int user_no);
	public FileUploadDto selectVideoOne(int file_no);
	public FileUploadDto selectOne(int file_no);
	public int insert(FileUploadDto dto);
	
}
