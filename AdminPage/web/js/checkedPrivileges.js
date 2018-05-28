var checkPrivilege = function(){
    var id = $('select[name="userList"] :selected').attr('value');  
    var idUserSaveButton = document.getElementById('idUserSaveButton');
    idUserSaveButton.value = id;
    
    var checkboxDiv = document.getElementsByClassName('privilegeCheckBox');
    var checkedBoxesString = "";
    var uncheckedBoxesString = "";
    
    for (var i=0; i<checkboxDiv.length; i++) {
        var idCheckBox = checkboxDiv[i].value;
      
        if(checkboxDiv[i].checked) {
            checkedBoxesString = checkedBoxesString + idCheckBox + "/";
        } else {
            uncheckedBoxesString = uncheckedBoxesString + idCheckBox + "/";
        }
    }
    
    var checkedBoxes = document.getElementById('checkedBoxes');
    checkedBoxes.value = checkedBoxesString;
    
    var uncheckedBoxes = document.getElementById('uncheckedBoxes');
    uncheckedBoxes.value = uncheckedBoxesString;
};


