function Validate() {
    if ($("#user-firstname").val() == "" ||
        $("#user-lastname").val() == "" ||
        $("#user-pw").val() == "" ||
        $("#user-email").val() == "" ||
        $("#captchaCode").val() == "") {
        var div = $("#divMessage");
        div
            .removeAttr("class")
            .addClass("has-error")
            .text("Tüm alanları eksiksiz doldurunuz");

        return false;
    }

    if ($("#user-pw").val() != $("#user-pw-repeat").val()) {
        var div = $("#divMessage");
        div
            .removeAttr("class")
            .addClass("has-error")
            .text("Şifre ve şifre tekrarı aynı değil");
        $("#txtSifre").closest('div.form_row').addClass("message error");

        return false;
    }

    return true;
}