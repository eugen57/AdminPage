 var selectfunc=function() {
   var id = $('select[name="userList"] :selected').attr('value');
    var idUserList = document.getElementById('idUserList');
    idUserList.value = id;

    $('#userListForm').submit();
};



    
