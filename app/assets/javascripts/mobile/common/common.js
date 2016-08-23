document.getElementById("octacoin-market-types").onclick = function() {
    var market_options = document.getElementById("octacoin-market-options");
    if (hasClass(market_options, 'hide-class')) {
        market_options.classList.remove('hide-class');
        document.getElementById("octacoin-market-types-name-right").innerHTML = '<i class="fa fa-angle-up"></i>';
    } else {
        market_options.classList.add('hide-class');
        document.getElementById("octacoin-market-types-name-right").innerHTML = '<i class="fa fa-angle-down"></i>';
    }
};

document.getElementById("public-open-orders").onclick = function() {
    var market_options = document.getElementById("public-open-orders-result-div");
    if (hasClass(market_options, 'hide-class')) {
        market_options.classList.remove('hide-class');
        document.getElementById("public-open-orders-right").innerHTML = '<i class="fa fa-angle-up"></i>';
    } else {
        market_options.classList.add('hide-class');
        document.getElementById("public-open-orders-right").innerHTML = '<i class="fa fa-angle-down"></i>';
    }
};

var description_types = document.getElementsByClassName("nav-description-type");

Array.prototype.forEach.call(description_types, function(el) {
    // Do stuff here
    el.onclick = function() {
        Array.prototype.forEach.call(description_types, function(remove_el) {
            if (hasClass(remove_el, 'li-selected')) {
                remove_el.classList.remove('li-selected');
            }
        });
        el.classList.add('li-selected');
        if (el.innerText == 'PUBLIC ASK') {
            document.getElementById('public-bid').classList.add('hide-class');
            document.getElementById('public-last').classList.add('hide-class');
            document.getElementById('public-ask').classList.remove('hide-class');
        } else if (el.innerText == 'PUBLIC LAST') {
            document.getElementById('public-last').classList.remove('hide-class');
            document.getElementById('public-bid').classList.add('hide-class');
            document.getElementById('public-ask').classList.add('hide-class');
        } else {
            document.getElementById('public-last').classList.add('hide-class');
            document.getElementById('public-bid').classList.remove('hide-class');
            document.getElementById('public-ask').classList.add('hide-class');
        }
    }
});

var open_lasts = document.getElementsByClassName("open-li");

Array.prototype.forEach.call(open_lasts, function(el) {
    // Do stuff here
    el.onclick = function() {
        Array.prototype.forEach.call(open_lasts, function(remove_el) {
            if (hasClass(remove_el, 'li-selected')) {
                remove_el.classList.remove('li-selected');
            }
        });
        el.classList.add('li-selected');
    }
});

document.getElementById('octacoin-market-price-type').onclick = function() {
    var market_options = document.getElementById("octacoin-market-price-options");
    if (hasClass(market_options, 'hide-class')) {
        market_options.classList.remove('hide-class');
        document.getElementById("octacoin-market-price-name-right").innerHTML = '<i class="fa fa-angle-up"></i>';
    } else {
        market_options.classList.add('hide-class');
        document.getElementById("octacoin-market-price-name-right").innerHTML = '<i class="fa fa-angle-down"></i>';
    }
}

var octacoin_values = document.getElementsByClassName('octacoin-values');

Array.prototype.forEach.call(octacoin_values, function(el) {
    // Do stuff here
    el.onclick = function() {
        var temp = document.getElementById('octacoin-market-price-name-left').innerHTML;
        document.getElementById('octacoin-market-price-name-left').innerHTML = el.innerHTML;
        el.innerHTML = temp;

        var market_options = document.getElementById("octacoin-market-price-options");
        market_options.classList.add('hide-class');
        document.getElementById("octacoin-market-price-name-right").innerHTML = '<i class="fa fa-angle-down"></i>';
    }
});


