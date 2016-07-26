$().ready(function () {
logInWithFacebook = function() {
    FB.login(function(response) {
        if (response.authResponse) {
            
            FB.api('/me',{fields: 'id, first_name, last_name, picture, email'},  function (response) {
                
                var kullanici =
                    {
                        Id: response.id,
                        Name: response.first_name,
                        LastName: response.last_name,                        
                        Email: response.email,
                    };

                $.ajax({
                    url: "RegisterFacebookUser",
                    method: "post",
                    data: { jSonVeri: JSON.stringify(kullanici) },
                    datatype: "json"
                }).success(function (gelenVeri) {
                    if (gelenVeri.Basari) {                       
                        setTimeout(function () {
                            window.location.href = "/Home/Index";
                        }, 1000);
                    }
                });

                var veri = { Email: response.email };

                $.ajax({
                    url: "FacebookLogin",
                    method: "post",
                    datatype: "json",
                    data: { jSonVeri: JSON.stringify(veri) }
                }).success(function (gelenVeri) {
                    if (gelenVeri.Basarili) {
                        window.location.href = "/Home/Index";
                    }
                    else {
                        window.location.href = "/Home/Index";
                    }
                });

            } );

        } else {
            alert('User cancelled login or did not fully authorize.');
        }
    }, {scope: 'email, public_profile'});
    return false;
};
});
window.fbAsyncInit = function() {
    FB.init({
        appId: '1614147942247846',
        cookie: true, // This is important, it's not enabled by default
        version: 'v2.6'
    });
};

(function(d, s, id){
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) {return;}
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));


