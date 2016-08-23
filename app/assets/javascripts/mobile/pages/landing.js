/**
 * Created by Chris on 3/30/2016.
 */
function openSigninBox()
{
    var login_dialog = document.getElementById("login_dialog");
    var register_dialog = document.getElementById("register_dialog");
    var backdrop = document.getElementById("modal_backdrop");
    if (hasClass(login_dialog, 'hide')) {
        login_dialog.classList.remove('hide');
        backdrop.classList.remove('hide');
        register_dialog.classList.add('hide');
    }
    login_dialog.getElementsByClassName('close')[0].onclick = function() {
        login_dialog.classList.add('hide');
        register_dialog.classList.add('hide');
        backdrop.classList.add('hide');
    }
}

function openSignupBox ()
{
    var login_dialog = document.getElementById("login_dialog");
    var register_dialog = document.getElementById("register_dialog");
    var backdrop = document.getElementById("modal_backdrop");
    if (hasClass(register_dialog, 'hide')) {
        register_dialog .classList.remove('hide');
        backdrop.classList.remove('hide');
        login_dialog.classList.add('hide');
    }
    register_dialog.getElementsByClassName('close')[0].onclick = function() {
        login_dialog.classList.add('hide');
        register_dialog.classList.add('hide');
        backdrop.classList.add('hide');
    }

}

document.getElementById('login-btn').onclick = function() {
    openSigninBox();
}
document.getElementById('register-btn').onclick = function() {
    openSignupBox();
}

function ScrollControl()
{
    if(document.body.scrollTop > 50 || document.documentElement.scrollTop > 50)
    {
        document.body.className = "";
    }
    else
    {
        document.body.className = "menu-transparent";
    }
}
if(window.location.hash == "#signin"){
    openSigninBox();
}
else if(window.location.hash == "#signup"){
    openSignupBox();
}