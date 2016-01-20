import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
public class Driver extends HttpServlet{
	public static void main(String args[])
	{
	//protected void doGet(HttpServletRequest request, HttpServletResponse response)
	//	    throws ServletException, IOException {
		        //response.setContentType("text/html;charset=UTF-8");
		       // PrintWriter out = response.getWriter();
	int i=1;
	try
	{
		//1. Get a connection
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection myconn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "");
		//2. Create a statement
		Statement myst = myconn.createStatement();
		
		//3. Execute sql query;
		ResultSet rs = myst.executeQuery("Select * from ships");
		//out.println("<html><body>");
		//4. Process the result plan
		while(rs.next())
		{
			//System.out.println("hi");
			System.out.println(rs.getString("name"));
		}
		myconn.close();
	}
	catch(Exception e)
	{
		System.out.println("In catch");
		e.printStackTrace();
	}
}
}
