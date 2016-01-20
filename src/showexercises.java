
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
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class register
 */public class showexercises extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public showexercises() {
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
    		System.out.println("Please work");
			HttpSession session = request.getSession();
			int exerciseid = Integer.parseInt(request.getParameter("eid"));
			session.setAttribute("exerciseid", request.getParameter("eid"));
			String userid = session.getAttribute("userid").toString();
			System.out.println(request.getParameter("eid"));
        	Class.forName("com.mysql.jdbc.Driver").newInstance();
        	Connection myconn = null;
        	try {
        		myconn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gradiance", "root", "");
        		System.out.println("Please work");
        		ResultSet rs = null;
        		Statement myst = null;
        		myst = myconn.createStatement();
        		int maxretry=0, actualmax=0;
        		rs = myst.executeQuery("SELECT * FROM exercises WHERE exerciseid="+exerciseid+"");
        		if (rs.first()) {
            		System.out.println("1");
        			maxretry = rs.getInt("max_retry_count");
        		}
        		System.out.println("SELECT MAX(attemptnum) AS maxattempt FROM submission WHERE exerciseid="+exerciseid+" AND userid='"+userid+"'");
        		rs = myst.executeQuery("SELECT MAX(attemptnum) AS maxattempt FROM submission WHERE exerciseid="+exerciseid+" AND userid='"+userid+"'");
        		if (rs.first()) {
            		System.out.println("2");
        			actualmax = rs.getInt("maxattempt");
        		}
        		System.out.println("Checking "+actualmax+" against "+maxretry);
        		if ((actualmax>=maxretry)&&(maxretry!=0)) {
        			out.println("<html>");
        			out.println("<head><link rel='stylesheet' type='text/css' href='style.css' />");
        			out.println("<title>Max Retries Exceeded</title>");
        			out.println("</head>");
        			out.println("<body><center>");
        			out.println("<h2>Maximum number of retries exceeded.</h2>");
        			out.println("<br><a href='showexercises.jsp' >Back to exercises menu</a>");
        			out.println("</center></body>");
        			out.println("</html>");
        		} else {
        			response.sendRedirect("exercise.jsp");
        		}
        	} catch (SQLException ex){
        		out.println("SQLException : " + ex.getMessage());
        		out.println("SQLState : " + ex.getSQLState());
        		out.println("VendorError : " + ex.getErrorCode());
        	}
		}
        catch(Exception e)
        {
        	System.out.println("In catch");
        	e.printStackTrace();
        }

	}

}
