package com.utilities;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.ResourceBundle;

public class DBConnection {
	
	private static DBConnection connection;
	private ResourceBundle bundle;

	/**
	 * Private Constructor for Singleton class
	 */
	private DBConnection() {
		this.bundle = bundle.getBundle("resource.config");
	}
		
	/**
	 * public static method to getInstance 
	 * @return DBConnection Object
	 */
	public static DBConnection getInstance() {
		if(connection == null) {
			return new DBConnection();
		}
		return connection;
	}
	

	/**
	 * Returns SQL connection
	 * @return java.sql.Connection
	 */
    public Connection getDatabaseConnection(String environmentPrefix) {
        try {
        	Class.forName("oracle.jdbc.OracleDriver");  
        	Connection con=DriverManager.getConnection(bundle.getString(environmentPrefix+"_"+"connection_string"),bundle.getString(environmentPrefix+"_"+"db_user") ,bundle.getString(environmentPrefix+"_"+"db_password"));
        	return con;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("Exception occurred while connecting to DB");
		}
		return null;
    }

	public ResourceBundle getBundle() {
		return bundle;
	}

	public void setBundle(ResourceBundle bundle) {
		this.bundle = bundle;
	}

	
}
