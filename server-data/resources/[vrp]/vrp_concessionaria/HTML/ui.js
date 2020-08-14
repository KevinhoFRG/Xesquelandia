function CloseShop() {
  $(".container-item").html('');
	$("#carshop").hide();
    $.post('http://vrp_concessionaria/fechar', JSON.stringify({}));
}

$(document).ready(function(){

    $("#fechar").click(function(){
      $.post('http://vrp_concessionaria/fechar', JSON.stringify({}));2
      $(".container-item").html('');
      $("#carshop").hide();
    });

    $(".container-item").on('click', '#comprar', function () {
        $.post('http://vrp_concessionaria/comprar', JSON.stringify({id: $(this).data('id')}));
        $(".container-item").html('');
        $("#carshop").hide();
    });

    $("#close").click(function() {
        CloseShop()
    });

      // Close NUI - Escape key event
    $(document).keyup(function(e) {
      if (e.keyCode == 27) {
        CloseShop()
      }
    });

    window.addEventListener('message', function(event) {
        let data = event.data;

        function addComma(num) {
            return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1.')
        }

        function verificarQtd(num) {
            if (num == 0) {
                return "Sem estoque!"
            } else {
                return num
            }
        }

        if (data.show) {
            let veiculos_data = data.veiculos
            let table = []
            $("#carshop").show();
           for (let i = 0; i < 50; i++) {
                table.push(veiculos_data[i])
                }
                for (let item in veiculos_data) {
                $(".container-item").append(`
                <div class="car-card alt">
                <div class="meta">
                  <div class="photo" style="background-image: url('` + veiculos_data[item].img + `')"></div>
                  <ul class="details">
                    <li>Quantidade: ` + veiculos_data[item].quantidade + `</li>
                    <li class="tags">
                      <ul>
                        <li><a>`+ addComma(veiculos_data[item].valor) +`</a></li>
                      </ul>
                    </li>
                  </ul>
                </div>
                <div class="description">
                  <h1>` + veiculos_data[item].nome + `</h1>
                  <h2>Carro sendo vendido pela concessionária de FiveM Brasil</h2>
                  <p>` + veiculos_data[item].descricao + `</p>
                  <p class="read-more">
                    <a id="comprar" data-id="` + item + `" onclick="animation()">Comprar</a>
                  </p>
                </div>
              </div>  
          `);
        }
    }}
  )}
);


