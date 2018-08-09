package com.utilities;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;

public class GenerateCustomizationPropertyFile {
	private ResourceBundle bundle;
	
	/**
	 * Constructor
	 */
	public GenerateCustomizationPropertyFile() {
		// TODO Auto-generated constructor stub
		this.bundle = ResourceBundle.getBundle("resource.config");
	}
	
	/**
	 * Receive args as DEV,SIT,QA,PROD
	 * @param args
	 * @throws SQLException
	 */
	public static void main(String[] args) throws SQLException {
		new GenerateCustomizationPropertyFile().generateFile(args[0]);
	}
	
	/**
	 * Fetch data from DB and Write File 
	 * @param env
	 */
	private void generateFile(String env) {
		String query = bundle.getString("query")+env+"'";
		List<DeploymentConfigBean> list = new GenerateCustomizationPropertyFile().fetchData(query, env);
		StringBuilder sb = new StringBuilder();
		for(DeploymentConfigBean d:list) {
			sb.append(d.getKey()+"="+d.getValue());
			sb.append("\n");
		}
		writePropertyFile(sb.toString(), env);
	}
	
	/**
	 * Writes file
	 * @param data
	 */
	private void writePropertyFile(String data, String environmentPrefix) {
		
		Path path = Paths.get(environmentPrefix+bundle.getString("property_file_suffix"));
		try {
			Files.write(path, data.getBytes());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("Exception while writing property file");
		}
		
	}
	/**
	 * Fetch data from DB
	 * @param query
	 * @return
	 */
	private List<DeploymentConfigBean> fetchData(String query, String environmentPrefix) {
		Connection connection = DBConnection.getInstance().getDatabaseConnection(environmentPrefix);
		List<DeploymentConfigBean> deploymentConfigBeans = new ArrayList<>();
		DeploymentConfigBean deploymentConfigBean;
		try {
			Statement stmt = connection.createStatement();
			ResultSet rst = stmt.executeQuery(query);
			while(rst.next()) {
				deploymentConfigBean = new DeploymentConfigBean();
				deploymentConfigBean.setKey(rst.getString("KEY"));
				deploymentConfigBean.setValue(rst.getString("VALUE"));
				
				deploymentConfigBeans.add(deploymentConfigBean);
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("Exception while fetching deployment details from DB");
		}
		return deploymentConfigBeans;
	}

	public ResourceBundle getBundle() {
		return bundle;
	}

	public void setBundle(ResourceBundle bundle) {
		this.bundle = bundle;
	}

}
