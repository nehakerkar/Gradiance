

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
 * Servlet implementation class remTA
 */
public class remTA extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public remTA() {
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
        	String token = (String)session.getAttribute("token");
        	String TAid = request.getParameter("TAid");
        	
        	ResultSet rs = myst.executeQuery("Select userid from teaching_assistant where userid='"+TAid+"' and token='"+token+"'");
        		if(!rs.next())
        		{
        			out.println("<html>");
                	out.println("<head>");
                	out.println("<title>Remove TA Failed</title>");
                	out.println("</head>");
                	out.println("<body><center>");
                	out.println("<br>This TA doesnot exist for this course");
                	out.println("<br><a href='professorActivities.jsp'> Click here </a>to go back.");
                	out.println("<br></center></body>");
                	out.println("</html>");
        		}
        		else
        		{
            		myst.executeUpdate("delete from teaching_assistant where userid='"+TAid+"' and token='"+token+"'");    				
            		rs = myst.executeQuery("Select count(*) as c from teaching_assistant where userid='"+TAid+"'");
            		rs.first();
            		System.out.println(rs.getInt("c"));
            		if(rs.getInt("c")==0)
            		{
                		myst.executeUpdate("update user set type_id=(select type_id from usertype where type_description='Student') where userid='"+TAid+"'");
            		}
            		response.sendRedirect("professorActivities.jsp");
        		}
        		
        	//4. Process the result plan
        	myconn.close();
        }
        catch(Exception ex)
        {
        	ex.printStackTrace();
        	out.println("SQLException : " + ex.getMessage());
        }
	}

}
