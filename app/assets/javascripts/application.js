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

    div.className = 'field';
    var productelement = document.getElementById('productlist').lastElementChild
    var generate_num = parseInt(productelement.getAttribute("id").split("_")[1]) + 1
    div.id = 'row_' + generate_num.toString()
    var select = productelement.firstElementChild.cloneNode(true)
    select.id = 'products_' + generate_num.toString()
    
    select.setAttribute("id", "products_" + generate_num.toString())
    div.appendChild(select)
    div.innerHTML = div.innerHTML + '<input type="number" name="quantity_1" id="quantity_' + generate_num.toString() + '" value="0" />\
      <input type="number" name="price_1" id="price_' + generate_num.toString() + '" value="0" />\
      <input type="number" name="pv_1" id="pv_' + generate_num.toString() + '" value="0" />\
      <button name="button" type="button" onclick="javascript:deleteRow(' + generate_num.toString() + ')">delete</button>';
    //console.log(div.innerHTML)
    document.getElementById('productlist').appendChild(div);
    //console.log(document.getElementById('productlist').innerHTML);
}

function addRowStatement() {
    var div = document.createElement('div');

    div.className = 'field';
    var productelement = document.getElementById('productlist').lastElementChild
    var generate_num = parseInt(productelement.getAttribute("id").split("_")[1]) + 1
    div.id = 'row_' + generate_num.toString()
    var select = productelement.firstElementChild.cloneNode(true)
    
    select.setAttribute("id", "products_" + generate_num.toString())
    div.appendChild(select)
    div.innerHTML = div.innerHTML + '<input type="number" name="quantity_1" id="quantity_' + generate_num.toString() + '" value="0" />\
      <input type="number" name="price_1" id="price_' + generate_num.toString() + '" value="0" />\
      <input type="number" name="pv_1" id="pv_' + generate_num.toString() + '" value="0" />\
      <button name="button" type="button" onclick="javascript:deleteRow(' + generate_num.toString() + ')">delete</button>';
    //console.log(div.innerHTML)
    document.getElementById('productlist').appendChild(div);
    //console.log(document.getElementById('productlist').innerHTML);
}

function deleteRow(row_num) {
    var id_name = "row_" + row_num
    var delete_target = document.getElementById(id_name);
    var parentNode = delete_target.parentNode
    parentNode.removeChild(delete_target)
    console.log(row_num)
    calculatePrice()
}

function calculateTotalPrice() {
    var productelement = document.getElementById('productlist').children
    var totalprice = 0
    var totalpv = 0
    for (i = 0; i < productelement.length; i++) {
        rowelement = productelement[i].children
        console.log(rowelement.length)
        
        for (j = 2; j < rowelement.length; j++) {
            if(rowelement[j].id.split("_")[0] == "price") {
                totalprice += parseInt(rowelement[j].value)
            }
            else if (rowelement[j].id.split("_")[0] == "pv"){
                totalpv += parseInt(rowelement[j].value)
            }
            console.log(rowelement[j])
        }
    }
    document.getElementById('order_total_price').value = totalprice
    document.getElementById('order_total_pv').value = totalpv
}

function changeSelection(select) {
    var parent = select.parentElement.children
    console.log(parent)
    console.log(select.value)
    parent[1].value = 1 //quantity value
    parent[2].value = select.value //price value
    parent[3].value = 1 //pv value
    calculateTotalPrice()
    // $.ajax({url: $(location).attr('href'), type: "GET", ifModified:true, success: function(result, status, xhr){
    
    // }});
}