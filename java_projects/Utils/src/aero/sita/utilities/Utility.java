package aero.sita.utilities;

import java.util.Base64;

public class Utility {

	public static String encodeBase64(byte[] inputByteArr) {
		return Base64.getEncoder().encodeToString(inputByteArr);
	}
	
	public static String encodeBase64(String inputStr) {
		return Base64.getEncoder().encodeToString(inputStr.getBytes());
	}
	
	public static String byteArrToString(byte[] inputByteArr) {
		return new String(inputByteArr);
	}
	
	public static byte[] decodeBase64ToByte(String base64String) {
		return Base64.getDecoder().decode(base64String);
	}
	
	public static int getLength(final byte[] bytes) {
	       int length = bytes.length;
	        return length;
	}
}
