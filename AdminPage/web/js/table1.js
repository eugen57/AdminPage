
window.onload = function () {
    
    function highlight(e) {
        
        if (selected[0]) 
            selected[0].className = '';
        e.target.parentNode.className = 'selected';
        var value = $(".selected td:first").html();
        
        var firstNameTable = $(".selected td:eq(1)").html();
        var lastNameTable = $(".selected td:eq(2)").html();
        var emailTable = $(".selected td:eq(3)").html();
        var phoneTable = $(".selected td:eq(4)").html();
        var passwordTable = $(".selected td:eq(5)").html();
        
        
        var deleteButton = document.getElementById('delete');
        var insertButton = document.getElementById('insert');
        var updateButton = document.getElementById('update');
        deleteButton.value= value;
        insertButton.value= value;
        updateButton.value= value;
        
        var firstName = document.getElementById('firstNameUpdate');
        firstName.value= firstNameTable;
        
        var lastName = document.getElementById('lastNameUpdate');
        lastName.value= lastNameTable;
        
        var email = document.getElementById('emailUpdate');
        email.value= emailTable;
        
        var phone = document.getElementById('phoneUpdate');
        phone.value= phoneTable;
        
        var password = document.getElementById('passwordUpdate');
        password.value= passwordTable;
    }
        var table = document.getElementById('table');
        var selected = table.getElementsByClassName('selected');
        table.onclick = highlight;
        chooseUser();
};
    
    
    




