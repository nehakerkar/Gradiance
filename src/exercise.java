
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
 */public class exercise extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public exercise() {
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
		String userid = session.getAttribute("userid").toString();
		String ed = session.getAttribute("exerciseid").toString();
		Integer eid = Integer.valueOf(ed);
		ResultSet rs = myst.executeQuery("Select MAX(attemptnum) AS atn from submission where exerciseid='"+eid+"' and userid='"+userid+"'");
		int atn = 0;
		if (rs.first())
			atn = rs.getInt("atn");
		atn++;
		
		
		String alist = ""; int fscore = 0;
		ResultSet rs11 = myst.executeQuery("Select * from exercises where exerciseid="+eid+"");
		rs11.first();
		int ppq = rs11.getInt("points_per_question");
		int npq = rs11.getInt("negative_points");
		
		//System.out.println(ppq);
		//System.out.println(npq);
		
		ResultSet rs22 ;
		
		int finalx = Integer.parseInt(request.getParameter("finalqc")); 
		String questionlist = request.getParameter("questionlist");
		int maxscore = finalx*ppq;
		for(int x = 1; x <= finalx; x = x+1) {	
			StringBuilder sb = new StringBuilder();
			sb.append("");
			sb.append(x);
			String bs = sb.toString();
			String b = request.getParameter(bs);
			if (b!=null) {
				String qarray[] = b.split(",");
				rs22 = myst.executeQuery("Select questionid,answertype from answers where answerid='"+qarray[2]+"'");
				rs22.first();
				if(rs22.getString("answertype").equalsIgnoreCase("true"))
				{
					fscore = fscore + ppq;
				} else if (rs22.getString("answertype").equalsIgnoreCase("false"))
				{
					fscore = fscore - npq;
					Statement myst99 = myconn.createStatement();
					Statement myst100 = myconn.createStatement();
					ResultSet rs99 = myst99.executeQuery("SELECT qcount from topq WHERE qid="+rs22.getInt("questionid")+"");
					if (rs99.first()) {
						int queuecount = rs99.getInt("qcount");
						queuecount++;
						myst100.executeUpdate("UPDATE topq SET qcount="+queuecount+" WHERE qid="+rs22.getInt("questionid")+"");
					} else {
						myst100.executeUpdate("INSERT INTO topq VALUES ("+rs22.getInt("questionid")+",1)");						
					}
				}
				//System.out.println(fscore);
				b = new StringBuilder().append(b).append(" ").toString();
				alist = new StringBuilder().append(alist).append(b).toString();
				//System.out.println(alist);
			}
		}
		if (fscore==maxscore) {
			rs22=myst.executeQuery("SELECT * FROM bonus WHERE eid="+eid+"");
			if (rs22.first()) {
				int bonusmark = rs22.getInt("bpoints");
				int maxbonuscount = rs22.getInt("bcount");
				rs22 = myst.executeQuery("SELECT COUNT(DISTINCT userid) AS currbonuscount FROM submission WHERE exerciseid="+eid+" AND score >= "+maxscore+"");
				if (rs22.first()) {
					if (rs22.getInt("currbonuscount") < maxbonuscount) {
						rs22 = myst.executeQuery("SELECT DISTINCT userid FROM submission WHERE exerciseid="+eid+" AND score >= "+maxscore+"");
						int useralreadypresent = 0;
						while (rs22.next()) {
							if (rs22.getString("userid")==userid) {
								useralreadypresent = 1;
								break;
							}
						}
						if (useralreadypresent==0) {
							fscore = fscore+bonusmark;
						}
					}
				}
			}
		}
		PreparedStatement ps=myconn.prepareStatement("insert into submission values(?,?,?,?,?,?,?,?,?)");
			ps.setString(1, session.getAttribute("userid").toString());
			ps.setInt(2, eid);
			ps.setInt(3, atn);
			ps.setTimestamp(4, new java.sql.Timestamp(System.currentTimeMillis()));
			ps.setTimestamp(5, new java.sql.Timestamp(System.currentTimeMillis()));
			ps.setString(6, alist);
			ps.setInt(7, fscore);
			ps.setString(8, "complete");
			ps.setString(9, questionlist);
			ps.executeUpdate();

		ps.close();


		//4. Process the result plan
		out.println("<html>");
		out.println("<head><link rel='stylesheet' type='text/css' href='css/meeting.css' />");
		out.println("<title>Success</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("Answers successfully submitted.");
		out.println("<h1>Your score is : "+fscore+"</h1>");
		out.println("<a href='showexercises.jsp' >Back to exercises menu</a>");
		out.println("</body>");
		out.println("</html>");

		myconn.close();
		}
		catch(SQLException s)
		{
			out.println("Some problem occurred while submission.");
			out.println("<a href='exercise.jsp' >Click here to go back</a>");
			s.printStackTrace();
		}
		catch(Exception e)
		{
		System.out.println("In catch");
		e.printStackTrace();
		}
		
	}

}
