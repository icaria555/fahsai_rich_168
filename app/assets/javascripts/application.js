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
var changeCount = 1

function addRowOrder() {
    var div = document.createElement('div');
    div.className = 'field';
    
    var productelement = document.getElementById('productlist').lastElementChild
    var generate_num = (parseInt(productelement.getAttribute("id").split("_")[1]) + 1).toString()
    div.id = 'row_' + generate_num
    
    var select = productelement.firstElementChild.cloneNode(true)
    select.setAttribute("id", "list_product" + generate_num + "_id")
    select.setAttribute("name", "list[product" + generate_num + "[id]]")
    div.appendChild(select)
    
    var elem_name = ['quantity', 'price', 'pv']
    elem_name.forEach(function(name) {
        var elem = document.createElement('input')
        elem.setAttribute("id", "list_product" + generate_num + "_" + name)
        elem.setAttribute("name", "list[product" + generate_num + "[" + name + "]]")
        elem.setAttribute("type", "number");
        elem.setAttribute("value", "0");
        if(name == 'quantity'){
            console.log("change")
            elem.setAttribute("onchange", "javascript:changeQuantity(this)")
            elem.setAttribute("onfocus", "javascript:storePreviousValue(this)")
            
        }
        div.appendChild(elem)
    });
    
    div.innerHTML = div.innerHTML + '<button onclick="deleteRow(' + generate_num + ')">delete</button>'
    document.getElementById('productlist').appendChild(div);
}

function deleteRow(row_num) {
    var id_name = "row_" + row_num
    var delete_target = document.getElementById(id_name);
    var parentNode = delete_target.parentNode
    parentNode.removeChild(delete_target)
    //console.log(row_num)
    calculateTotalPrice()
}

function calculateTotalPrice() {
    var productelement = document.getElementById('productlist').children
    var total_element = document.getElementById('order_total_price')
    var totalprice = 0
    var totalpv = 0
    
    for (var i = 0; i < productelement.length; i++) {
        var rowelement = productelement[i].children
        console.log( isNaN(rowelement[2].value) + " " + rowelement[2].value)
        if( !isNaN(rowelement[2].value) & !isNaN(rowelement[3].value)) {
            totalprice += parseInt(rowelement[2].value) //rowelement[2] == price on text field box
            totalpv += parseInt(rowelement[3].value)
        }
    }
    //console.log("total price" + totalprice + "pv" + totalpv)
    document.getElementById('order_total_price').value = totalprice
    document.getElementById('order_total_pv').value = totalpv
}

function storePreviousValue(element) {
    changeCount = element.value
}

function changeQuantity(element) {
    var parent = element.parentElement.children
    var priceElem = parent[2] 
    var pvElem = parent[3]
    
    var price = priceElem.value
    var pv = pvElem.value
    var count = element.value
    
    var changePrice = 0
    var changePv = 0

    var realPrice = price/changeCount 
    var realPv = pv/changeCount
    changePrice = realPrice * count
    changePv = realPv * count
    priceElem.value = changePrice
    pvElem.value = changePv
    changeCount = count
    calculateTotalPrice()
}

function changeQuantity2(element) {
    var parent = element.parentElement
    var child = parent.children
    var dat = { product_id: child[0].value, quantity: child[1].value, element_name: parent.id }
    
    $.ajax({url: '/checkquantity', data: dat, type: "POST", dataType: 'JSON', ifModified:true, success: function(result, status, xhr){
        var changedPrice = result["price"]
        var pv = result["pv"]
        console.log("s " + changedPrice + " " + pv + "e")
        changeElement([changedPrice, pv], result["element_name"])
    }});
}

function changeSelection(select) {
    var parent = select.parentElement.id
    var purchaser = document.getElementById('order_purchaser_id')
    
    console.log(parent)
    //console.log(select.value)
    var dat = { product_id: select.value, purchaser_id: purchaser.value, element_name: parent }
    $.ajax({url: '/pricetagselect', data: dat, type: "POST", dataType: 'JSON', ifModified:true, success: function(result, status, xhr){
        var changedPrice = result["price"]
        var pv = result["pv"]
        console.log("s " + changedPrice + " " + pv + "e")
        changeElement([changedPrice, pv], result["element_name"])
    }});
}

function changeElement(data, name) {
    var element = document.getElementById(name).children
    element[1].value = 1
    element[2].value = data[0]
    element[3].value = data[1]
    calculateTotalPrice()
}

function changeTextfield(purchaser_element) {
    var row_element = document.getElementById('productlist').children
    var purchaser = purchaser_element
    var length = row_element.length
    var product_id_list = []
    
    for (var i = 0; i < length; i++) {
        var product_id = row_element[i].children[0].value
        if(product_id != 0) product_id_list.push(product_id);
    }
    console.log("list = " + product_id_list.length)
    if(product_id_list.length) {
        var dat = { purchaser_id: purchaser.value, product_list: product_id_list }
        console.log("test")
        $.ajax({url: '/pricetagfield', data: dat, type: "POST", dataType: 'JSON', ifModified:true, success: function(result, status, xhr){
            console.log(result)
            var row_element = document.getElementById('productlist').children
            for (var i = 0; i < length; i++) {
                
            }
                
        }});
    }
}

function changeProductField(data) {
    var row_element = document.getElementById('productlist').children
    var purchaser = purchaser_element
    var length = row_element.length
    
    product_id_list = data[1]
    
    for (var i = 0; i < length; i++) {
    }
}

