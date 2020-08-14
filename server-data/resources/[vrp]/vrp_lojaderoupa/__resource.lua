dependencies {
    'vrp'
}

ui_page 'html/ui.html'

files {
    'html/ui.html',
    'html/style.css',
    'html/script.js',
    'html/images/bone.svg',
    'html/images/brinco.svg',
    'html/images/cabelo.svg',
    'html/images/calca.svg',
    'html/images/camisa.svg',
    'html/images/calor.svg',
    'html/images/gravata.svg',
    'html/images/jaqueta.svg',
    'html/images/mao.svg',
    'html/images/mascara.svg',
    'html/images/oculos.svg',
    'html/images/pele.svg',
    'html/images/relogio.svg',
    'html/images/rosto.svg',
    'html/images/roupa.svg',
    'html/images/sapato.svg',
    'html/images/tinta-cabelo.svg',
    'html/font/gta2.ttf',
    'html/font/gta-fonte.ttf',

}

client_script {
    "@vrp/lib/utils.lua",
    "script/client.lua"
}
server_scripts{
    "@vrp/lib/utils.lua",
    "script/server.lua"
}
