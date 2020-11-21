package com.minibean.timewizard.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.WebUtils;

import com.minibean.timewizard.model.biz.FileUploadBiz;
import com.minibean.timewizard.model.biz.PayBiz;
import com.minibean.timewizard.model.biz.UserInfoBiz;
import com.minibean.timewizard.model.dto.FileUploadDto;
import com.minibean.timewizard.model.dto.PayDto;
import com.minibean.timewizard.model.dto.UserInfoDto;
import com.minibean.timewizard.utils.file.FileUploadUtils;
import com.minibean.timewizard.utils.file.FileValidator;

@Controller
public class MypageController {
	
	private Logger logger = LoggerFactory.getLogger(MypageController.class);
	
	@Autowired
	private UserInfoBiz userinfoBiz;
	@Autowired
	private FileUploadBiz fileUploadBiz;
	@Autowired
	private FileValidator fileValidator;
	@Autowired
	private FileUploadUtils fileUploadUtils;
	@Autowired
	private PayBiz payBiz;
	
	@RequestMapping("/mypage")
	public String Mypage(HttpSession session, Model model) {
		logger.info("[mypage]");
		
		UserInfoDto userinfodto = (UserInfoDto)session.getAttribute("login");
	
			PayDto dto = payBiz.selectOne(userinfodto.getUser_no());
			if(dto == null) {
				int res = payBiz.insertPay(new PayDto(userinfodto.getUser_no(),"N",0));
				if (res > 0){
					dto = payBiz.selectOne(userinfodto.getUser_no());
				}
				model.addAttribute("dto",dto);
				logger.info("mypage user_no : " + userinfodto.getUser_no());
				return "mypage";
			}
		model.addAttribute("dto",dto);
		return "mypage";
	}
	

	/* 유저 탈퇴 */
	@RequestMapping("/userdeletepage")
	public String UserDeletePage(Model model, @RequestParam int user_no) {
		logger.info("[user delete page]");

		model.addAttribute("dto", userinfoBiz.selectOne(user_no));
		
		return "userdeletepage";
	}
	
	@RequestMapping("/userdeleteres")
	public void UserDelete(HttpServletResponse response, UserInfoDto dto, HttpSession session, @RequestParam int user_no) throws Exception {
		logger.info("[user delete Reusult]");
		
		UserInfoDto user = (UserInfoDto) session.getAttribute("login");
		String user_pw = user.getUser_pw();
		String new_pw = dto.getUser_pw();
		
		//비밀번호 불일치로 탈퇴 실패
		if(!(user_pw.equals(new_pw))) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('비밀번호가 불일치해서 탈퇴에 실패했습니다.'); location.href='/timewizard/mypage'</script>");
			out.flush();

		} else {
		
			int res = userinfoBiz.delete(user_no);
			
			if(res != 0) {
				System.out.println("탈퇴 성공");
			} else {
				System.out.println("탈퇴 실패");
			}
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('탈퇴에 성공하셨습니다.'); location.href='/timewizard/login/loginform';</script>");
			out.flush();
			session.invalidate();
		}
	}
	
	
	/* 비밀번호 변경 */
	@RequestMapping("/userpwchange")
	public String UserPwChange(Model model, @RequestParam int user_no) {
		logger.info("[user password change]");

		model.addAttribute("dto", userinfoBiz.selectOne(user_no));
		
		return "userpwchange";
		
	}
	
	@RequestMapping("/userpwchangeres")
	public void UserPwChangeRes(HttpServletResponse response, HttpSession session, UserInfoDto dto, @RequestParam String user_newestpw_check, @RequestParam String user_newestpw, @RequestParam int user_no) throws Exception {
		logger.info("[user pw change Result]");
		
		UserInfoDto user = (UserInfoDto) session.getAttribute("login");
		// 기존 패스워드
		String user_pw = user.getUser_pw();
		// 사용자가 비밀번호 변경 페이지의 '기존 패스워드' 칸에 입력한 암호
		String new_pw = dto.getUser_pw();
		
		// '새 비밀번호'와 '새 비밀번호 확인'을 setter에 담아주고 get으로 가져옴
		dto.setUser_newestpw(user_newestpw);
		dto.setUser_newestpw_check(user_newestpw_check);
		String newestpw = dto.getUser_newestpw();
		String newestpwcheck = dto.getUser_newestpw_check();
		
		//기존 비밀번호 불일치로 암호 변경 실패
		if(!(user_pw.equals(new_pw))) {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('기존 패스워드가 불일치합니다. 암호 변경에 실패했습니다.'); location.href='/timewizard/mypage'</script>");
			out.flush();
			
		} else {
			
			// 새 비밀번호와 새 비밀번호 확인이 일치하면
			if (newestpw.equals(newestpwcheck)) {
			
			logger.info("user_newestpw :"+newestpw);
			logger.info("user_no :"+user_no);
			
			// 비밀번호 변경
			int res = userinfoBiz.pwChangeRes(dto);
			  
			if(res != 0) {
				
				System.out.println("암호 변경 성공");
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('비밀번호가 변경되었습니다. 변경된 비밀번호로 다시 로그인하실 수 있습니다.'); location.href='/timewizard/login/loginform';</script>");
				out.flush();
				session.invalidate();
				}
			
			} else {
				
				System.out.println("암호 변경 실패");
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('새 비밀번호와 새 비밀번호 확인이 일치하지 않습니다. 암호 변경에 실패했습니다.'); location.href='/timewizard/mypage'; </script>");
				out.flush();
			}
		}
	}
	
	@RequestMapping(value="/profileupload")
	@ResponseBody
	public void fileUpload(HttpServletResponse response ,HttpServletRequest request, Model model, @ModelAttribute("filedto") FileUploadDto fileuploadDto, BindingResult result) {
		logger.info("[user profile change]");
		
		UserInfoDto userInfoDto = new UserInfoDto();
		
		MultipartFile file = fileuploadDto.getFile();
		String fileExtension = FilenameUtils.getExtension(file.getOriginalFilename());
		String uploadedName = fileUploadUtils.makeRandomName() + "." + fileExtension;
		
		logger.info("업로디드 네임 :"+uploadedName);
		FileUploadDto fileObj = new FileUploadDto();
		fileObj.setFile_name(uploadedName);
		
		InputStream inputStream = null;
		OutputStream outputStream = null;
		
		try {
			
			inputStream = file.getInputStream();
			String uploadPath = WebUtils.getRealPath(request.getSession().getServletContext(), "/resources/image");
			logger.info("\n* 업로디드 경로 : " + uploadPath 
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
		
		// 프로필 사진을 등록하지 않은 디폴트값은 user_photo=null임. user_photo에 insert된 file이 서버에 랜덤으로 저장[FileUploadUtils 클래스 참고]된 name을 setting 해줌. 
		userInfoDto.setUser_photo(dto.getFile_name());
		userInfoDto.setUser_no(dto.getUser_no());
		logger.info("파일 이름: {} \n유저 번호: {}",dto.getFile_name(), userInfoDto.getUser_no());
		// user_photo의 값을 null에서 윗줄의 값으로 update 해줌.
		int res2 = userinfoBiz.profileChange(userInfoDto);
		 
		logger.info("[user profile change] success?: " + ((res2 == 1)?"yes":"no"));
		request.getSession().setAttribute("login", userinfoBiz.selectOne(userInfoDto.getUser_no()));
		UserInfoDto test = (UserInfoDto)request.getSession().getAttribute("login");
		logger.info(test.getUser_photo());
		PrintWriter out;
		try {
			out = response.getWriter();
			out.print("<script type='text/javascript'>location.href='/timewizard/mypage';</script>");
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	

	
	
	
	/* NAME, EMAIL 변경 */
	@RequestMapping("/userInfoChange")
	public String userInfoChange(HttpSession session ,UserInfoDto dto, @RequestParam int user_no, @RequestParam String user_name, @RequestParam String user_email) {
		logger.info("[user name or email change]");
		
		logger.info("user_no : "+user_no);
		logger.info("user_name : "+user_name);
		logger.info("user_email : "+user_email);
		
		 int res = userinfoBiz.userInfoChange(dto);
		 
		  if(res != 0) {
			  // 값 변경에 성공하는 경우 login session에 바뀐 값을 새로 넣어줌. 이 코드가 있어야 바뀐 값이 화면에 뿌려짐.
			  session.setAttribute("login", userinfoBiz.selectOne(dto.getUser_no()));
			  logger.info("이름, 이메일 변경 성공");
			  System.out.println();
		  } else {
			  System.out.println("이름, 이메일 변경 실패");
		  }
		
		return "redirect:mypage";
		
	}
	
	
	//pay
	@RequestMapping("/pay")
	public String pay(int user_no, String price, String pay_name) {
		logger.info("[pay controller]");
		
		PayDto dto = payBiz.selectOne(user_no);
		
		//멤버쉽결제
		if(pay_name.equals("membership")) {
			logger.info("pay_name01010101 : "+pay_name);
			int res = payBiz.updateMembership(new PayDto(user_no,"Y",0));
			logger.info("res : "+res);
			logger.info("price : "+price);
			logger.info("pay_name : "+pay_name);
			if(res > 0) {
				return "redirect:mypage";
			}else {
				return "mypage";
			}
			
		}else {  //timelapse결제
			logger.info("pay_name020202 : "+pay_name);
			if(price.equals("1000")) {
				logger.info("price01 : "+price);
				int res = payBiz.updateTimelapse(new PayDto(user_no, null, dto.getTimelapse()+1));
				logger.info("res : "+res);
				if(res > 0) {
					return "redirect:mypage";
				}
			}else if(price.equals("5000")) {
				logger.info("price02 : "+price);
				int res = payBiz.updateTimelapse(new PayDto(user_no, null, dto.getTimelapse()+5));
				if(res > 0) {
					return "redirect:mypage";
				}

			}else {
				logger.info("price03 : "+price);
				int res = payBiz.updateTimelapse(new PayDto(user_no, null, dto.getTimelapse()+10));
				if(res > 0) {
					return "redirect:mypage";
				}
			}
			//
			return "redirect:mypage";
		}
	
		
	}

}
