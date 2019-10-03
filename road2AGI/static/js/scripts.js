var img_name = "";

var chooseFile = function() {
    $('#file').click();  //returns a jQuery Object
};

var displayImage = function(file) {
    var preview = document.querySelector('#img-displayed');

    var reader = new FileReader();

    reader.addEventListener("load", function () {
        preview.src = reader.result;
    }, false);

    if (file) {
        reader.readAsDataURL(file);
    }
};

// Dropzone custom code
Dropzone.options.myAwesomeDropzone = {
  accept: function(file, done) {
    console.log("uploadedfile: " + file.name);
    img_name = file.name;
    displayImage(file);
    done();
  },
  init: function() {
    this.on("addedfile", function() {
      if (this.files[1]!=null){
        this.removeFile(this.files[0]);
      }
    });
    this.on("processing", function(file) {
      this.options.url = "/files/" + img_name;
    });
    this.on("complete", function(file) {
      this.removeFile(file);
    });
  },
  success: function(file, response){
    console.log(response);
  }
}


// Basic stripe app code

function message(status, shake=false, id="") {
  if (shake) {
    $("#"+id).effect("shake", {direction: "right", times: 2, distance: 8}, 250);
  }
  document.getElementById("feedback").innerHTML = status;
  $("#feedback").show().delay(2000).fadeOut();
}

function error(type) {
  $("."+type).css("border-color", "#E14448");
}

var login = function() {
  $.post({
    type: "POST",
    url: "/",
    data: {"username": $("#login-user").val(),
           "password": $("#login-pass").val()},
    success(response){
      var status = JSON.parse(response)["status"];
      if (status === "Login successful") { location.reload(); }
      else { error("login-input"); }
    }
  });
};

$(document).ready(function() {

  $(document).on("click", "#upload-button", chooseFile);

  $(document).on("click", "#login-button", login);
  $(document).keypress(function(e) {if(e.which === 13) {login();}});

  $(document).on("click", "#predict-button", function() {
    $.post({
      type: "POST",
      url: "/api/v1/" + img_name,
      success(response) {
       $("#prediction").text("Prediction: " + response.object_detected);
       $("#confidence").text("Confidence: " + response.confidence);
     },
     error(response) {
       console.log(response);
     }
    });
  });

  $(document).on("click", "#signup-button", function() {
    $.post({
      type: "POST",
      url: "/signup",
      data: {"username": $("#signup-user").val(),
             "password": $("#signup-pass").val(),
             "email": $("#signup-mail").val()},
      success(response) {
        var status = JSON.parse(response)["status"];
        if (status === "Signup successful") { location.reload(); }
        else { message(status, true, "signup-box"); }
      }
    });
  });

  $(document).on("click", "#save", function() {
    $.post({
      type: "POST",
      url: "/settings",
      data: {"username": $("#settings-user").val(),
             "password": $("#settings-pass").val(),
             "email": $("#settings-mail").val()},
      success(response){
        message(JSON.parse(response)["status"]);
      }
    });
  });
});

// Open or Close mobile & tablet menu
// https://github.com/jgthms/bulma/issues/856
$("#navbar-burger-id").click(function () {
  if($("#navbar-burger-id").hasClass("is-active")){
    $("#navbar-burger-id").removeClass("is-active");
    $("#navbar-menu-id").removeClass("is-active");
  }else {
    $("#navbar-burger-id").addClass("is-active");
    $("#navbar-menu-id").addClass("is-active");
  }
});
