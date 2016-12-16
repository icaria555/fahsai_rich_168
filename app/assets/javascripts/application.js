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
        elem.textContent = "0"
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
    var purchaser = document.getElementById('order_purchaser_id')
    console.log(parent)
    console.log(select.value)
    parent[1].value = 1 //quantity value
    parent[2].value = select.value //price value
    parent[3].value = 1 //pv value
    calculateTotalPrice()
     $.ajax({url: $(location).attr('href'), type: "GET", dataType: 'xml', ifModified:true, success: function(result, status, xhr){
    
     }});
}