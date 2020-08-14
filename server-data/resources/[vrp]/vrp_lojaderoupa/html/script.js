$(document).ready(function () {
    let change = {}

    function openLoja() {
        $(".loja-de-roupa").css("display", "block")
    }

    function closeLoja() {
        $(".loja-de-roupa").css("display", "none")
        for (let key in change) {
            if (!change[key] == 0) {
                change[key] = 0
            }
        }
        update_valor()

    }

    document.onkeydown = function (data) {
        console.log(data)
        if (data.keyCode == 27) {
            $.post('http://vrp_lojaderoupa/close', JSON.stringify({}))

        }
    }

    $(".fa-sign-out-alt").click(function () {
        $.post('http://vrp_lojaderoupa/close', JSON.stringify({}))
    })

    $(".btn2").click(function () {
        let roupa = $(this).attr('id')
        $.post('http://vrp_lojaderoupa/next_custom', JSON.stringify({type: roupa}));
        console.log("MACACO INICIo")
        if (!change[roupa]) {
            change[roupa] = 1;
        } else {
            change[roupa] += 1;
        }
        update_valor()
        console.log(change)
    });


    $(".btn1").click(function () {
        let roupa = $(this).attr('id')
        $.post('http://vrp_lojaderoupa/anterior_custom', JSON.stringify({type: $(this).attr('id')}));
        if (!change[roupa]) {
            change[roupa] = -1;
        } else {
            change[roupa] -= 1;
        }
        update_valor()
        console.log(change)
    })


    $(".btncor").click(function () {
        let roupa = $(this).attr('id')
        $.post('http://vrp_lojaderoupa/cor', JSON.stringify({type: $(this).attr('id')}));
    })


    function update_valor() {
        const formatter = new Intl.NumberFormat('pt-BR', {
            style: 'currency',
            currency: 'BRL',
            minimumFractionDigits: 2
        })

        let total = 0
        for (let key in change) {
            if (!change[key] == 0) {
                total += 40
            }
        }
        document.getElementsByClassName("total")[0].innerHTML = formatter.format(total)

    }

    $(".comprar").click(function () {
        let total = 0
        for (let key in change) {
            if (!change[key] == 0) {
                total += 40
                change[key] = 0
            }
        }
        $.post('http://vrp_lojaderoupa/comprar',JSON.stringify({preco: total}))
        update_valor()

    })


    window.addEventListener('message', function (event) {
        console.log(event)
        var item = event.data;
        if (item.openLojaRoupa == true) {
            openLoja()
        } else if (item.openLojaRoupa == false) {
            closeLoja()
        }
    })
});

