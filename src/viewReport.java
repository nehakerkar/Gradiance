

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class viewReport
 */
public class viewReport extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public viewReport() {
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
		String userid = request.getParameter("userid");
		String token = request.getParameter("token");

		String query="SELECT userid, exerciseid, attemptnum, score FROM submission WHERE userid='"+userid+"' and exerciseid IN (SELECT exerciseid FROM exercises WHERE token='"+token+"');";
		String qt="";
		try
		{
			Class.forName("com.mysql.jdbc.Driver").newInstance();
        	Connection myconn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gradiance", "root", "");
        	//2. Create a statement
        	Statement myst = myconn.createStatement();
        	ResultSet rs = myst.executeQuery(query);
        	while(rs.next())
        	{
        		int exerciseid = rs.getInt("exerciseid");
        		int attemptnum = rs.getInt("attemptnum");
        		int score = rs.getInt("score");
        		qt = qt+ "<tr><td align='center'>"+exerciseid+"</td><td align='center'>"+attemptnum+"</td><td align='center'>"+score+"</td></tr>";
        	}
        	response.getWriter().write("<tr><th>Exercise ID</th><th>Attempt number</th><th>Score</th></tr>"+qt);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}

}
