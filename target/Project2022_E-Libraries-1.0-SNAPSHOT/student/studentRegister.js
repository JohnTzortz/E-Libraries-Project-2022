$(document).ready(function() 
{ 

    $('#icon_visibility1').on("click", function(){
        let passType = $("#user_pass").attr('type');
        

        if(passType === 'password'){
            $("#user_pass").attr('type', 'text');
            $('#icon_visibility1').text('visibility');
        }else{
            $("#user_pass").attr('type', 'password');
            $('#icon_visibility1').text('visibility_off');
        }
    });
    
    $('#icon_visibility2').on("click", function(){
        let passType = $("#confirm_pass").attr('type');
        

        if(passType === 'password'){
            $("#confirm_pass").attr('type', 'text');
            $('#icon_visibility2').text('visibility');
        }else{
            $("#confirm_pass").attr('type', 'password');
            $('#icon_visibility2').text('visibility_off');
        }
    });

    $('#previousButtonId').click(function(){
       if($('#step').text() === "Step 2"){
            $('#usernameDivId').show(); //username
            $('#emailDivId').show(); //email
            $('#passwordDivId').show(); //password
            $('#passwordConfirmDivId').show(); //password confirm

            $('#step').text('Step 1');

            $('#previousButtonId').attr('disabled', true);
       }
    });

    $('#nextButtonId').click(function(){
       if($('#step').text() === "Step 1"){
            $('#usernameDivId').hide();//username
            $('#emailDivId').hide();  //email
            $('#passwordDivId').hide();  //password
            $('#passwordConfirmDivId').hide();  //password confirm

            $('#step').text('Step 2');

            $('#previousButtonId').removeAttr('disabled');

            //enable stuff here

       }else
            if($('#step').text() === "Step 2"){
                //disable and enable stuff here
            }
    });



    
}); 

        
        