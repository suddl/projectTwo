package xyz.nailro.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

//웹프로그램 작성에 필요한 기능을 제공하기 위한 클래스
public class Utility {
	//문자열(비밀번호)을 전달받아 암호화 처리하여 반환하는 정적 메소드
	public static String encrypt(String passwd) {
		String encryptPasswd="";//암호화 처리된 문자열을 저장하기 위한 변수
		try {
			//MessageDigest 객체를 반환받아 저장
			//MessageDigest.getInstance(String algorithm) : 매개변수로 전달받은 암호화 알고리즘이
			//저장된 MessageDigest 객체를 반환하는 정적메소드
			// => MessageDigest 객체 : 암호화 처리 기능을 제공하기 위한 객체
			// => 매개변수에 잘못된 암호화 알고리즘이 전달된 경우 NoSuchAlgorithmException 발생
			//단방향 암호화 알고리즘(복호화 처리 불가능) : MD5, SHA-1, SHA-256, SHA-512 등 
			//양방향 암호화 알고리즘(복호화 처리 가능) : AES-123, RSA 등 
			MessageDigest messageDigest=MessageDigest.getInstance("SHA-256");
			
			//MessageDigest.update(byte[] input) : MessageDigest 객체에 암호화 처리하기 위한 
			//문자열을 byte 배열로 전달받아 저장하기 위한 메소드
			//String.getBytes() : String 객체에 저장된 문자열을 byte 배열로 반환하는 메소드
			messageDigest.update(passwd.getBytes());
			
			//MessageDigest.digest() : MessageDigest 객체에 저장된 암호화 알고리즘을 사용하여
			//byte 배열의 요소값을 암호화 처리하여 byte 배열로 반환하는 메소드
			byte[] digest=messageDigest.digest();
			
			//암호화 처리된 원시데이타가 저장된 byte 배열을 String 객체(문자열)로 변환하여 저장
			for(int i=0;i<digest.length;i++) {
				//Integer.toHexString(int i) : 매개변수로 전달받은 정수값을 16진수의 문자열로 변환하여 반환하는 메소드
				encryptPasswd+=Integer.toHexString(digest[i] & 0xff);
			}
		} catch (NoSuchAlgorithmException e) {
			System.out.println("[에러]잘못된 암호화 알고리즘을 사용 하였습니다.");
		} 
		return encryptPasswd;
	}
	
	//문자열을 전달받아 태그 관련 문자열을 모두 제거하여 반환하는 메소드
	public static String stripTag(String source) {
		//Pattern.compile(String regex) : 매개변수로 전달받은 정규표현식이 저장된 Pattern 객체를 
		//생성하여 반환하는 정적 메소드
		Pattern htmlTag=Pattern.compile("\\<.*?\\>");

		//Pattern,matcher(CharSequence input) : 매개변수로 입력값을 전달받아 Pattern 객체에
		//저장된 정규표현식과 입력값을 저장하여 비교할 Matcher 객체를 생성하여 반환하는 메소드 //CharSequence = String의 부모
		//=>Matcher 객체 : 정규표현식과 입력값을 비교하여 입력값의 검색,변경,삭제 기능을 제공하기 위한 객체
		Matcher matcher = htmlTag.matcher(source);
		
		//Matcher.replaceALL(String replacement) : 입력값에서 정규표현식과 동일한 패턴의
		//문자열을 모두 검색하여 매개변수로 전달받은 문자열로 변경하여 반환하는 메소드
		
		
		return matcher.replaceAll("");//입력값에서 HTML 태그를 검색하여 삭제
	}
	
	//문자열을 전달받아 태그 관련 문자를 회피문자로 변경하여 반환하는 메소드
	public static String escapeTag(String source) {
		return source.replace("<", "&lt;").replace(">", "&gt;");
	}
	
	//제이쿼리로 입력값을 text를 줘서 태그를 안보이게 입력 가능

	public static String newPassword() {
	      //UUID 클래스 : 범용적으로 사용되는 식별자(고유값)를 생성하기 위한 기능을 메소드로 제공하는 클래스
	      //UUID.randomUUID() : 식별자를 생성하여 식별자가 저장된 UUID 객체를 반환하는 정적메소드 
	      // => UUID 객체에 저장된 식별자는 숫자와 영문자(소문자), 4개의 - 문자를 조합하여 36개의 
	      //문자로 구성된 문자열
	      //UUID.toString() : UUID 객체에 저장된 식벼자를 문자열(String 객체)로 반환하는 메소드
	      
	      return UUID.randomUUID().toString().replace("-", "").substring(0, 10).toUpperCase();
	   }
}


















