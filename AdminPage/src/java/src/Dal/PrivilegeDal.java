
package src.Dal;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import src.Model.Privilege;

public class PrivilegeDal extends BaseDal{
    
    public PrivilegeDal(String url, String login, String password) {
        super(url, login, password);
    }
    
    public List<Privilege> selectAll() {
        List<Privilege> privileges = new ArrayList<>();
        try {
            ResultSet set = statement.executeQuery("SELECT * FROM privileges");
            while(set.next()) {
                Privilege privilege = new Privilege(set.getInt("id"),
                                                    set.getString("name"),
                                                    set.getString("description"));
                privileges.add(privilege);
            }
            return privileges;
        } catch (SQLException ex) {
            Logger.getLogger(PrivilegeDal.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public Privilege getPrivilegeById(int id) {
        try {
            ResultSet set = statement.executeQuery("SELECT * FROM privileges WHERE id="+id);
            if(set.next()) {
                Privilege privilege = new Privilege(set.getInt("id"),
                                                    set.getString("name"),
                                                    set.getString("description"));
                return privilege;
            } else {
                return null;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDal.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    
    public List<String> getColumnNames() {
        List<String> columnNames = new ArrayList<>();
        try {
            ResultSet set = statement.executeQuery("SELECT * FROM privileges");
            for(int i=1; i<=set.getMetaData().getColumnCount();i++) {
                columnNames.add(set.getMetaData().getColumnName(i));
            }
            return columnNames;
        } catch (SQLException ex) {
            Logger.getLogger(PrivilegeDal.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public void deletePrivilegeById(int userId,int privilegeId) {
        try {
            statement.execute("DELETE FROM userPrivileges WHERE userId="+userId+" AND privilegeId="+privilegeId);
        } catch (SQLException ex) {
            Logger.getLogger(PrivilegeDal.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public int insertPrivilegeById(int userId,int privilegeId) {
        try {
            statement.execute("INSERT INTO userPrivileges(userId, privilegeId) VALUES("+userId+", "+privilegeId+")");
            return 1;
        } catch (SQLException ex) {
            Logger.getLogger(PrivilegeDal.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }
    
    public boolean hasPrivilegeById(int userId,int privilegeId) {
        try {
            ResultSet set = statement.executeQuery("SELECT * FROM userPrivileges WHERE userId="+userId+" AND privilegeId="+privilegeId);
            if(set.next()) return true;
            else return false;
        } catch (SQLException ex) {
            Logger.getLogger(PrivilegeDal.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
}
