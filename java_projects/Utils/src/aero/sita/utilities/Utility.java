package aero.sita.utilities;

import java.util.Base64;

public class Utility {

	public static String encodeBase64(String inputStr) {
		return Base64.getEncoder().encodeToString(inputStr.getBytes());
	}
}
