package aero.sita.utilities;

import java.net.InetAddress;
import java.net.UnknownHostException;

public class Utils {

	public static void main(String[] args) {
		System.out.println(getHostname());
	}
	
	public static String getHostname() {
		String hostname = null;
		try {
			hostname = InetAddress.getLocalHost().getHostName();
			
		} catch (UnknownHostException e) {
			// TODO Auto-generated catch block
			System.out.println("Exception occurred while fetching Hostname");
			e.printStackTrace();
		}
		return hostname;
	}
}
