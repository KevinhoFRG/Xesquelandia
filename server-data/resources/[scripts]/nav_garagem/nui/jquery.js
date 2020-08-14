$(document).ready(function(){
	let actionContainer = $("#actionmenu");

	window.addEventListener('message',function(event){
		let item = event.data;
		switch(item.action){
			case 'showMenu':
				updateGarages();
				actionContainer.fadeIn(1000);
			break;

			case 'hideMenu':
				actionContainer.fadeOut(800);
			break;

			case 'updateGarages':
				updateGarages();
			break;
			
			case 'updateGarages2':
				updateGarages2();
			break;
		}
	});

	document.onkeyup = function(data){
		if (data.which == 27){
			$.post('http://nav_garagem/NUIFocusOff', JSON.stringify({}));
		}
	};
});

const updateGarages = () => {
	$('#garagem').html('');
	$.post('http://nav_garagem/myVehicles',JSON.stringify({}),(data) => {
		jQuery.each(data, function(key, value) {
			$('#garagem').append(`
				<div class="item" data-item-name="${value.vehicle}">
					<div class="item-text">
						<div class="item-left"><b>Nome:</b></div>
						<div class="item-right">${value.vehicle.charAt(0).toUpperCase()+value.vehicle.substring(1, value.vehicle.length)}</div>
					</div>
					<div class="item-text">
						<div class="item-left"><b>Motor:</b></div>
						<div class="item-right">${Math.floor((100 * (value.engine/1000)))}%</div>
					</div>
					<div class="item-text">
						<div class="item-left"><b>Chassi:</b></div>
						<div class="item-right">${Math.floor((100 * (value.body/1000)))}%</div>
					</div>
					<div class="item-text">
						<div class="item-left"><b>Gasolina:</b></div>
						<div class="item-right">${value.fuel}%</div>
					</div>
					<div class="item-text" style="border: 0;">
						<div class="item-left"><b>Liberação:</b></div>
						<div class="item-right">${value.detido}</div>
					</div>
				</div>
			`);			
		});		
	});
}

const updateGarages2 = () => {
	$('#garagem').html('');
	$.post('http://nav_garagem/myVehicles',JSON.stringify({}),(data) => {
		jQuery.each(data, function(key, value) {
			$('#garagem').append(`
				<div class="item" data-item-name="${value.vehicle}">
					<div class="item-text">
						<div class="item-left"><b>Nome:</b></div>
						<div class="item-right">${value.vehicle.charAt(0).toUpperCase()+value.vehicle.substring(1, value.vehicle.length)}</div>
					</div>
					<div class="item-text">
						<div class="item-left"><b>Valor:</b></div>
						<div class="item-right">${Math.floor((100 * (value.preco/1000)))}</div>
					</div>
				</div>
			`);			
		});		
	});
}

$(document).on('click','.item',function(){
	let $el = $(this);
	let isActive = $el.hasClass('active');
	$('.item').removeClass('active');
	if(!isActive) $el.addClass('active');
});

$(document).on('click','.item2',function(){
	let $el = $(this);
	let isActive = $el.hasClass('active');
	if(isActive){
		$.post('http://nav_garagem/spawnVehicles2',JSON.stringify({name: $el.attr('data-item-name'), preco: $el.attr('data-item-price')}));
	}else{
		$('.item').removeClass('active');
		if(!isActive) $el.addClass('active');
		$.post('http://nav_garagem/notifyRent',JSON.stringify({name: $el.attr('data-item-name'), preco: $el.attr('data-item-price')}));
	}
});

$(document).on('click','.alugar',function(){
	let $el = $('.item.active');
	if($el) {
		$.post('http://nav_garagem/rentVehicles',JSON.stringify({name: $el.attr('data-item-name')}),(data) => {
			$('#garagem').html('');
			jQuery.each(data, function(key, value) {
				$('#garagem').append(`
					<div class="item item2" data-item-name="${value.vehicle}" data-item-price="${value.preco}">
						<div class="item-text">
							<div class="item-left"><b>Nome:</b></div>
							<div class="item-right">${value.vehicle.charAt(0).toUpperCase()+value.vehicle.substring(1, value.vehicle.length)}</div>
						</div>
						<div class="item-text">
							<div class="item-left"><b>Valor:</b></div>
							<div class="item-right">$ ${Math.floor((100 * (value.preco/1000)))}0</div>
						</div>
					</div>
				`);			
			});	
		});
	}
});

$(document).on('click','.retirar',function(){
	let $el = $('.item.active');
	if($el) {
		$.post('http://nav_garagem/spawnVehicles',JSON.stringify({name: $el.attr('data-item-name')}));
	}
});

$(document).on('click','.guardar',function(){
	let $el = $('.item.active');
	if($el) {
		$.post('http://nav_garagem/deleteVehicles',JSON.stringify({name: $el.attr('data-item-name')}));
	}
});