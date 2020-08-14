/*
  __  __           _            _                 _  __                         _____  
 |  \/  |         | |          | |               | |/ /                        |  __ \ 
 | \  / | __ _  __| | ___      | |__  _   _      | ' / __ _ ___ _ __   ___ _ __| |__) |
 | |\/| |/ _` |/ _` |/ _ \     | '_ \| | | |     |  < / _` / __| '_ \ / _ \ '__|  _  / 
 | |  | | (_| | (_| |  __/     | |_) | |_| |     | . \ (_| \__ \ |_) |  __/ |  | | \ \ 
 |_|  |_|\__,_|\__,_|\___|     |_.__/ \__, |     |_|\_\__,_|___/ .__/ \___|_|  |_|  \_\
                                       __/ |                   | |                     
                                      |___/                    |_|                     

  Author: Kasper Rasmussen
  Steam: https://steamcommunity.com/id/kasperrasmussen
*/

var itemName = null;
var itemAmount = null;
var itemIdname = null;
var dataType = null;
var elements = [];
var invStyle = null;
var sItem = null;

$(document).ready(function () {
  setTheme();
  $(".container").hide();
  $(".style-1").hide();
  $(".style-2").hide();
  window.addEventListener('message', function (event) {
    var item = event.data;
    if (item.show == true) {
		dataType = item.dataType;
		$(".inv_e_label").html("Mochila");
		
		invStyle = item.style
		
		if(item.style == 1){
			$(".style-1").hide();
			$(".style-2").show();
			$(".style-2 .inv_e_weight .label_1").html(item.p_i_weight + "/" + item.p_i_maxWeight + " kg");
			
			var tryIt = (item.p_i_weight/item.p_i_maxWeight)*100
			$(".style-2 .inv_e_weight .progress_1").css("width", tryIt+"%");
		}else{
			$(".style-2").hide();
			$(".style-1").show();
			$(".inv_e_weight .label_1").html(item.p_i_weight + "/" + item.p_i_maxWeight + " kg");
			$(".inv_d_weight .label_1").html(item.i_weight + "/" + item.i_maxWeight + " kg");
			
			var tryIt = (item.p_i_weight/item.p_i_maxWeight)*100
			var tryIt2 = (item.i_weight/item.i_maxWeight)*100
			$(".style-1 .inv_e_weight .progress_1").css("width", tryIt+"%");
			$(".style-1 .inv_d_weight .progress_1").css("width", tryIt2+"%");
		}
		
		
		if(dataType[2] >= 3){
			$("#sendme").html("COLOCAR");
			$("#sendme2").html("RETIRAR");
			$(".inv_d_label").html("Bau");
			$(".inv_d_weight_l").html("Bau");
		}else if(dataType[2] == 2){
			$("#sendme").html("COLOCAR");
			$("#sendme2").html("RETIRAR");
			$(".inv_d_label .label_1").html("Porta Malas");
			$(".inv_d_weight_l").html("Porta Malas");
		}else{
			$("#sendme").html("Enviar");
		}
      open();
    }
    if (item.show == false) {
      close();
    }
	
	if (item.pinventory) {
      $(".inv_esquerda_items").empty();
      item.pinventory.forEach(element => {
        $(".inv_esquerda_items").append(`
          <div class="inner-pitems" onclick="selectItem(this)" data-name="${element.name}" data-amount="${element.amount}" data-idname="${element.idname}" data-itemWeight="${element.item_peso}" style="background-image: url('assets/icons/${element.icon}'); background-size: 80px 80px;">
            <p class="amount">${element.amount} <span class="peso">${element.item_peso}Kg</span></p>
            
            <p class="name">${element.name}</p>
          </div>
        `);
      });
    }
	
    if (item.inventory && dataType[2] > 1) {
		$(".inv_direita_items").empty();
		item.inventory.forEach(element => {
			$(".inv_direita_items").append(`
			<div class="inner-items" onclick="selectItem(this)" data-name="${element.name}" data-amount="${element.amount}" data-idname="${element.idname}" data-itemWeight="${element.item_peso}" style="background-image: url('assets/icons/${element.icon}'); background-size: 80px 80px;">
			<p class="amount">${element.amount} <span class="peso">${element.item_peso}Kg</span></p>

			<p class="name">${element.name}</p>
			</div>
			`);
		});
    }
	
	 if (item.inventory && dataType[2] == 1) {
		$(".eq_items").empty();
		item.inventory.forEach(element => {
			$(".eq_items").append(`
			<div class="inner-items" data-name="${element.name}" data-amount="${element.amount}" data-idname="${element.idname}" data-itemWeight="${element.item_peso}" style="background-image: url('assets/icons/${element.icon}'); background-size: 80px 80px;">
			</div>
			`);
		});
    }
	
	
    if (item.notification == true) {
      Swal.fire(
        item.title,
        item.message,
        item.type
      )
    }
	
  });
  document.onkeyup = function (data) {
    if (data.which == 27) {
      $.post('http://vrp_inventario/close', JSON.stringify({}));
    }
  };
  $(".btnClose").click(function () {
    $.post('http://vrp_inventario/close', JSON.stringify({}));
  });
});

function open() {
  $(".container").fadeIn();
  clearSelectedItem();
}
function close() {
  $(".container").fadeOut();
  clearSelectedItem();
}

function selectItem(element) {
	clearSelectedItem();
	itemName = element.dataset.name;
	itemAmount = element.dataset.amount;
	itemIdname = element.dataset.idname;
	$(element).css("background-color", "rgba(0,0,0,0.3)");
	$(element).css("background-color", "#000000");
	$(element).addClass("pulse");
	sItem = element;
}

function putItem() {
	let amount = 0
	if(invStyle == 1){
		amount = $("#amount2").val();
	}else if(invStyle >= 2){
		amount = $("#amount1").val();
	}
	if (amount == "0" || amount == "" || amount == null) {
	Swal.fire(
		'Atenção',
		'Insira uma quantidade válida!',
		'warning'
	);
	} else if (parseInt(amount) > parseInt(itemAmount)) {
	Swal.fire(
		'Atenção',
		'Você não possui a quantidade selecionada em seu inventário.',
		'warning'
	);
	} else {
		if(itemIdname) {
			$.post('http://vrp_inventario/putItem', JSON.stringify({
				idname: itemIdname,
				amount: amount,
				dataType: dataType,
				invStyle: invStyle
			})).then(() => {
				clearSelectedItem();
			});
		} else {
			Swal.fire(
				'Atenção',
				'Selecione um item',
				'warning'
			)
		}
	}
}

function takeItem() {
	let amount = 0
	if(invStyle == 1){
		amount = $("#amount2").val();
	}else if(invStyle >= 2){
		amount = $("#amount1").val();
	}
	if (amount == "0" || amount == "" || amount == null) {
	Swal.fire(
		'Atenção',
		'Insira uma quantidade válida!',
		'warning'
	);
	} else if (parseInt(amount) > parseInt(itemAmount)) {
	Swal.fire(
		'Atenção',
		'Você não possui a quantidade selecionada em seu inventário.',
		'warning'
	);
	} else {
		if(itemIdname) {
			$.post('http://vrp_inventario/takeItem', JSON.stringify({
				idname: itemIdname,
				amount: amount,
				dataType: dataType,
				invStyle: invStyle
			})).then(() => {
				clearSelectedItem();
			});
		} else {
			Swal.fire(
				'Atenção',
				'Selecione um item',
				'warning'
			)
		}
	}
}

function storeAll(){
	$.post('http://vrp_inventario/storeAll', JSON.stringify({}))
}

function useItem() {
	let amount = 0
	if(invStyle == 1){
		amount = $("#amount2").val();
	}else if(invStyle >= 2){
		amount = $("#amount1").val();
	}
  if (amount == "0" || amount == "" || amount == null) {
    Swal.fire(
      
      'Atenção',
      'Insira uma quantidade válida!',
      'warning'
    )
  } else if (parseInt(amount) > parseInt(itemAmount)) {
    Swal.fire(
      'Atenção',
      'Você não possui a quantidade selecionada em seu inventário.',
      'warning'
    )
  } else {
    if(itemIdname) {
      $.post('http://vrp_inventario/useItem', JSON.stringify({
        idname: itemIdname,
        amount: amount,
		dataType: dataType
      }))
      .then(() => {
        clearSelectedItem();
      });
    } else {
      Swal.fire(
        'Atenção',
        'Selecione um item',
        'warning'
      )
    }
  }
}

function dropItem() {
	let amount = 0
	if(invStyle == 1){
		amount = $("#amount2").val();
	}else if(invStyle >= 2){
		amount = $("#amount1").val();
	}
  if (amount == "0" || amount == "" || amount == null) {
    Swal.fire(
      'Atenção',
      'Insira uma quantidade válida.',
      'warning'
    )
  } else if (parseInt(amount) > parseInt(itemAmount)) {
    Swal.fire(
      'Atenção',
      'Você não possui a quantidade selecionada em seu inventário.',
      'warning'
    )
  } else {
    if(itemIdname !== null) {
      $.post('http://vrp_inventario/dropItem', JSON.stringify({
        idname: itemIdname,
        amount: amount,
		dataType: dataType
      }))
      .then(() => {
        clearSelectedItem();
      });
    } else {
      Swal.fire(
        'Atenção',
        'Selecione um item',
        'warning'
      )
    }
  }
}

function giveItem() {
	let amount = 0
	if(invStyle == 1){
		amount = $("#amount2").val();
	}else if(invStyle >= 2){
		amount = $("#amount1").val();
	}
  if (amount == "0" || amount == "" || amount == null) {
    Swal.fire(
      'Atenção',
      'Insira uma quantidade válida.',
      'warning'
    )
  } else if (parseInt(amount) > parseInt(itemAmount)) {
    Swal.fire(
      'Atenção',
      'Você não possui a quantidade selecionada em seu inventário.',
      'warning'
    )
  } else {
    if(itemIdname) {
      $.post('http://vrp_inventario/giveItem', JSON.stringify({
        idname: itemIdname,
        amount: amount,
		dataType: dataType
      }))
      .then(() => {
        clearSelectedItem();
      });
    } else {
      Swal.fire(
        'Atenção',
        'Selecione um item',
        'warning'
      )
    }
  }
}

function setTheme() {
  if(configs.theme.primary_color && configs.theme.secondary_color) {
    let primary_color = `--primary-color: ${configs.theme.primary_color}; `;
    let secondary_color = `--secondary-color: ${configs.theme.secondary_color}; `;
    $(":root").attr("style", primary_color + secondary_color);
  }
}

function clearSelectedItem() {
  itemName = null;
  itemAmount = null;
  itemIdname = null;
  $(sItem).css("background-color", "rgba(0,0,0,.2)");
  $(sItem).removeClass("pulse");
}