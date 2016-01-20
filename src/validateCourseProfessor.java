

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class validatelogin
 */
public class validateCourseProfessor extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public validateCourseProfessor() {
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
        	String userid = (String)session.getAttribute("userid");
        	String token = request.getParameter("token");
        	ResultSet rs = myst.executeQuery("Select courseid,token from course where token='"+token+"'");
        	if(!rs.next())
        	{
        		out.println("<html>");
            	out.println("<head>");
            	out.println("<title>Add Course Failed</title>");
            	out.println("</head>");
            	out.println("<body><center>");
            	out.println("<br>Course token not valid!!");
            	out.println("<br><a href='addNewCourse.jsp'> Click here </a> to add the new Course.");
            	out.println("<br><a href='professorhome.jsp'> Click here </a>to go back.");
            	out.println("</center></body>");
            	out.println("</html>");
        	}
        	else
        	{
        		String course_token = rs.getString("token");
        		rs = myst.executeQuery("Select token from professor where userid='"+userid+"' and token='"+course_token+"'");
        		if(rs.next())
        		{
        			out.println("<html>");
                	out.println("<head>");
                	out.println("<title>Add Course Failed</title>");
                	out.println("</head>");
                	out.println("<body><center>");
                	out.println("<br>Course already added!!");
                	out.println("<br><a href='professorhome.jsp'> Click here </a>to go back.");
                	out.println("<br></center></body>");
                	out.println("</html>");
        		}
        		else
        		{
        			rs = myst.executeQuery("Select courseenddate from course where token='"+course_token+"'");
        			rs.first();
        			if((new Date()).after(rs.getDate("courseenddate")))
        			{
        				out.println("<html>");
                    	out.println("<head>");
                    	out.println("<title>Add Course Failed</title>");
                    	out.println("</head>");
                    	out.println("<body><center>");
                    	out.println("<br>Course has expired!!");
                    	out.println("<br><a href='professorhome.jsp' > Click here </a>to go back.");
                    	out.println("</center></body>");
                    	out.println("</html>");
        			}
        			else{
        			PreparedStatement ps=myconn.prepareStatement("insert into Professor values(?,?)");
            		ps.setString(1, userid);
            		ps.setString(2, course_token); 
            		ps.executeUpdate();
            		ps.close();
    				response.sendRedirect("professorhome.jsp");
        			}
        		}
        		
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
