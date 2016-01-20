

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
 * Servlet implementation class addFeedback
 */
public class addFeedback extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addFeedback() {
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
        	Statement myst1 = myconn.createStatement();
        	//3. Execute sql query;
        	String feedback_text = request.getParameter("feedback_text");
        	int messageid=0;
        	int fid=0;
        	
        	ResultSet rs = myst.executeQuery("Select userid from user where type_id=(Select type_id from usertype where type_description='admin')");
        		while(rs.next())
        		{
        			ResultSet rs1 = myst1.executeQuery("Select max(messageid) as mid from notification where userid='"+rs.getString("userid")+"'");
        			while(rs1.next())
        			{
        				messageid=rs1.getInt("mid");
        			}
        			PreparedStatement ps=myconn.prepareStatement("Insert into notification values(?,?,?)");           		
            		ps.setString(1, rs.getString("userid"));
            		ps.setInt(2, messageid+1);
            		ps.setString(3, "Feedback received: "+feedback_text);
            		ps.executeUpdate();
        			
            		rs1 = myst1.executeQuery("Select max(fid) as fid from feedback");
        			while(rs1.next())
        			{
        				fid=rs1.getInt("fid");
        			}
            		ps=myconn.prepareStatement("Insert into feedback values(?,?)");           		
            		ps.setInt(1, fid+1);
            		ps.setString(2, feedback_text);
            		ps.executeUpdate();
            		
            		out.println("<html>");
                	out.println("<head>");
                	out.println("<link rel='stylesheet' href='Style.css'/><title>Feedback Received!</title>");
                	out.println("</head>");
                	out.println("<body><center>");
                	out.println("<br>Feedback has been received!!");
                	out.println("<br><a href='professorhome.jsp'> Click here </a>to go back.");
                	out.println("<br></center></body>");
                	out.println("</html>");
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
