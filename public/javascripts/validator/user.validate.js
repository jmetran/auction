$().ready(function() {
    
    $("#new_user").bind("submit",function(){
      return validate_terms_of_service();
    });

    function validate_terms_of_service(){
      if ($('#user_terms_of_service').is(':checked')) {
        $(".terms_of_service_error").html("");
        return true;
      }else{
        $(".terms_of_service_error").html("Please accept our terms of service");
        return false;
      }
    }

    $('#user_terms_of_service').click(function(){
      validate_terms_of_service();
    });

    $("#user_day").click(function(){
      $("#user_year").valid();
    });

    $("#user_month").click(function(){
      $("#user_year").valid();
    });

    $.validator.addMethod(
    "dateRange",
    function(value, element) {
      var startDate = Date.parse('1901-01-01'),
      endDate = Date.parse('2008-12-31'),
      enteredDate = Date.parse(value);

      if (isNaN(enteredDate)) {
          return false;
      }
      return ((startDate <= enteredDate) && (enteredDate <= endDate));
    },"Please specify a date between 1901-01-01 and 2008-12-31"
    );

    $.validator.addMethod(
    "validateDate",
    function(value, element) {
      var day = $("#user_day").val();
      var month = $("#user_month").val();
      var year = $("#user_year").val();

      if (day == "" || month == "" || year == "") {
        return false;
      }else{
        return true;
      }
    }, invalid("Birth date")
    );

    $("#new_user").validate({
      rules: {
        "user[username]": { required: true, minlength: 5, maxlength: 50, remote: "/validate_username" },
        "user[password]": { required: true, minlength: 6, maxlength: 50 },
        "user[password_confirmation]": { required: true, equalTo: "#user_password" },
        "user[first_name]": { required: true, maxlength: 50 },
        "user[last_name]": { required: true, maxlength: 50 },
        "user[email]": { required: true, email: true, maxlength: 100 },
        "user[email_confirmation]": { required: true, email: true, equalTo: "#user_email" },
        "user[gender]": { required: true },
        "user[year]": { validateDate: true, dateRange: true },
        "user[user_type]": { required: true }
      },
      messages: {
        "user[username]": { required: cant_be_blank("Username"), minlength: str_minimum("Username", 5), remote: "Username is not available" },
        "user[password]": { required: cant_be_blank("Password"), minlength: str_minimum("Password", 6) },
        "user[password_confirmation]": { required: cant_be_blank("Password confirmation"), equalTo: equal_to("password confirmation") },
        "user[first_name]": { required: cant_be_blank("First name") },
        "user[last_name]": { required: cant_be_blank("Last name") },
        "user[first_name]": { required: cant_be_blank("First name") },
        "user[email]": { required: cant_be_blank("Email"), email: invalid("Email") },
        "user[email_confirmation]": { required: cant_be_blank("Email"), email: invalid("Email"), equalTo: equal_to("email")},
        "user[gender]": { required: select_message("gender") },
        "user[user_type]": { required: select_message("user type") }
      }
    });

});