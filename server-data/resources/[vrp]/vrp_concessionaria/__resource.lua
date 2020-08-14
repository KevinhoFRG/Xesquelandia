description "Concessionaria NoLife RP"

client_script {
    "@vrp/lib/utils.lua",
    "client.lua"
}

server_script {
    "@vrp/lib/utils.lua",
    "server.lua"
}

ui_page "HTML/ui.html"

files {
    "HTML/ui.html",
    "HTML/ui.css",
    "HTML/ui.js"
}