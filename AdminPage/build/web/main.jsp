<%@page import="src.Model.Privilege"%>
<%@page import="src.Dal.PrivilegeDal"%>
<%@page import="src.Model.User"%>
<%@page import="java.util.List"%>
<%@page import="src.Constants"%>
<%@page import="src.Dal.UserDal"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    UserDal userDal = new UserDal(Constants.url, Constants.login, Constants.password);
    PrivilegeDal privilegeDal = new PrivilegeDal(Constants.url, Constants.login, Constants.password);

    String funcName = request.getParameter("func");
    String id = request.getParameter("id");
    boolean showPrivileges = false;

    int idUserList = userDal.getFirstUserId();
    User userList = userDal.selectAllPrivilegesForUser(idUserList);

    if (funcName != null && funcName.equalsIgnoreCase("delete")) {
        userDal.delete(Integer.parseInt(id));
    }

    if (funcName != null && funcName.equalsIgnoreCase("insert")) {
        String firstname = request.getParameter("firstNameInsert");
        String lastname = request.getParameter("lastNameInsert");
        String email = request.getParameter("emailInsert");
        String phone = request.getParameter("phoneInsert");
        String password = request.getParameter("passwordInsert");

        User user = new User(firstname, lastname, email, phone, password);
        userDal.insert(user);
    }

    if (funcName != null && funcName.equalsIgnoreCase("update")) {
        String firstname = request.getParameter("firstNameUpdate");
        String lastname = request.getParameter("lastNameUpdate");
        String email = request.getParameter("emailUpdate");
        String phone = request.getParameter("phoneUpdate");
        String password = request.getParameter("passwordUpdate");

        User user = new User(firstname, lastname, email, phone, password);
        userDal.update(user, Integer.parseInt(id));
    }

    if (funcName != null && funcName.equalsIgnoreCase("getPrivileges")) {
        idUserList = Integer.parseInt(request.getParameter("idUserList"));
        userList = userDal.selectAllPrivilegesForUser(idUserList);
        showPrivileges = true;
    }

    if (funcName != null && funcName.equalsIgnoreCase("savePrivileges")) {

        idUserList = Integer.parseInt(request.getParameter("idUserSaveButton"));

        String checkedBoxesString = request.getParameter("checkedBoxes");
        String uncheckedBoxesString = request.getParameter("uncheckedBoxes");

        if (!checkedBoxesString.equals("")) {
            String[] checkedBoxes = checkedBoxesString.split("/");
            for (int i = 0; i < checkedBoxes.length; i++) {
                if (!privilegeDal.hasPrivilegeById(idUserList, Integer.parseInt(checkedBoxes[i]))) {
                    privilegeDal.insertPrivilegeById(idUserList, Integer.parseInt(checkedBoxes[i]));
                }
            }
        }

        if (!uncheckedBoxesString.equals("")) {
            String[] uncheckedBoxes = uncheckedBoxesString.split("/");
            for (int i = 0; i < uncheckedBoxes.length; i++) {
                if (privilegeDal.hasPrivilegeById(idUserList, Integer.parseInt(uncheckedBoxes[i]))) {
                    privilegeDal.deletePrivilegeById(idUserList, Integer.parseInt(uncheckedBoxes[i]));
                }
            }
        }
        userList = userDal.selectAllPrivilegesForUser(idUserList);
        showPrivileges = true;
    }
%>


<%
    List<String> columnNamesUsers = userDal.getColumnNames();
    List<User> listUsers = userDal.selectAll();
    List<User> idAndNamesUsers = userDal.selectIdAndNames();

    List<String> columnNamesPrivileges = privilegeDal.getColumnNames();
    List<Privilege> privileges = privilegeDal.selectAll();

    List<User> userall = userDal.selectAllUsersPrivileges();

    userDal.closeConnection();
    privilegeDal.closeConnection();
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Welcome!</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/mainStyle.css" rel="stylesheet">
        <link href="css/table.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="card">
                        <ul class="nav nav-tabs" role="tablist">
                            <li role="presentation"<%= showPrivileges == false ? "class='active'" : ""%> >
                                <a href="#users" aria-controls="users" 
                                   role="tab" data-toggle="tab">Users
                                </a>
                            </li>
                            <li role="presentation" <%= showPrivileges == true ? "class='active'" : ""%> >
                                <a href="#privileges" aria-controls="privileges"
                                   role="tab" data-toggle="tab">Privileges
                                </a>
                            </li>
                        </ul>

                        <div class="tab-content">
                            <div role="tabpanel" class="tab-pane <%= showPrivileges == false ? "active" : ""%>" id="users">
                                <div class="container">
                                    <div class ="row">
                                        <div class="col-md-1 col-lg-1 col-sm-1 col-xs-1">
                                            <button type="button" class="btn btn-primary"
                                                    data-toggle="modal"
                                                    data-target="#myModalInsert">Insert
                                            </button>
                                        </div>
                                        <div class="col-md-1 col-lg-1 col-sm-1 col-xs-1">
                                            <button type="button" class="btn btn-primary"
                                                    data-toggle="modal"
                                                    data-target="#myModalUpdate">Update
                                            </button>
                                        </div>
                                        <div class="col-md-1 col-lg-1 col-sm-1 col-xs-1">
                                            <button type="button" class="btn btn-danger"
                                                    data-toggle="modal"
                                                    data-target="#myModalDelete">Delete
                                            </button>
                                        </div>
                                    </div>
                                    <br>
                                    <div class ="row">
                                        <div class="col-md-7 col-lg-7 col-sm-7 col-xs-7">
     
                                            <table id="table" class="table table-bordered">
                                                <tr>
                                                    <% for (int i = 0; i < columnNamesUsers.size(); i++) {%>
                                                    <th><%= columnNamesUsers.get(i)%></th>
                                                    <%}%>
                                                </tr>

                                                <% for (User user : listUsers) {%>
                                                <tr>
                                                    <td><%= user.getId()%></td>
                                                    <td><%= user.getFirstName()%></td>
                                                    <td><%= user.getLastName()%></td>
                                                    <td><%= user.getEmail()%></td>
                                                    <td><%= user.getPhone()%></td>
                                                    <td><%= user.getPassword()%></td>
                                                </tr>
                                                <%}%>
                                            </table>
                                       
                                        </div>
                                    </div>

                                </div>   
                            </div>
                            <div role="tabpanel"
                                 class="tab-pane <%= showPrivileges == true ? "active" : ""%>"
                                 id="privileges">
                                <div class="row">
                                    <div class="form-group col-md-4 col-sm-4 col-xs-4">
                                        <form method="POST" action="main.jsp" id ="userListForm">
                                            <label for="usersList">Select user:</label>
                                            <select name="userList" class="form-control"
                                                    id="usersList" onchange="selectfunc()">
                                                <% for (User user : idAndNamesUsers) {%>
                                                <option value="<%=user.getId()%>"
                                                        <%= user.getId() == idUserList ? 
                                                                "selected" : ""%>>
                                                    <%=user.getFirstName()%> <%=user.getLastName()%> (id: <%=user.getId()%>)
                                                </option>
                                                <% } %>
                                            </select>
                                            <input type="hidden" name="idUserList" value="1" id="idUserList"/>
                                            <input type="hidden" name="func" value="getPrivileges" />
                                        </form>
                                    </div>

                                    <div class="col-md-6 col-sm-6 col-xs-6"> 
                                        <div class="form-group">    
                                            <form method="POST" action="main.jsp">
                                                <div class="checkbox" id="checkboxDiv">
                                                    <% for (Privilege privilege : privileges) {%>
                                                    <input class="privilegeCheckBox"
                                                           type="checkbox"
                                                           value="<%=privilege.getId()%>"
                                                           id="privilege<%=privilege.getId()%>"
                                                           <%=(userList != null && userList.getPrivileges().indexOf(privilege) >= 0) ?
                                                                   "checked" : ""%> /> 
                                                    <label><%=privilege.getName()%> (<%=privilege.getDescription()%>)
                                                    </label>
                                                    <Br>
                                                    <%}%>
                                                </div>
                                                <Br>
                                                <button onclick="checkPrivilege()"
                                                        name="saveButton"
                                                        type="submit"
                                                        class="btn btn-basic">Save
                                                </button>
                                                <input type="hidden" name="func" 
                                                       value="savePrivileges"/>
                                                <input type="hidden" name="idUserSaveButton" 
                                                       id="idUserSaveButton" value=""/>
                                                <input type="hidden" name="checkedBoxes"
                                                       id="checkedBoxes" value=""/>
                                                <input type="hidden" name="uncheckedBoxes"
                                                       id="uncheckedBoxes" value=""/>
                                            </form>   
                                        </div>                                                
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <div id="myModalUpdate" class="modal fade" role="dialog">
            <div class="modal-dialog">

                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Update User</h4>
                    </div>
                    <div class="modal-body">
                        <form method="post" action="main.jsp">
                            <div class="row">
                                <div class="col-md-2">
                                    <p align="left">First name</p>
                                </div>
                                <div class="col-md-3">
                                    <input type="text" name="firstNameUpdate"
                                           value="" id="firstNameUpdate"/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-2">
                                    <p align="left">Last name</p>
                                </div>
                                <div class="col-md-3">
                                    <input type="text" name="lastNameUpdate"
                                           value="" id="lastNameUpdate"/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-2">
                                    <p align="left">Email</p>
                                </div>
                                <div class="col-md-3">
                                    <input type="text" name="emailUpdate"
                                           value="" id="emailUpdate"/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-2">
                                    <p align="left">Phone</p>
                                </div>
                                <div class="col-md-3">
                                    <input type="text" name="phoneUpdate"
                                           value="" id="phoneUpdate"/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-2">
                                    <p align="left">Password</p>
                                </div>
                                <div class="col-md-3">
                                    <input type="text" name="passwordUpdate"
                                           value="" id="passwordUpdate"/>
                                </div>
                            </div>
                            <input type="hidden" name="id" value="0" id="update"/>
                            <input type="hidden" name="func" value="update" />
                            <button class="btn btn-default" type="submit">Update</button>
                        </form>
                    </div>

                </div>

            </div>
        </div>

        <div id="myModalInsert" class="modal fade" role="dialog">
            <div class="modal-dialog">

                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Insert User</h4>
                    </div>
                    <div class="modal-body">
                        <form method="post" action="main.jsp">
                            <div class="row">
                                <div class="col-md-2">
                                    <p align="left">First name</p>
                                </div>
                                <div class="col-md-3">
                                    <input type="text" name="firstNameInsert"
                                           value="" id="firstNameInsert"/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-2">
                                    <p align="left">Last name</p>
                                </div>
                                <div class="col-md-3">
                                    <input type="text" name="lastNameInsert"
                                           value="" id="lastNameInsert"/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-2">
                                    <p align="left">Email</p>
                                </div>
                                <div class="col-md-3">
                                    <input type="text" name="emailInsert"
                                           value="" id="emailInsert" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-2">
                                    <p align="left">Phone</p>
                                </div>
                                <div class="col-md-3">
                                    <input type="text" name="phoneInsert"
                                           value="" id="phoneInsert" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-2">
                                    <p align="left">Password</p>
                                </div>
                                <div class="col-md-3">
                                    <input type="text" name="passwordInsert"
                                           value="" id="passwordInsert" />
                                </div>
                            </div>
                            <input type="hidden" name="id" value="0" id="insert"/>
                            <input type="hidden" name="func" value="insert" />
                            <button class="btn btn-default" type="submit">Insert</button>
                        </form>
                    </div>
                </div>

            </div>
        </div>


        <div id="myModalDelete" class="modal fade" role="dialog">
            <div class="modal-dialog">

                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Are you sure you want to delete the user?</h4>
                    </div>
                    <div class="modal-body">
                        <form method="post" action="main.jsp">
                            <input type="hidden" name="id" value="0" id="delete"/>
                            <input type="hidden" name="func" value="delete" />
                            <input type="submit" value="Yes"/>
                        </form><br>
                        <button type="submit" data-dismiss="modal">No</button>
                    </div>

                </div>

            </div>
        </div>                                                

        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/selectList1.js"></script>
        <script src="js/table1.js"></script>
        <script src="js/checkedPrivileges.js"></script>
    </body>
</html>
