package com.minibean.timewizard.utils.file;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.minibean.timewizard.model.dto.FileUploadDto;

@Component
public class FileValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void validate(Object target, Errors errors) {
		// 주어진 객체 target의 유효성 검사
		// target - supports(Class<?> clazz)가 일반적으로 true를 반환하는 클래스
		// Errors : 데이터 바인딩 및 유효성 검사 오류에 대한 정보 저장 및 노출(store and expose)
		FileUploadDto file = (FileUploadDto) target;
		
		if (file.getFile().getSize() == 0) {
			errors.rejectValue("file", "fileNPE", "Please select a file");
		}
		// regectValue(String field, String errorCode, String defaultMessage)
		// 지정된 필드에 대한 필드 오류 및 설명 등록

	}

}
