

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class register
 */public class register extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public register() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try
        {
        	//1. Get a connection
        	Class.forName("com.mysql.jdbc.Driver").newInstance();
        	Connection myconn = null;
        	try {
        		myconn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gradiance", "root", "");
        	} catch (SQLException ex){
        		out.println("SQLException : " + ex.getMessage());
        		out.println("SQLState : " + ex.getSQLState());
        		out.println("VendorError : " + ex.getErrorCode());
        	}
        	//2. Create a statement
        	ResultSet rs = null;
        	Statement myst=null;
        	try {
        		myst = myconn.createStatement();
        		//3. Execute sql query;
        		rs = myst.executeQuery("Select * from usertype");
        	} catch (SQLException ex){
        		out.println("SQLException : " + ex.getMessage());
        		out.println("SQLState : " + ex.getSQLState());
        		out.println("VendorError : " + ex.getErrorCode());
        	}
        	String usertype;
        	int type_id=3;
        	while(rs.next())
        	{
        		if(request.getParameter("usertype").equalsIgnoreCase(rs.getString("type_description")))
        		{
        			usertype = rs.getString("type_description");
        			type_id = rs.getInt("type_id");
        		}
        	}
        	rs=myst.executeQuery("select * from user where userid='"+request.getParameter("userId")+"'");
        	if (rs.next()) {
        		out.println("<html>");
        		out.println("<head><link rel='stylesheet' type='text/css' href='Style.css' />");
        		out.println("<title>Register Failed</title>");
        		out.println("</head>");
        		out.println("<body>");
        		out.println("<div class=\"container\"><div class=\"main\">User already exists. Please use a different username and sign up again.<hr/>");
        		out.println("<a href='registration.jsp' >Register here</a>");
        		out.println("</div></div></body>");
        		out.println("</html>");
        		
        	} else {
        		PreparedStatement ps=myconn.prepareStatement("insert into USER values(?,?,?,?,?,?)");
        		ps.setString(1, request.getParameter("userId"));
        		ps.setString(2, request.getParameter("passwd1"));
        		ps.setString(3, request.getParameter("email"));
        		ps.setString(4, request.getParameter("fname"));
        		ps.setString(5, request.getParameter("lname"));
        		ps.setInt(6, type_id);
        		ps.executeUpdate();
        		if(request.getParameter("usertype").equalsIgnoreCase("student"))
        		{
        			System.out.println(request.getParameter("userId"));
        			System.out.println(request.getParameter("studylevel"));
        			ps=myconn.prepareStatement("insert into student values(?,?)");
        			ps.setString(1, request.getParameter("userId"));
        			ps.setString(2, request.getParameter("studylevel"));
        		}
        		if(request.getParameter("usertype").equalsIgnoreCase("professor"))
        		{
        			System.out.println(request.getParameter("userId"));
        			ps=myconn.prepareStatement("insert into professor values(?,?)");
        			ps.setString(1, request.getParameter("userId"));
        			ps.setString(2, "default");
        		}
        		ps.executeUpdate();
        		ps.close();
        		//4. Process the result plan
        		out.println("<html>");
        		out.println("<head><link rel='stylesheet' type='text/css' href='Style.css' />");
        		out.println("<title>Register Success</title>");
        		out.println("</head>");
        		out.println("<body>");
        		out.println("Welcome  "+request.getParameter("fname").toUpperCase());
        		out.println("<h1>Thank you for signing up</h1>");
        		out.println("<a href='index.jsp' >Login here</a>");
        		out.println("</body>");
        		out.println("</html>");
        	}
        	myconn.close();
        }
        catch(SQLException ex)
        {
        	out.println("This is embarassing!! Something went wrong.");
        	out.println("Please go <a href='registration.jsp' >back</a> and try again.");
        	out.println("SQLException : " + ex.getMessage());
        	out.println("SQLState : " + ex.getSQLState());
        	out.println("VendorError : " + ex.getErrorCode());
        }
        catch(Exception e)
        {
        	System.out.println("In catch");
        	e.printStackTrace();
        }
		}
 }