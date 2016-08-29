package data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnControl {
    public ConnControl() {}
    
    public Connection connect() throws ClassNotFoundException {
        Connection con = null;
        try {
            //define the connection data
            String driverName = "com.mysql.jdbc.Driver"; //NB capital 'D' here
            String dbUrl = "";
            String userName = "";
            String password = "";

            // This odd line is needed to create an instance of the JDBC Driver class and thus
            // it's static block which registers the Driver itself. The return of this method
            // isn't needed, so it isn't assigned anywhere.
            // Refer to: http://stackoverflow.com/questions/2092659/what-is-the-difference-between-class-forname-and-class-forname-newinstanc
            Class.forName(driverName);
            
            //open the connection
            con = DriverManager.getConnection(dbUrl, userName, password);
            return con;
        } catch (SQLException e) {
            return null;
        }
    }
   
   public int freeConnection(Connection c) {
        try {
            if (c != null) {
                c.close();
                return 1;
            }
        } catch (SQLException ex) {
            return 0;
        } finally { 
            return 0; 
        }
       
   }
}
