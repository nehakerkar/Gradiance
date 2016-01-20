

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
 * Servlet implementation class addNewCourse
 */
public class addNewCourse extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addNewCourse() {
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
	@SuppressWarnings("deprecation")
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
        	String token = request.getParameter("token").toUpperCase();
        	String courseid = request.getParameter("courseid");
        	String semester = request.getParameter("semester");
        	Date coursestartdate = new SimpleDateFormat("yyyy-mm-dd").parse(request.getParameter("coursestartdate"));
        	Date courseenddate = new SimpleDateFormat("yyyy-mm-dd").parse(request.getParameter("courseenddate"));

        	//String courseenddate = request.getParameter("courseenddate");
        	int maxenrolled = Integer.parseInt(request.getParameter("maxenrolled"));
        	int numenrolled = 0;
        	String courselevel = request.getParameter("courselevel");
        	ResultSet rs = myst.executeQuery("Select token from professor where userid='"+userid+"' and token='"+token+"'");
        		if(rs.next())
        		{
        			out.println("<html>");
                	out.println("<head>");
                	out.println("<title>Add Course Failed</title>");
                	out.println("</head>");
                	out.println("<body><center>");
                	out.println("<br>Course already added!!");
                	out.println("<br><a href='addNewCourse.jsp'> Click here </a>to go back.");
                	out.println("<br></center></body>");
                	out.println("</html>");
        		}
        		else
        		{
        			PreparedStatement ps=myconn.prepareStatement("insert into course values(?,?,?,?,?,?,?,?)");
            		ps.setString(1, token);
            		ps.setString(2, courseid);
            		ps.setString(3, semester);
            		ps.setDate(4,new java.sql.Date(coursestartdate.getTime()));
            		ps.setDate(5, new java.sql.Date(courseenddate.getTime()));
            		ps.setInt(6, maxenrolled);
            		ps.setInt(7, numenrolled);
            		ps.setString(8, courselevel);
            		ps.executeUpdate();
            		
        			ps=myconn.prepareStatement("insert into Professor values(?,?)");
            		ps.setString(1, userid);
            		ps.setString(2, token); 
            		ps.executeUpdate();
            		
            		ps.close();
    				response.sendRedirect("professorhome.jsp");
        		}
        		
        	//4. Process the result plan
        	myconn.close();
        }
        catch(Exception ex)
        {
        	ex.printStackTrace();
        	out.println("SQLException : " + ex.getMessage());
        }
	}// doPost() ends

}
