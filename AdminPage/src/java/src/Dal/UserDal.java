
package src.Dal;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import src.Model.Privilege;
import src.Model.User;

public class UserDal extends BaseDal{
    
    protected PrivilegeDal privilegeDal;
    
    public UserDal(String url, String login, String password) {
        super(url, login, password);
        privilegeDal = new PrivilegeDal(url, login, password);
    }
    
    public List<User> selectAll() {
        List<User> clients = new ArrayList<>();
        try {
            ResultSet resultSet = statement.executeQuery("SELECT * FROM users");
            while(resultSet.next()) {
                User user = new User(resultSet.getInt("id"),
                                     resultSet.getString("firstName"),
                                     resultSet.getString("lastName"),
                                     resultSet.getString("email"),
                                     resultSet.getString("phone"),
                                     resultSet.getString("password"));
                clients.add(user);
            }
            return clients;
        } catch (SQLException ex) {
            Logger.getLogger(UserDal.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public User selectAllPrivilegesForUser (int id) {
        User user = null;
        try {
            ResultSet resultSet = statement.executeQuery("SELECT * FROM users WHERE id="+id);
            if(resultSet.next()) {
               user = new User(resultSet.getInt("id"),
                                     resultSet.getString("firstName"),
                                     resultSet.getString("lastName"),
                                     resultSet.getString("email"),
                                     resultSet.getString("phone"),
                                     resultSet.getString("password"));
            }
            ResultSet userprifSet = statement.executeQuery("SELECT * FROM userprivileges Where userid="+id);
            while(userprifSet.next())
                    {
                        int privilegeId = userprifSet.getInt("privilegeId");
                        Privilege privilege = privilegeDal.getPrivilegeById(privilegeId);
                        user.getPrivileges().add(privilege);
                    }
            
            return user;
        } catch (SQLException ex) {
            Logger.getLogger(UserDal.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public List<User> selectAllUsersPrivileges() {
        List<User> users = new ArrayList<>();
        try {
            ResultSet resultSet = statement.executeQuery("SELECT * FROM users");
            while(resultSet.next()) {
                User user = new User(resultSet.getInt("id"),
                                     resultSet.getString("firstName"),
                                     resultSet.getString("lastName"),
                                     resultSet.getString("email"),
                                     resultSet.getString("phone"),
                                     resultSet.getString("password"));
                users.add(user);
            }
                for(User user: users)
                {
                    ResultSet userprifSet = statement.executeQuery("SELECT * FROM userprivileges Where userid="+user.getId());

                    while(userprifSet.next())
                    {
                        int id=userprifSet.getInt("privilegeId");
                        Privilege privilege= privilegeDal.getPrivilegeById(id);
                        user.getPrivileges().add(privilege);
                    }
                }
            return users;
        } catch (SQLException ex) {
            Logger.getLogger(UserDal.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public List<String> getColumnNames() {
        List<String> columnNames = new ArrayList<>();
        try {
            ResultSet set = statement.executeQuery("SELECT * FROM users");
            for (int i = 1; i <= set.getMetaData().getColumnCount(); i++) {
                columnNames.add(set.getMetaData().getColumnName(i));
            }
            return columnNames;
        } catch (SQLException ex) {
            Logger.getLogger(UserDal.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public boolean isUserExist(User user) {
        try {
            ResultSet set = statement.executeQuery("SELECT * FROM users WHERE email='"+user.getEmail()+"' AND password='"+user.getPassword()+"'");
            return set.next();
        } catch (SQLException ex) {
            Logger.getLogger(UserDal.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public List<User> selectIdAndNames() {
        List<User> users = new ArrayList<>();
        try {
            ResultSet set = statement.executeQuery("SELECT id,firstName,lastName FROM users");
            while(set.next()) {
                User user = new User(set.getInt("id"),
                                     set.getString("firstName"),
                                     set.getString("lastName"),
                                     null,
                                     null,
                                     null);
            users.add(user);
            }
            return users;
        } catch (SQLException ex) {
            Logger.getLogger(UserDal.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public boolean update(User user, int id) {
        try {
            statement.execute("UPDATE users SET "
                    + "firstName='"+user.getFirstName()+"', lastName='"+user.getLastName()
                    +"', email='"+user.getEmail()+"', phone='"+user.getPhone()
                    +"', password='"+user.getPassword()+"' WHERE id="+id);
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(UserDal.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public void insert(User user) {
        try {
            statement.execute("INSERT INTO users(firstName,lastName,email,phone,password) VALUES("
                    + "'"+user.getFirstName()+"', '"+user.getLastName()
                    +"', '"+user.getEmail()+"', '"+user.getPhone()
                    +"', '"+user.getPassword()+"')");
        } catch (SQLException ex) {
            Logger.getLogger(UserDal.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void delete(int id) {
        try {
            statement.execute("DELETE FROM users WHERE id="+id);
        } catch (SQLException ex) {
            Logger.getLogger(UserDal.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public int getFirstUserId() {
        try {
            ResultSet set = statement.executeQuery("SELECT id FROM users ORDER BY id ASC LIMIT 1");
            if(set.next()) {
                return set.getInt("id");
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDal.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }
}
