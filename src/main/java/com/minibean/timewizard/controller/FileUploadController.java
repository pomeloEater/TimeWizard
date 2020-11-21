package com.minibean.timewizard.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.WebUtils;

import com.minibean.timewizard.model.biz.FileUploadBiz;
import com.minibean.timewizard.model.biz.PayBiz;
import com.minibean.timewizard.model.dto.FileUploadDto;
import com.minibean.timewizard.model.dto.PayDto;
import com.minibean.timewizard.model.dto.UserInfoDto;
import com.minibean.timewizard.utils.file.FileUploadUtils;
import com.minibean.timewizard.utils.file.FileValidator;

@RestController
@RequestMapping(value="/file")
public class FileUploadController {
	
	@Autowired
	private FileValidator fileValidator;
	@Autowired
	private FileUploadUtils fileUploadUtils;
	@Autowired
	private FileUploadBiz fileUploadBiz;
	@Autowired
	private PayBiz payBiz;
	
	private Logger logger = LoggerFactory.getLogger(FileUploadController.class);

	@PostMapping(value="/list/{user_no}")
	public List<FileUploadDto> selectVideoList(HttpSession session, @PathVariable int user_no) {
		List<FileUploadDto> list = fileUploadBiz.selectVideoList(user_no);
		logger.info(">> [CONTROLLER-FILEUPLOAD] select video list - " + user_no);
		return list;
	}
	
	@PostMapping(value="/one/{user_no}")
	public FileUploadDto selectImageOne(HttpSession session, @PathVariable int user_no) {
		FileUploadDto dto = fileUploadBiz.selectImageOne(user_no);
		logger.info(">> [CONTROLLER-FILEUPLOAD] select image one - " + user_no);
		return dto;
	}
	
	@PostMapping(value="/upload")
	public Map<String, Boolean> fileUpload(HttpServletRequest request, FileUploadDto uploadFile, BindingResult result) {
		
		logger.info(">> [CONTROLLER-FILEUPLOAD] upload");
		
		Map<String, Boolean> answer = new HashMap<String, Boolean>();
		
		fileValidator.validate(uploadFile, result);
		if (result.hasErrors()) {
			answer.put("result",false);
			return answer;
		}
		
		MultipartFile file = uploadFile.getFile();
		String fileExtension = FilenameUtils.getExtension(file.getOriginalFilename());
		String uploadedName = fileUploadUtils.makeRandomName() + "." + fileExtension;
		
		FileUploadDto fileObj = new FileUploadDto();
		fileObj.setFile_name(uploadedName);
		
		InputStream inputStream = null;
		OutputStream outputStream = null;
		
		try {
			
			inputStream = file.getInputStream();
			String uploadPath = WebUtils.getRealPath(request.getSession().getServletContext(), "/resources/image");
			logger.info("\n* uploaded file path : " + uploadPath 
					+ "\n* file original name : " + file.getOriginalFilename());
			
			File storage = new File(uploadPath);
			if (!storage.exists()) {
				storage.mkdir();
			}
			File newFile = new File(uploadPath + "/" + uploadedName);
			if (!newFile.exists()) {
				newFile.createNewFile();
			}
			outputStream = new FileOutputStream(newFile);
			
			int read = 0;
			byte[] b = new byte[(int)file.getSize()];
			
			while((read=inputStream.read(b)) != -1) {
				outputStream.write(b, 0, read);
			}
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				inputStream.close();
				outputStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		answer.put("result",true);
		
		FileUploadDto dto = new FileUploadDto();
		dto.setUser_no(((UserInfoDto)request.getSession().getAttribute("login")).getUser_no());
		dto.setFile_name(uploadedName);
		if (fileExtension.equalsIgnoreCase("jpg") || fileExtension.equalsIgnoreCase("jpeg") 
			|| fileExtension.equalsIgnoreCase("png") || fileExtension.equalsIgnoreCase("gif")) {
			dto.setFile_type("I");
		} else if (fileExtension.equalsIgnoreCase("mp4")) {
			dto.setFile_type("V");
		}
		
		int res = fileUploadBiz.insert(dto);
		logger.info(">> [CONTROLLER-FILEUPLOAD] success?: " + ((res == 1)?"yes":"no"));
		
		return answer;
	} 
	
	@RequestMapping(value="/download/{file_no}")
	public byte[] fileDownload(HttpServletRequest request, HttpServletResponse response, @PathVariable int file_no) {
//	public Map<String, Object> fileDownload(HttpServletRequest request, HttpServletResponse response, @PathVariable int file_no) {
		
		logger.info(">> [CONTROLLER-FILEUPLOAD] download");
		byte[] down = null;
		
		Map<String, Object> answer = new HashMap<String, Object>();
		
		FileUploadDto dto = fileUploadBiz.selectOne(file_no);
		
		int user_no = dto.getUser_no();
		PayDto paydto = payBiz.selectOne(user_no);
		if (paydto.getTimelapse() > 0) {
			PayDto renew = new PayDto(user_no, null, paydto.getTimelapse() - 1);
			int res = payBiz.updateTimelapse(renew);
			logger.info("[CONTROLLER-FILEUPLOAD] spend timelapse success? " + ((res > 0) ? "yes" : "no"));
		}
		String extension = FilenameUtils.getExtension(dto.getFile_name());
		String mime_front = (dto.getFile_type().equals("P"))?"image":"video";
		String mime_back = (extension.toLowerCase().equals("jpg"))?"jpeg":extension.toLowerCase();
		answer.put("mime", mime_front + "/" + mime_back);
		answer.put("extension", extension);

		
		try {
			String uploadPath = WebUtils.getRealPath(request.getSession().getServletContext(), "/resources/image");
			File file = new File(uploadPath + "/" + dto.getFile_name());
			
			down = FileCopyUtils.copyToByteArray(file);
			String filename = new String(file.getName().getBytes(), "8859_1");
			
			response.setHeader("Content-Disposition", "attachment; filename=\""+filename +"\"");
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		answer.put("bytes", down);

		
		
		return down;
//		return answer;
	}
	
}
