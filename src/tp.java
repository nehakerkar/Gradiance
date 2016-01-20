import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
public class tp {
public static void main(String args[])
{

	int i=1;
	try
	{
		//1. Get a connection
		Connection myconn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "leonia", "");
		
		//2. Create a statement
		Statement myst = myconn.createStatement();
		
		//3. Execute sql query;
		ResultSet rs = myst.executeQuery("Select * from ships");
		
		//4. Process the result plan
		while(rs.next())
		{
			System.out.println(rs.getString("name"));
		}
		myconn.close();
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
}
}
