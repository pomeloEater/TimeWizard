package com.minibean.timewizard.utils.login;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Scanner;
import java.util.UUID;

import org.springframework.stereotype.Component;

@Component
public class UserInfoUtils {
	
	public String makeDistinctString(String id, String email) throws NoSuchAlgorithmException {
		/*
	    MessageDigest md = MessageDigest.getInstance("SHA-256");
	    StringBuffer temp = new StringBuffer();
	    int randomNum = (int) (Math.random()*100 + 1);
	    temp.append(id.substring(0,3))
		    .append(email.split("@")[0])
		    .append(randomNum);
	    md.update(temp.toString().getBytes());
	    StringBuffer beforeResult = new StringBuffer();
	    for(byte b: md.digest()) {
	    	beforeResult.append(String.format("%02x", b));
	    }
	    System.out.println(beforeResult.length());
	    String result = beforeResult.toString();
	    System.out.println(result);
	    return result.substring(0, 8) + "-" + result.substring(8, 14) + "-" + result.substring(14, 18) + "-" + result.substring(18,24) + "-" + result.substring(24, 32);
	     */
		UUID uuid = UUID.randomUUID();
		return uuid.toString();
	}
}
