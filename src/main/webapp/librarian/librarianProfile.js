$("#showNewPasswordStrength").click(function() 
{
    if($("#showNewPasswordStrength").is(':checked'))
        $("#passwordStrength").show();
    else
        $("#passwordStrength").hide();
});

$("#edit").click(function() 
{
    $("#edit").prop("disabled", true); 
    $("#fields").prop("disabled", false); 
});

$("#showPasswords").click(function() 
{
    if($("#showPasswords").is(':checked'))
    {
        $("#oldPassword").attr('type', 'text');
        $("#newPassword").attr('type', 'text');
    }
    else
    {
        $("#oldPassword").attr('type', 'password');
        $("#newPassword").attr('type', 'password');
    }
});

$("#newPassword").on('input', function() {
    //$("#verifyNewPassword").get(0).setCustomValidity('');
    $("#passwordStrength").html("New password strength: <b>" + pwdStrength($("#newPassword").val()) + "</b>");
});

$("#studentUpdate").submit(function() 
{
    if($("#newPassword").val() !== $("#verifyNewPassword").val())
    {
        //$("#verifyNewPassword").get(0).setCustomValidity("Passwords do not match.");
        //$("#verifyNewPassword").get(0).reportValidity();
        return false;
    }
    return true;
});

$(document).ready(function() 
{ 
    $(".coords").hide();
    $("#passwordStrength").hide();
});