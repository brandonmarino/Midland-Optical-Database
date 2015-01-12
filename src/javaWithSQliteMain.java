

import Tables.Patient;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/*
This code has hard coded values for the database name, table names and names of the columns. The code is consistent with the
following sqlite3 database schema:

sqlite> .schema
CREATE TABLE bookcodes (
code text primary key,
title text not null);

CREATE TABLE songs(
id integer primary key,
bookcode text,
page int,
title text);

Note some tables might have additional columns what that should not affect the code.

*/


public class javaWithSQliteMain {

    
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println("Midland Optical Database");
		GUI frame = null;
		

		//Connect to database
        try {
        	
        	//direct java to the sqlite-jdbc driver jar code
        	// load the sqlite-JDBC driver using the current class loader
			Class.forName("org.sqlite.JDBC");
			
			//create connection to a database in the project home directory.
			//if the database does not exist one will be created in the home directory
		    
			//Connection conn = DriverManager.getConnection("jdbc:sqlite:mytest.db");
			
			//HARD CODED DATABASE NAME:
			Connection database = DriverManager.getConnection("jdbc:sqlite:db_MidlandOptical");
		       //create a statement object which will be used to relay a
		       //sql query to the database
		     Statement stat = database.createStatement();
		   
                //Query database for initial contents for GUI

	            String sqlQueryString = "select * from patients;";
	            System.out.println("");
	            System.out.println(sqlQueryString);

	            //ArrayList<FakeBook> books = new ArrayList<FakeBook>();
				ArrayList<Patient> patients = new ArrayList<Patient>();

		        ResultSet rs = stat.executeQuery(sqlQueryString);
				while (rs.next()) {
					//System.out.print("id: " + rs.getString("px_id"));
		            //System.out.println( " Name: " + rs.getString("first_name") + " " + rs.getString("last_name"));
					Patient patient = new Patient(rs.getInt("px_id"), rs.getString("first_name"), rs.getString("last_name"), rs.getString("st_address"),rs.getString("city"),rs.getString("province"),rs.getString("primary_phoneNo") );
					patients.add(patient);
				}
		        rs.close(); //close the query result table
		        

		        //Create GUI with knowledge of database and initial query content
		        frame =  new GUI("Midland Optical", database, stat, patients); //create GUI frame with knowledge of the database
		        
		        //Leave it to GUI to close database
		        //conn.close(); //close connection to database			
												
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        

        //make GUI visible
		frame.setVisible(true);




	}

}
