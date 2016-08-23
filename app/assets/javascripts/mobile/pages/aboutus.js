/**
 * Created by Chris on 3/30/2016.
 */
document.getElementById('aivaras-btn').onclick = function() {
    var profile_dialog = document.getElementById("aivaras_dialog");
    var backdrop = document.getElementById("modal_backdrop");
    if (hasClass(profile_dialog, 'hide')) {
        profile_dialog.classList.remove('hide');
        backdrop.classList.remove('hide');
    }
    profile_dialog.getElementsByClassName('close')[0].onclick = function() {
        profile_dialog.classList.add('hide');
        backdrop.classList.add('hide');
    }

}
document.getElementById('vlad-btn').onclick = function() {
    var profile_dialog = document.getElementById("vlad_dialog");
    var backdrop = document.getElementById("modal_backdrop");
    if (hasClass(profile_dialog, 'hide')) {
        profile_dialog.classList.remove('hide');
        backdrop.classList.remove('hide');
    }
    profile_dialog.getElementsByClassName('close')[0].onclick = function() {
        profile_dialog.classList.add('hide');
        backdrop.classList.add('hide');
    }

}
document.getElementById('luis-btn').onclick = function() {
    var profile_dialog = document.getElementById("luis_dialog");
    var backdrop = document.getElementById("modal_backdrop");
    if (hasClass(profile_dialog, 'hide')) {
        profile_dialog.classList.remove('hide');
        backdrop.classList.remove('hide');
    }
    profile_dialog.getElementsByClassName('close')[0].onclick = function() {
        profile_dialog.classList.add('hide');
        backdrop.classList.add('hide');
    }

}
document.getElementById('christian-btn').onclick = function() {
    var profile_dialog = document.getElementById("christian_dialog");
    var backdrop = document.getElementById("modal_backdrop");
    if (hasClass(profile_dialog, 'hide')) {
        profile_dialog.classList.remove('hide');
        backdrop.classList.remove('hide');
    }
    profile_dialog.getElementsByClassName('close')[0].onclick = function() {
        profile_dialog.classList.add('hide');
        backdrop.classList.add('hide');
    }

}
