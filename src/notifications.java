

import java.io.IOException;
import java.io.PrintWriter;
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
 * Servlet implementation class notifications
 */
public class notifications extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public notifications() {
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
        String user_type = (String)session.getAttribute("type_description");
        try
        {
        	//1. Get a connection
        	Class.forName("com.mysql.jdbc.Driver").newInstance();
        	Connection myconn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gradiance", "root", "");
        	//2. Create a statement
        	Statement myst = myconn.createStatement();
        	//3. Execute sql query;
        	String userid = (String)session.getAttribute("userid");
        	String messageid[] = request.getParameterValues("notifications_checked");
        	if(messageid!=null)
        	{
        	for(int i=0; i<messageid.length; i++)
        	{
        		myst.executeUpdate("Delete from notification where userid='"+userid+"' and messageid='"+messageid[i]+"'");
        	}
        	}
        	if(user_type.equalsIgnoreCase("professor"))
            		response.sendRedirect("professorhome.jsp");
        	else
        			response.sendRedirect("adminhome.jsp");
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
