package aero.sita.utilities;

import java.util.Base64;

public class Utility {

	public static String encodeBase64(byte[] inputByteArr) {
		System.out.println("encodeBase64 -> "+inputByteArr);
		return Base64.getEncoder().encodeToString(inputByteArr);
	}
	
	public static String encodeBase64(String inputStr) {
		System.out.println("encodeBase64 -> "+inputStr);
		return Base64.getEncoder().encodeToString(inputStr.getBytes());
	}
	
	public static String byteArrToString(byte[] inputByteArr) {
		System.out.println("byteArrToString -> "+inputByteArr);
		return new String(inputByteArr);
	}
}
