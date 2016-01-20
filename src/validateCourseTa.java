

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
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
 * Servlet implementation class validatecourse
 */
public class validateCourseTa extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public validateCourseTa() {
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
        	String coursetoken = request.getParameter("coursetoken");
        	ResultSet rs = myst.executeQuery("Select * from course where token='"+coursetoken+"'");
            HttpSession session = request.getSession();
            PreparedStatement ps = null;
    		String topiclist="";
        	if(rs.first())
        	{
        		rs = myst.executeQuery("SELECT * FROM enrollment where userid='"+(String)session.getAttribute("userid")+"' and token='"+coursetoken+"'");
        		if (rs.first()==false) {
                	rs = myst.executeQuery("Select numenrolled,maxenrolled,courseenddate from course where token='"+coursetoken+"'");
                	if (rs.first()==true) {
                		if (rs.getInt("numenrolled")<rs.getInt("maxenrolled")) {
                			if ((new Date()).before(rs.getDate("courseenddate"))) {
                	        	Statement myst1 = myconn.createStatement();
                				ResultSet rs1 = myst1.executeQuery("select courselevel from course where token = '" + coursetoken + "'");
                	        	Statement myst2 = myconn.createStatement();
                				ResultSet rs2 = myst2.executeQuery("select studylevel from student where userid = '"+ (String)session.getAttribute("userid") +"'");
                				if (rs1.first() && rs2.first()) {
                					if ((rs1.getString("courselevel")).equalsIgnoreCase((rs2.getString("studylevel")))) {
                						String currdatestring = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
                						ResultSet rs3 = myst2.executeQuery("select distinct A.topicid FROM (select topic_courselist.topicid from topic_courselist where courseid in (select courseid from course where token in (SELECT token FROM teaching_assistant where userid='"+ (String)session.getAttribute("userid") +"') AND courseenddate > '"+ currdatestring +"')) A JOIN (select topic_courselist.topicid from topic_courselist where courseid IN (select courseid from course where token='"+ coursetoken +"')) B ON B.topicid=A.topicid");
                						if (!rs3.first()) {
                							ps=myconn.prepareStatement("insert into enrollment values(?,?)");
                							ps.setString(1, (String)session.getAttribute("userid"));
                							ps.setString(2, coursetoken);
                							ps.executeUpdate();
                							int numenrolled = (rs.getInt("numenrolled")+1);
                							ps=myconn.prepareStatement("update course set numenrolled="+ numenrolled +" where token= '"+coursetoken+"'");
                							ps.executeUpdate();
                							response.sendRedirect("tahome.jsp");
                						} else {
                                			//Qualification doesnt match
                                        	out.println("<html>");
                                        	out.println("<head><link rel='stylesheet' type='text/css' href='Style.css' />");
                                        	out.println("<title>Registration Status</title>");
                                        	out.println("</head>");
                                        	out.println("<body><center>");
                                        	out.println("Professor Approval Required");
                                        	out.println("<a href='tahome.jsp' >Back</a>");
                                        	out.println("</center></body>");
                                        	out.println("</html>");
                                        	rs3 = myst2.executeQuery("SELECT token FROM teaching_assistant where userid='"+ (String)session.getAttribute("userid") +"'");                                        	
                                        	while (rs3.next()) {
                                        		String tatoken = rs3.getString("token");
                                        		Statement myst6 = myconn.createStatement();
                                        		ResultSet rs6 = myst6.executeQuery("select distinct A.topicid FROM (select topic_courselist.topicid from topic_courselist where courseid in (select courseid from course where token = '"+ tatoken +"' AND courseenddate > '"+ currdatestring +"')) A JOIN (select topic_courselist.topicid from topic_courselist where courseid IN (select courseid from course where token='"+ coursetoken +"')) B ON B.topicid=A.topicid");
                                        		topiclist="";
                                        		while (rs6.next())
                                        			topiclist=topiclist.concat(String.valueOf(rs6.getInt("topicid"))+" ");
                                        		if (topiclist.compareToIgnoreCase("")!=0) {
                                        			Statement myst5 = myconn.createStatement();
                                        			ResultSet rs5 = myst5.executeQuery("SELECT userid FROM professor where token ='"+ tatoken +"'");
                                        			if (rs5.next()) {
                                        				int nextexerid = 0;
                                        				String profid = rs5.getString("userid");
                                        				Statement myst4 = myconn.createStatement();
                                        				ResultSet rs4 = myst4.executeQuery("select MAX(messageid) AS maxmessageid from notification");
                                        				if (rs4.first()) {
                                        					nextexerid = rs4.getInt("maxmessageid");
                                        				}
                                        				nextexerid++;
                                        				String messagetext = "Hi "+profid+". Student '"+(String)session.getAttribute("userid")+"' who is a TA tried to enroll to course with clashing topics '"+topiclist+"'"; 
                                        				ps = myconn.prepareStatement("insert into notification values (?,?,?)");
                                        				ps.setString(1,profid);
                                        				ps.setInt(2,nextexerid);
                                        				ps.setString(3,messagetext);
                                        				ps.executeUpdate();
                                        			}
                                        		}
                                        	}
                                        	Statement jitstate = myconn.createStatement();
                                        	ResultSet jitrs = jitstate.executeQuery("SELECT * FROM professor WHERE token='"+coursetoken+"'");
                                        	while (jitrs.next()) {
                                				int nextexerid = 0;
                                				Statement myst4 = myconn.createStatement();
                                				ResultSet rs4 = myst4.executeQuery("select MAX(messageid) AS maxmessageid from notification");
                                				if (rs4.first()) {
                                					nextexerid = rs4.getInt("maxmessageid");
                                				}
                                				nextexerid++;
                                        		String messagetext = "Hi "+jitrs.getString("userid")+". Student '"+(String)session.getAttribute("userid")+"' who is a TA tried to enroll to course with clashing topics '"+topiclist+"'";
                                				ps = myconn.prepareStatement("insert into notification values (?,?,?)");
                                				ps.setString(1,jitrs.getString("userid"));
                                				ps.setInt(2,nextexerid);
                                				ps.setString(3,messagetext);
                                				ps.executeUpdate();
                                        	}
                						}
                					} else {
                            			//Qualification doesnt match
                                    	out.println("<html>");
                                    	out.println("<head><link rel='stylesheet' type='text/css' href='Style.css' />");
                                    	out.println("<title>Registration Status</title>");
                                    	out.println("</head>");
                                    	out.println("<body><center>");
                                    	out.println("Sorry. Course doesn't match your graduation level.");
                                    	out.println("<a href='tahome.jsp'> Back</a>");
                                    	out.println("</center></body>");
                                    	out.println("</html>");
                					}
                				}
                			} else {
                    			//Enrollment time exceeded
                            	out.println("<html>");
                            	out.println("<head><link rel='stylesheet' type='text/css' href='Style.css' />");
                            	out.println("<title>Registration Status</title>");
                            	out.println("</head>");
                            	out.println("<body><center>");
                            	out.println("Sorry. Course has expired.");
                            	out.println("<a href='tahome.jsp' >Back</a>");
                            	out.println("</center></body>");
                            	out.println("</html>");
                			}
                		} else {
                			//Enrollment limit exceeded
                        	out.println("<html>");
                        	out.println("<head><link rel='stylesheet' type='text/css' href='Style.css' />");
                        	out.println("<title>Registration Status</title>");
                        	out.println("</head>");
                        	out.println("<body><center>");
                        	out.println("Sorry. Course already has maximum allowed enrollment.");
                        	out.println("<a href='tahome.jsp' >Back</a>");
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
                    	out.println("Something is wrong. Course seems to be corrupted.!!");
                    	out.println("<a href='tahome.jsp' > Back</a>");
                    	out.println("</center></body>");
                    	out.println("</html>");
                	}
        		} else {
        			//Cannot add course
                	out.println("<html>");
                	out.println("<head><link rel='stylesheet' type='text/css' href='Style.css' />");
                	out.println("<title>Registration Status</title>");
                	out.println("</head>");
                	out.println("<body><center>");
                	out.println("You have already been registered in the course.");
                	out.println("<a href='tahome.jsp' >Back</a>");
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
            	out.println("<a href='tahome.jsp' > Back</a>");
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
        	System.out.println("SQLException : " + ex.getMessage());
        }
	}
}
