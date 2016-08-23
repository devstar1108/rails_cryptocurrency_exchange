document.getElementById('range_switch').classList.add('hide');
document.getElementById('indicator_switch_wrapper').classList.add('hide');
var withdraw_info = [];
var sel_index = 0;
var cur_name = ""
var balance = 0;
var currency = null;
//
//var input_controls = document.getElementsByClassName("form-control");
//
//Array.prototype.forEach.call(input_controls, function(el) {
//    el.style.textAlign = 'center';
//    el.style.border = 'none';
//    el.style.height = '24px';
//    el.style.float = 'left';
//    el.style.width = '40%';
//    el.style.textAlign = 'right';
//});
//
//var panel_defaults = document.getElementsByClassName("panel-default");
//
//Array.prototype.forEach.call(panel_defaults, function(el) {
//    el.style.border = 'none';
//});
//
//var panel_bodies = document.getElementsByClassName("panel-body");
//
//Array.prototype.forEach.call(panel_bodies, function(el) {
//    el.style.padding = '0px';
//});
//
//var current_balances = document.getElementsByClassName("current-balance");
//
//Array.prototype.forEach.call(current_balances, function(el) {
//    el.style.display = 'none';
//});
//
//var units = document.getElementsByClassName("unit");
//
//Array.prototype.forEach.call(units, function(el) {
//    el.style.display = 'none';
//});
//
//document.getElementsByClassName("btn-block")[0].style.backgroundColor = '#c9413c';
//document.getElementsByClassName("btn-block")[0].style.color = '#ffffff';
//
//document.getElementsByClassName("btn-block")[1].style.backgroundColor = '#179c17';
//document.getElementsByClassName("btn-block")[1].style.color = '#ffffff';
//
//var input_groups = document.getElementsByClassName("input-group");
//
//Array.prototype.forEach.call(input_groups, function(el) {
//    el.style.border = 'solid 1px #e3e3e3';
//    el.style.borderRadius = '5px';
//    el.style.float = 'left';
//    el.style.height = '28px';
//    el.style.lineHeight = '24px';
//    el.style.padding = '3px;';
//});
//
//var input_group_addons = document.getElementsByClassName("input-group-addon");
//
//Array.prototype.forEach.call(input_group_addons, function(el) {
//    el.style.width = '30%';
//    el.style.paddingLeft = '5px;';
//    el.style.float = 'left';
//});
//
//var row_tips = document.getElementsByClassName("row-tips");
//
//Array.prototype.forEach.call(row_tips, function(el) {
//    el.style.display = 'none';
//});



function opendeposit_dialog(title, res_name, type)
{
    var current_dialog = document.getElementById("deposit_dialog");
    var deposit_dialog = document.getElementById("deposit_dialog");
    var withdraw_dialog = document.getElementById("withdraw_dialog");
    var manage_dialog = document.getElementById("manage_dialog");

    var backdrop = document.getElementById("modal_backdrop");
    if (hasClass(current_dialog, 'hide')) {
        current_dialog.classList.remove('hide');
        backdrop.classList.remove('hide');
    }
    current_dialog.getElementsByClassName('close')[0].onclick = function() {
        deposit_dialog.classList.add('hide');
        withdraw_dialog.classList.add('hide');
        manage_dialog.classList.add('hide');
        backdrop.classList.add('hide');
    }

    $("#deposit_dialog .main-title").text(title + " DEPOSIT");
    $("#deposit_dialog #code").val($("#" + type + "_deposit_address").val());
    $("#deposit_dialog .btn-newaddr").off("click").click(function() {
        genAddress(res_name);
    })
}

function openwithdraw_dialog(currency_name, currency_id)
{
    var current_dialog = document.getElementById("withdraw_dialog");
    var deposit_dialog = document.getElementById("deposit_dialog");
    var withdraw_dialog = document.getElementById("withdraw_dialog");
    var manage_dialog = document.getElementById("manage_dialog");

    var backdrop = document.getElementById("modal_backdrop");

    $("#withdraw_dialog .main-title").text(currency_name + " WITHDRAW");
    if (hasClass(current_dialog, 'hide')) {
        cur_name = currency_name;
        $("#withdraw_dialog #withdraw_label").html("")
        setWithdrawInfo(currency_id);
        current_dialog.classList.remove('hide');
        backdrop.classList.remove('hide');
    }
    current_dialog.getElementsByClassName('close')[0].onclick = function() {
        deposit_dialog.classList.add('hide');
        withdraw_dialog.classList.add('hide');
        manage_dialog.classList.add('hide');
        backdrop.classList.add('hide');

    }
}

function openmanage_dialog()
{
    var current_dialog = document.getElementById("manage_dialog");
    var deposit_dialog = document.getElementById("deposit_dialog");
    var withdraw_dialog = document.getElementById("withdraw_dialog");
    var manage_dialog = document.getElementById("manage_dialog");

    var backdrop = document.getElementById("modal_backdrop");
    if (hasClass(current_dialog, 'hide')) {

        $("#manage_dialog #coin_addr_list").html("");
        withdraw_info.forEach(function(element, index, array) {
                var checked =  (element.id == sel_index) ? 'checked':'';
                addLine(element, checked)
        })
        current_dialog.classList.remove('hide');

        withdraw_dialog.classList.add('hide');

    }
    current_dialog.getElementsByClassName('close')[0].onclick = function() {
        deposit_dialog.classList.add('hide');
        withdraw_dialog.classList.add('hide');
        manage_dialog.classList.add('hide');
        backdrop.classList.add('hide');

    }
}
function genAddress(resource_name)
{
    $.post("/deposits/" + resource_name + "/gen_address")
        .done(function() {

        })
        .fail(function(message) {
            alert(message.responseText);
        })
}
function setWithdrawInfo(currency_id)
{
    withdraw_info = [];
    sel_index = 0;
    balance = 0;
    $.get("/market_withdraw/" + currency_id)
        .done(function(res) {
            withdraw_info = res.info;
            sel_index = (res.sel_id.default_withdraw_fund_source_id == null) ? 0:res.sel_id.default_withdraw_fund_source_id ;
            balance = (res.sel_id.balance == null) ? 0:parseFloat(res.sel_id.balance) ;
            currency = res.currency
            withdraw_info.forEach(function(element, index, array) {
                $("#withdraw_dialog #withdraw_label").append("<option value=" + element.id + ">" + element.label +"</option>")
            })
        })
        .fail(function() {
            alert("error");
        })
}

function addItem()
{
    $.get("/add_fundsource/"+$("#manage_dialog #new_extra").val() + "/" + $("#manage_dialog #new_uid").val() + "/" + cur_name)
        .done(function(res) {
            withdraw_info.push(res);
            addLine(res,'');
            $("#manage_dialog #new_extra").val("");
            $("#manage_dialog #new_uid").val("")
        })
        .fail(function() {
            alert('Adding Item was failed. Try again later');
        })
}

function removeItem(id)
{
    $.get("/remove_fundsource/"+id)
        .done(function() {
            $("#manage_dialog #coin_addr_list .form-group." + id).empty();
            withdraw_info.splice(withdraw_info.findIndex(function(element){
                return element.id == id
            }), 1);
        })
        .fail(function() {
            alert('removeItem was failed')
        })



    //alert('remove');
}

function makeDefault(id)
{
    $.get("/default_fundsource/"+id)
        .done(function() {
            $("#manage_dialog #coin_addr_list input[type='radio']").each(function(){
                $(this).prop("checked", false)
            })
            $("#manage_dialog #coin_addr_list .form-group." + id + " input[type='radio']").prop("checked", true);
            sel_index = id;
        })
        .fail(function() {
            alert("setDefault was failed")
        })



    //alert('makeDefault');
}

function addLine(element, checked)
{
    $("#manage_dialog #coin_addr_list").append(
        '<div class="form-group ' + element.id + '">\
                        <div class="manage-address-first-block">\
                            <label>Label</label>\
                            <label>Address</label>\
                        </div>\
                        <div class="manage-address-second-block">\
                            <label>' + element.extra + '</label>\
                            <label>' + element.uid + '</label>\
                        </div>\
                        <div class="manage-address-third-block">\
                            <input type="radio" value="" onClick="makeDefault(' + element.id + ')" ' + checked + '>\
                            <a href="javascript:;" onClick="removeItem(' + element.id + ')"><i class="fa fa-trash-o">&nbsp;</i></a>\
                        </div>\
                    </div>');
}
function withdrawAll()
{
    $("#withdraw_sum").val(balance);
}

function sendSMSRequest()
{
    $.get("/two_factors/sms?refresh=true").done(function(res) {

    })
}

function withdrawSubmit()
{
    data ={
        two_factor: {type: $(".two_factor_auth_type").val(), otp: $("#two_factor_otp").val()},
        withdraw: {member_id: "", currency: cur_name, fund_source_id: $("#withdraw_label").val(), sum:$("#withdraw_sum").val()}
    }
    $.post('/withdraws/'+currency, data)
        .done(function(res) {
            manage_dialog.classList.add('hide');
            backdrop.classList.add('hide');
        })
        .fail(function(res) {
            alert(res.responseText);
            $('#withdraw_dialog').addClass('hide');
            $('#modal_backdrop').addClass('hide');

        })


}