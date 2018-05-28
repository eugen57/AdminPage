
package src.Dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

public class BaseDal {
    protected Connection connection;
    protected Statement statement;

    public BaseDal(String url, String login, String password) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(BaseDal.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            connection = DriverManager.getConnection(url,login,password);
            statement = connection.createStatement();
        } catch (SQLException ex) {
            Logger.getLogger(BaseDal.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void closeConnection() {
        try {
            connection.close();
            statement.close();
        } catch (SQLException ex) {
            Logger.getLogger(BaseDal.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
