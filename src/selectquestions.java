

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class selectquestions
 */
public class selectquestions extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public selectquestions() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

		HttpSession session = request.getSession();
		String userid = (String)session.getAttribute("userid");
		String token = (String)session.getAttribute("token");
		try
		{
			Class.forName("com.mysql.jdbc.Driver").newInstance();
        	Connection myconn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gradiance", "root", "");
        	//2. Create a statement
        	Statement myst = myconn.createStatement();
        	ResultSet rs;
			if(request.getParameter("valueconfirm").equalsIgnoreCase("delete"))
			{
				String radioexercise = request.getParameter("radioexercise");
				myst.executeUpdate("delete from exercises where exerciseid="+radioexercise);
				myst.executeUpdate("delete from exercises_questions where exerciseid="+radioexercise);
				myst.executeUpdate("delete from bonus where eid="+radioexercise);
				out.println("<html>");
	        	out.println("<head>");
	        	out.println("<link rel='stylesheet' href='Style.css'/><title>Exercise Deleted!</title>");
	        	out.println("</head>");
	        	out.println("<body><center>");
	        	out.println("<br>Exercise has been deleted!!");
	        	out.println("<br><a href='professorActivities.jsp'> Click here </a>to go back.");
	        	out.println("<br></center></body>");
	        	out.println("</html>");
			}
			else if (request.getParameter("valueconfirm").equalsIgnoreCase("view"))
			{
				response.sendRedirect("viewhw.jsp?exerciseid='"+request.getParameter("radioexercise")+"'");
			}
			else
			{
		int exerciseid = 54001;
		Date estartdate = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("estartdate"));
		Date eenddate = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("eenddate"));
		System.out.println(estartdate+" "+eenddate);
		int max_retry_count = Integer.parseInt(request.getParameter("max_retry_count"));
		int start_exer_diff_level = Integer.parseInt(request.getParameter("start_exer_diff_level"));
		int end_exer_diff_level = Integer.parseInt(request.getParameter("end_exer_diff_level"));
		int random_seed = 0;
		int points_per_question = Integer.parseInt(request.getParameter("points_per_question"));
		int negative_points = Integer.parseInt(request.getParameter("negative_points"));
		int scoretypeid = Integer.parseInt(request.getParameter("scoretype"));
		String questionid[] = request.getParameterValues("qid");
		String topicid = request.getParameter("topics");
		int number_qt = questionid.length;
		String bonusflag[]  = request.getParameterValues("bonuscheck");
		
			rs = myst.executeQuery("Select max(exerciseid) as exerciseid from exercises");
        	while(rs.next())
        	{
        		exerciseid = rs.getInt("exerciseid") + 1;
        	}
        	PreparedStatement ps=myconn.prepareStatement("Insert into exercises values(?,?,?,?,?,?,?,?,?,?,?,?,?)");           		
    		ps.setInt(1, Integer.parseInt(topicid));
    		ps.setInt(2, exerciseid);
    		ps.setString(3, token);
    		ps.setString(4, userid);
    		System.out.println(new java.sql.Date(estartdate.getTime())+" "+new java.sql.Date(eenddate.getTime()));
    		ps.setDate(5, new java.sql.Date(estartdate.getTime()));
    		ps.setDate(6, new java.sql.Date(eenddate.getTime()));
    		ps.setInt(7, max_retry_count);
			ps.setString(8, new String(""+start_exer_diff_level+"-"+end_exer_diff_level));
    		ps.setInt(9, random_seed);
    		ps.setInt(10, points_per_question);
    		ps.setInt(11, negative_points);
    		ps.setInt(12, scoretypeid);
    		ps.setInt(13, number_qt);
    		ps.executeUpdate();
        	
    		ps=myconn.prepareStatement("Insert into exercises_questions values(?,?)");
    		for (int i=0 ;i<questionid.length; i++)
    		{
    			ps.setInt(1,exerciseid);
    			ps.setInt(2,Integer.parseInt(questionid[i]));
    			ps.executeUpdate();	
    		}
    		
    		if(bonusflag!=null)
    		{
    			int bcount = Integer.parseInt(request.getParameter("bcount"));
    			int bpoint = Integer.parseInt(request.getParameter("bpoint"));
    		ps=myconn.prepareStatement("Insert into bonus values(?,?,?)");
    		ps.setInt(1,exerciseid);
    		ps.setInt(2,bcount);
    		ps.setInt(3,bpoint);
    		ps.executeUpdate();
    		}
    		
    		out.println("<html>");
        	out.println("<head>");
        	out.println("<link rel='stylesheet' href='Style.css'/><title>Exercise Added!</title>");
        	out.println("</head>");
        	out.println("<body><center>");
        	out.println("<br>Exercise has been added!!");
        	out.println("<br><a href='professorActivities.jsp'> Click here </a>to go back.");
        	out.println("<br></center></body>");
        	out.println("</html>"); 
    		//response.sendRedirect("professorhome.jsp");
			}//else ends
		}//try ends
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=UTF-8");
		HttpSession session = request.getSession();
		String token = (String)session.getAttribute("token");
		String topicid = request.getParameter("topics");
		String start_exer_diff_level = request.getParameter("start_exer_diff_level");
		String end_exer_diff_level = request.getParameter("end_exer_diff_level");
		String qt="";
		String	query = "Select questionid,questiontext from questions where topicid='"+topicid+"' and diff_level_id>='"+start_exer_diff_level+"' and diff_level_id<='"+end_exer_diff_level+"' group by questionid";		
		try
		{
			Class.forName("com.mysql.jdbc.Driver").newInstance();
        	Connection myconn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gradiance", "root", "");
        	//2. Create a statement
        	Statement myst = myconn.createStatement();
        	ResultSet rs = myst.executeQuery(query);
        	while(rs.next())
        	{
        		int qid = rs.getInt("questionid");
        		String qtext = rs.getString("questiontext");
        		qt = qt+ "<tr><td align='center'><input type='checkbox' name='qid' value='"+qid+"'></td><td align='center'>"+qtext+"</td></tr>";
        	}
        	response.getWriter().write(qt);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
}
