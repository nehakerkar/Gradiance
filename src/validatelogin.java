

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class validatelogin
 */
public class validatelogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public validatelogin() {
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
        HttpSession session = request.getSession();
        try
        {
        	//1. Get a connection
        	Class.forName("com.mysql.jdbc.Driver").newInstance();
        	Connection myconn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gradiance", "root", "");
        	//2. Create a statement
        	Statement myst = myconn.createStatement();
        	//3. Execute sql query;
        	String userid = request.getParameter("userid");
        	String password = request.getParameter("password");
        	ResultSet rs = myst.executeQuery("Select * from user where userid='"+userid+"'");
        	if(rs.next())
        	{
        		String user_password=rs.getString("password");
        		String user_fname=rs.getString("firstname");
        		int type_id=rs.getInt("type_id");
        		rs = myst.executeQuery("Select type_description from usertype where type_id='"+type_id+"'");
        		rs.next();
        		if(user_password.equalsIgnoreCase(password))
        		{
        			String usertype=rs.getString("type_description");
        			session.setAttribute("userid", userid);
        			session.setAttribute("firstname", user_fname);
        			session.setAttribute("type_description", usertype);
        			if (usertype.equalsIgnoreCase("student"))
        				response.sendRedirect("studenthome.jsp");
        			else if (usertype.equalsIgnoreCase("ta"))
        				response.sendRedirect("tahome.jsp");
        			else if (usertype.equalsIgnoreCase("professor"))
        				response.sendRedirect("professorhome.jsp");	
        			else if (usertype.equalsIgnoreCase("admin"))
        				response.sendRedirect("adminhome.jsp");	
        		}
        	}
        	out.println("<html>");
        	out.println("<head><link rel='stylesheet' type='text/css' href='Style.css' />");
        	out.println("<title>Register Failed</title>");
        	out.println("</head>");
        	out.println("<body><center>");
        	out.println("Incorrect userid or password!!");
        	out.println("<a href='index.jsp' >Login here again</a>");
        	out.println("</center></body>");
        	out.println("</html>");
        	//4. Process the result plan
        	myconn.close();
        }
        catch(Exception ex)
        {
        	System.out.println("In catch");
        	ex.printStackTrace();
        	out.println("SQLException : " + ex.getMessage());
        }
	}
}
