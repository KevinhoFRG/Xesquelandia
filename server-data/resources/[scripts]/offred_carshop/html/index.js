$(document).ready(function() {
    var audio = new Audio('click.ogg');

    $('a').on('click', function() {
        audio.play();
    });

    window.addEventListener('message', function(event) {
        if (event.data.action == 'open') {
            $('.md-macbook-pro').show();
        } else if (event.data.action == 'close') {
            $('.md-macbook-pro').hide();
        } else if (event.data.action == 'reload') {
		}
		
		function pushVehicle(){
            let idVeh = event.data.id;
            let nomeVeiculo = event.data.nomeVeiculo;
            let pesoVeiculo = event.data.pesoVeiculo;
            let estoqueVeiculo = event.data.estoqueVeiculo;
            let precoVeiculo = event.data.precoVeiculo;
            let imagemVeiculo = event.data.imagemVeiculo;
            if (nomeVeiculo != undefined) {
                for	(var i = 0 ; i < 1 ; i++) {
                    if (idVeh >= 500 ){
                        var eachMoto = $("#MockEachMoto").find('li').clone().removeClass('mock');
                        eachMoto.attr('vehicle-id',idVeh);
                        eachMoto.find('.vehicle-name').find('strong').html(capitalize(nomeVeiculo));
                        eachMoto.find('.car-img').attr('src',imagemVeiculo);
                        eachMoto.find('.vehicle-price').find('strong').html("$"+precoVeiculo);
                        eachMoto.find('.vehicle-stock').find('strong').html(estoqueVeiculo+" restantes");
                        eachMoto.find('.vehicle-carga').find('strong').html(pesoVeiculo+" KG");
                        
                        $('.bikes-frame').find('.vehicle-list').append(eachMoto);
                    } else {
                        var eachVeh = $("#MockEachCar").find('li').clone().removeClass('mock');
                        eachVeh.attr('vehicle-id',idVeh);
                        eachVeh.find('.vehicle-name').find('strong').html(capitalize(nomeVeiculo));
                        eachVeh.find('.car-img').attr('src',imagemVeiculo);
                        eachVeh.find('.vehicle-price').find('strong').html("$"+precoVeiculo);
                        eachVeh.find('.vehicle-stock').find('strong').html(estoqueVeiculo+" restantes");
                        eachVeh.find('.vehicle-carga').find('strong').html(pesoVeiculo+" KG");
                        
                        $('.car-frame').find('.vehicle-list').append(eachVeh);
                    }
                }
            }
		}
		pushVehicle();
		
	});
	// Close NUI - Escape key event
	$(document).keyup(function(e) {
		if (e.keyCode == 27) {
            refreshVehicles();
    		$('.cd-popup').removeClass('is-visible');
			$.post('http://offred_carshop/escape', JSON.stringify({}));
		}
	});
	
	function refreshVehicles() {
		$('.each-item').find('.car').click();
		$('.search-field').val('');
		$('.each-vehicle').not('.mock').remove();
	}

	$('body').on('click', '.each-vehicle', function(event) {
        audio.play();
		let valueButton = $(this).attr('vehicle-id');
		event.preventDefault();
		$('.cd-popup').addClass('is-visible');
		$('.cd-popup').attr('car-id',valueButton);
    });
	//fechar popup
	$('.cd-popup').on('click', function(event){
		if( $(event.target).is('.cd-popup-close') || $(event.target).is('.cd-popup') || $(event.target).is('.recusarAcao') ) {
			
			event.preventDefault();
			$(this).removeClass('is-visible');
			$('.cd-popup').removeAttr('car-id');
			
		} else if( $(event.target).is('.confirmarAcao') ) {
			audio.play();
			let valueButton = $('.cd-popup').attr('car-id');
			event.preventDefault();
			$(this).removeClass('is-visible');
			$.post('http://offred_carshop/comprarVeiculo', JSON.stringify({
			    carro : valueButton
			}));
            refreshVehicles();
			$.post('http://offred_carshop/escape', JSON.stringify({}));
		}
	});
	
	function capitalize(str) {
        strVal = '';
        str = str.split(' ');
        for (var chr = 0; chr < str.length; chr++) {
          strVal += str[chr].substring(0, 1).toUpperCase() + str[chr].substring(1, str[chr].length) + ' '
        }
        return strVal
    }
    //Menu click
    $('.each-item').on('click', function() {
        var frameId = $(this).data('frame-id');
        //hide all
        $('.each-frame').not('.hide').addClass('hide');

        //show selected
        $('.each-frame[data-frame-id="' + frameId + '"]').removeClass('hide');

        $('.each-item').removeClass('selected');
        $(this).addClass('selected');
    })

    //Search car
    $('.search-field').on('keyup', function() {
        if($(this).hasClass('car')) 
            var parentElement = $('.each-frame.car-frame');

        if($(this).hasClass('bike')) 
            var parentElement = $('.each-frame.bikes-frame');

        if($(this).hasClass('truck')) 
            var parentElement = $('.each-frame.trucks-frame');

        $(parentElement).find('.each-result.hide').removeClass('hide');
        $(parentElement).find('.not-found').remove();
        var query = $(this).val().toLowerCase();
        var results = $(parentElement).find('.each-result');

        results.each(function(i, el) {
            var carName = $(el).find('.vehicle-name').find('strong').html().trim().toLowerCase();
            if(carName.indexOf(query) == -1) {
                $(el).addClass('hide');
            }
        });

        if($('.each-result:visible').length == 0 ) {
            $(this).parent().append('<p class="not-found">Nenhum veículo encontrado</p>')
        }
    });
});



