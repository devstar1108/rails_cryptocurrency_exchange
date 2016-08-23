
/*document.getElementById('label-types').onclick = function () {
    var market_options = document.getElementById("label-type-list");
    if (hasClass(market_options, 'hide-class')) {
        market_options.classList.remove('hide-class');
        document.getElementById("label-types-right").innerHTML = '^';
    } else {
        market_options.classList.add('hide-class');
        document.getElementById("label-types-right").innerHTML = 'v';
    }
}


document.getElementById('deposit-btn').onclick = function () {
    document.getElementById('deposit-btn').classList.add('bg-green-c-w');
    document.getElementById('deposit-btn-icon').classList.remove('bg-w-c-green');
    document.getElementById('withdraw-btn').classList.remove('bg-red-c-white');
    document.getElementById('withdraw-btn-icon').classList.add('bg-white-c-red');

    document.getElementById('withdraw-div').classList.add('hide-class');
    document.getElementById('deposit-div').classList.remove('hide-class');
    document.getElementById('deposit-table').classList.remove('hide-class');
    document.getElementById('withdraw-table').classList.add('hide-class');
}

document.getElementById('withdraw-btn').onclick = function () {
    document.getElementById('deposit-btn').classList.remove('bg-green-c-w');
    document.getElementById('deposit-btn-icon').classList.add('bg-w-c-green');
    document.getElementById('withdraw-btn').classList.add('bg-red-c-white');
    document.getElementById('withdraw-btn-icon').classList.remove('bg-white-c-red');

    document.getElementById('withdraw-div').classList.remove('hide-class');
    document.getElementById('deposit-div').classList.add('hide-class');
    document.getElementById('deposit-table').classList.add('hide-class');
    document.getElementById('withdraw-table').classList.remove('hide-class');
}*/
function openmanage_dialog() {
    var current_dialog = document.getElementById("manage_dialog");

    var backdrop = document.getElementById("modal_backdrop");
    if (hasClass(current_dialog, 'hide')) {

        current_dialog.classList.remove('hide');
        backdrop.classList.remove('hide');

    }
    current_dialog.getElementsByClassName('close')[0].onclick = function () {
        current_dialog.classList.add('hide');
        backdrop.classList.add('hide');

    }
}
function open_bitcoin_list() {
    var backdrop = document.getElementById("modal_backdrop");
    document.getElementById("bitcoin-list-div").classList.remove('hide');
    backdrop.classList.remove('hide');
}
function close_bitcoin_list() {
    var backdrop = document.getElementById("modal_backdrop");
    document.getElementById("bitcoin-list-div").classList.add('hide');
    backdrop.classList.add('hide');
}

function open_qrcodesection() {

    var market_options = document.getElementById("open-qrcode-list");
    if (hasClass(market_options, 'hide-class')) {
        market_options.classList.remove('hide-class');
        document.getElementById("open-qrcode-right").innerHTML = '<i class="fa fa-angle-up"></i>';
    } else {
        market_options.classList.add('hide-class');
        document.getElementById("open-qrcode-right").innerHTML = '<i class="fa fa-angle-down"></i>';
    }
}
