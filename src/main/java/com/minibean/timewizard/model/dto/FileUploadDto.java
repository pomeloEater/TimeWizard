package com.minibean.timewizard.model.dto;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class FileUploadDto {

	private int file_no;
	private int user_no;
	private String file_name;
	private String file_type;
	private int file_size;
	private Date file_regdate;
	private MultipartFile file;
	
	public FileUploadDto() {}
	public FileUploadDto(MultipartFile file) {
		this.file = file;
	}
	public FileUploadDto(int file_no, int user_no, String file_name, String file_type, int file_size,
			Date file_regdate) {
		this.file_no = file_no;
		this.user_no = user_no;
		this.file_name = file_name;
		this.file_type = file_type;
		this.file_size = file_size;
		this.file_regdate = file_regdate;
	}
	public FileUploadDto(int file_no, int user_no, String file_name, String file_type, int file_size, Date file_regdate,
			MultipartFile file) {
		this.file_no = file_no;
		this.user_no = user_no;
		this.file_name = file_name;
		this.file_type = file_type;
		this.file_size = file_size;
		this.file_regdate = file_regdate;
		this.file = file;
	}
	public int getFile_no() {
		return file_no;
	}
	public void setFile_no(int file_no) {
		this.file_no = file_no;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getFile_type() {
		return file_type;
	}
	public void setFile_type(String file_type) {
		this.file_type = file_type;
	}
	public int getFile_size() {
		return file_size;
	}
	public void setFile_size(int file_size) {
		this.file_size = file_size;
	}
	public Date getFile_regdate() {
		return file_regdate;
	}
	public void setFile_regdate(Date file_regdate) {
		this.file_regdate = file_regdate;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
	
}
