

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class addTA
 */
public class addTA extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addTA() {
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
        	
        	ResultSet rs = myst.executeQuery("Select userid from student where userid='"+TAid+"' and studylevel='Grad'");
        		if(!rs.next())
        		{
        			out.println("<html>");
                	out.println("<head>");
                	out.println("<title>Add TA Failed</title>");
                	out.println("</head>");
                	out.println("<body><center>");
                	out.println("<br>Please enter valid graduate student ID.");
                	out.println("<br><a href='professorActivities.jsp'> Click here </a>to go back.");
                	out.println("<br></center></body>");
                	out.println("</html>");
        		}
        		else
        		{
        			rs = myst.executeQuery("Select * from teaching_assistant where userid='"+TAid+"' and token='"+token+"'");
        			if(rs.next())
        			{
        				out.println("<html>");
                    	out.println("<head>");
                    	out.println("<title>Add TA Failed</title>");
                    	out.println("</head>");
                    	out.println("<body><center>");
                    	out.println("<br>This TA already added for this course.");
                    	out.println("<br><a href='professorActivities.jsp'> Click here </a>to go back.");
                    	out.println("<br></center></body>");
                    	out.println("</html>");
        			}
        			else
        			{
        			PreparedStatement ps=myconn.prepareStatement("insert into teaching_assistant values(?,?)");            		
            		ps.setString(1, TAid);
            		ps.setString(2, token); 
            		ps.executeUpdate();
            		
            		myst.executeUpdate("update user set type_id=(select type_id from usertype where type_description='TA') where userid='"+TAid+"'");
            		
            		ps.close();
    				response.sendRedirect("professorActivities.jsp");
        			}
        		}
        		
        	//4. Process the result plan
        	myconn.close();
        }
        catch(Exception ex)
        {
        	ex.printStackTrace();
        	out.println("SQLException : " + ex.getMessage());
        }
	}//doPost() ends

}
