package com.minibean.timewizard.utils.calendar;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;

import com.minibean.timewizard.model.dto.CalendarDto;

public class CalendarUtils {

	private String toDates;

	public String getToDates() {
		return toDates;
	}
	
	public void setToDates(String mdate) {
		// 넣어준 mdate=> yyyy-mm-dd hh:mm:00;으로 만들 거임 =>time stamp가 이러한 문자열 형태로 받기때문에 이렇게
		// 만든 것임.
		// 나노 세컨트 형식으로 날짜를 가지고 논다고함

		/*
		 * String m = mdate.substring(0, 4) + "-" + mdate.substring(4, 6) + "-" +
		 * mdate.substring(6, 8) + " " + mdate.substring(8, 10) + ":" +
		 * mdate.substring(10) + ":00";
		 */
		
		String m = mdate.substring(0, 4) + "-" + mdate.substring(4, 6) + "-" + mdate.substring(6, 8) + " ";

		//api 사이트 https://docs.oracle.com/javase/8/docs/api/에서 확인해보자 기능들..
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분");
		Timestamp tm = Timestamp.valueOf(m);
		toDates = sdf.format(tm); 
						//ㄴ>날짜를 받아서 문자형식으로 바꿔줌 => yyyy=> year

//		toDates = m;
	}

	public static String isTwo(String msg) {
		// String msg가 만약 한 자리수라면 2자리로 바꿔서 리턴해주자
		return (msg.length() < 2) ? "0" + msg : msg;

	}
	
	//달력의 토요일 , 일요일, 평일 색상 설정
	
	public static String fontColor(int date, int dayOfweek) {
		String color="";
		
		if((dayOfweek-1 +date)%7==0) {
			color="blue";
		}else if((dayOfweek-1 +date)%7==1) {
			color="red";
		}else {
			color ="black";
		}
		
		return color;
	}
	
	
	public static String getViewTitle(int i , List<CalendarDto>clist) {
		
		String date = isTwo(i+"");
		String res = "";		
		
		for(CalendarDto dto : clist ) {
						//내가 넣어준 일정과 Mdate서브스트링이 같다면
			if(dto.getCal_mdate().substring(6,8).equals(date)) {
								//yyyyMMddHHmm => 6~8 이면 date에 해당
				res+="<p>"
					+ ((dto.getCal_title().length()>6)? dto.getCal_title().substring(0, 6)+"..." : dto.getCal_title())
							+"</p>";
			}
		}
		
		return res;
		
	}
	

}
