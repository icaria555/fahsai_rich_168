// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//





//= require bootstrap-datepicker
//= require locales/bootstrap-datepicker.th
//= require app
//= require jquery.slimscroll
//= require select2

//= require flash
//= require users

$(document).ready(function () {
	$('.datepicker').datepicker({language: 'th'});
});

function addRowOrder() {
    var div = document.createElement('div');

    div.className = 'row';
    var productelement = document.getElementById('productlist').lastElementChild
    var generate_num = parseInt(productelement.getAttribute("id").split("_")[1]) + 1
    var select = productelement.firstElementChild
    console.log(select.getAttribute("id"))

    select.setAttribute("id", "products_" + generate_num.toString())
    select = productelement.firstChild

    

    div.parseHTML('<input type="number" name="quantity_1" id="quantity_' + generate_num.toString() + '" />\
      <input type="number" name="price_1" id="price_' + generate_num.toString() + '" />\
      <input type="number" name="pv_1" id="pv_' + generate_num.toString() + '" />');
    div.appendChild(select)


    document.getElementById('productlist').appendChild(div);
}
