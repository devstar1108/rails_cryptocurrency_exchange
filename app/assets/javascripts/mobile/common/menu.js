document.getElementById('menu-but').onclick = function() {
    document.getElementById('menu-board').classList.remove('hide-class');
    document.getElementById('mask-div').classList.remove('hide-class');
    document.getElementById('custom-nav').classList.add('hide-class');
    document.getElementById('custom-nav-2').classList.remove('hide-class');
}

document.getElementById('mask-div').onclick = function() {
    document.getElementById('custom-nav-2').classList.add('hide-class');
    document.getElementById('custom-nav').classList.remove('hide-class');
    document.getElementById('menu-board').classList.add('hide-class');
    document.getElementById('mask-div').classList.add('hide-class');
    document.getElementById('menu-board-2').classList.add('hide-class');
    document.getElementById('custom-nav-3').classList.add('hide-class');
}

document.getElementById('menu-close-but').onclick = function() {
    document.getElementById('custom-nav-2').classList.add('hide-class');
    document.getElementById('custom-nav').classList.remove('hide-class');
    document.getElementById('menu-board').classList.add('hide-class');
    document.getElementById('mask-div').classList.add('hide-class');
}

document.getElementById('help-btn').onclick = function() {
    document.getElementById('custom-nav').classList.add('hide-class');
    document.getElementById('mask-div').classList.remove('hide-class');
    document.getElementById('custom-nav-3').classList.remove('hide-class');
    document.getElementById('menu-board-2').classList.remove('hide-class');
}

document.getElementById('menu-2-close-but').onclick = function() {
    document.getElementById('custom-nav-3').classList.add('hide-class');
    document.getElementById('custom-nav').classList.remove('hide-class');
    document.getElementById('mask-div').classList.add('hide-class');
    document.getElementById('menu-board-2').classList.add('hide-class');
}
