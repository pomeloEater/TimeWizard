package com.minibean.timewizard.utils.file;

import java.util.Date;
import java.util.UUID;

import org.springframework.stereotype.Component;

@Component
public class FileUploadUtils {
	
	public String makeRandomName() {
		Date date = new Date();
		UUID uuid = UUID.randomUUID();
		return uuid.toString() + "-" + date.getTime();
	}

}