ui_page('nui/index.html')

dependency "vrp"

client_scripts {
    "@vrp/lib/utils.lua",
    "client.lua"
}

server_scripts {
    "@vrp/lib/utils.lua",
    "server.lua"
}

files {
	'nui/index.html',
    'nui/style.css',
    'nui/font/Bariol_Regular.otf',
    'nui/font/Vision-Black.otf',
    'nui/font/Vision-Bold.otf',
    'nui/font/Vision-Heavy.otf',
    'nui/images/bg.png',
    'nui/images/circle.png',
    'nui/images/curve.png',
    'nui/images/fingerprint.png',
    'nui/images/fingerprint.jpg',
    'nui/images/graph.png',
    'nui/images/logo-big.png',
    'nui/images/logo-top.png'
}
