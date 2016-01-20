

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
 * Servlet implementation class removeCourseStudent
 */
public class removeCourseStudent extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public removeCourseStudent() {
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
        	Connection myconn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gradiance", "root", "");
        	//2. Create a statement
        	Statement myst = myconn.createStatement();
        	//3. Execute sql query;
        	String remcoursetoken = request.getParameter("remcoursetoken");
        	ResultSet rs = myst.executeQuery("Select * from course where token='"+remcoursetoken+"'");
            HttpSession session = request.getSession();
            PreparedStatement ps = null;
        	if(rs.first())
        	{
        		rs = myst.executeQuery("SELECT * FROM enrollment where userid='"+(String)session.getAttribute("userid")+"' and token='"+remcoursetoken+"'");
        		if (rs.first()==true) {
        			//removing course
        			myst.executeUpdate("DELETE FROM enrollment WHERE userid='"+(String)session.getAttribute("userid")+"' and token='"+remcoursetoken+"'");
                	rs = myst.executeQuery("Select numenrolled from course where token='"+remcoursetoken+"'");
                	if (rs.first()) {
                		int numenrolled = (rs.getInt("numenrolled")-1);
                		ps=myconn.prepareStatement("update course set numenrolled="+ numenrolled +" where token= '"+remcoursetoken+"'");
        				ps.executeUpdate();
                	}
            		myconn.close();
            		response.sendRedirect("studenthome.jsp");	
        		} else {
        			//Cannot remove course
                	out.println("<html>");
                	out.println("<head><link rel='stylesheet' type='text/css' href='Style.css' />");
                	out.println("<title>Registration Status</title>");
                	out.println("</head>");
                	out.println("<body><center>");
                	out.println("You are not registered in the course.");
                	out.println("<a href='studenthome.jsp' >Back</a>");
                	out.println("</center></body>");
                	out.println("</html>");
        		}
        	} else {
    			//Course not valid
            	out.println("<html>");
            	out.println("<head><link rel='stylesheet' type='text/css' href='Style.css' />");
            	out.println("<title>Registration Status</title>");
            	out.println("</head>");
            	out.println("<body><center>");
            	out.println("Please enter a valid course token!!");
            	out.println("<a href='studenthome.jsp' > Back</a>");
            	out.println("</center></body>");
            	out.println("</html>");
        	}
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
