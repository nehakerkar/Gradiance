

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
 * Servlet implementation class editHW
 */
public class editHW extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public editHW() {
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

		String exerciseid = request.getParameter("exerciseid");
		String questionid[] = request.getParameterValues("qid");
		String questionid1[] = request.getParameterValues("qid1");
		try
		{
			Class.forName("com.mysql.jdbc.Driver").newInstance();
        	Connection myconn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gradiance", "root", "");
        	//2. Create a statement
        	Statement myst = myconn.createStatement();
        	int l=0;
        	if(questionid==null&&questionid1==null)
        		response.sendRedirect("professorActivities.jsp");
        	else
        	{
        			String del_query = "delete from exercises_questions where exerciseid='"+exerciseid+"'";
        			myst.executeUpdate(del_query);
        		if(questionid!=null)
        		{
        		for (int i=0 ;i<questionid.length; i++)
            	{
        			PreparedStatement ps=myconn.prepareStatement("Insert into exercises_questions values(?,?)");
        			ps.setInt(1,Integer.parseInt(exerciseid));
        			ps.setInt(2,Integer.parseInt(questionid[i]));
        			ps.executeUpdate();	
        		}
        		l = l+questionid.length;
        		}
        		
        		if(questionid1!=null)
        		{
        		for (int i=0 ;i<questionid1.length; i++)
            	{
        			PreparedStatement ps=myconn.prepareStatement("Insert into exercises_questions values(?,?)");
        			ps.setInt(1,Integer.parseInt(exerciseid));
        			ps.setInt(2,Integer.parseInt(questionid1[i]));
        			ps.executeUpdate();	
        		}
        		l=l+questionid1.length;
        		}
        		myst.executeUpdate("update exercises set number_qt="+l);        		
        	}
        	out.println("<html>");
        	out.println("<head>");
        	out.println("<link rel='stylesheet' href='Style.css'/><title>Exercise Modified!</title>");
        	out.println("</head>");
        	out.println("<body><center>");
        	out.println("<br>Exercise modified successfully");
        	out.println("<br><a href='professorActivities.jsp'> Click here </a>to go back.");
        	out.println("<br></center></body>");
        	out.println("</html>");
        	
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}

}
