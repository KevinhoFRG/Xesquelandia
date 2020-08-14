local discord_webhook = "https://discordapp.com/api/webhooks/687862400497614852/cJBdOSctJmt46DxyXzvSWNuIhbsu8EF3YnIVRoAgN6XKmYquXA2pR8NvW4D_GTJCyS5Q"

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRP._prepare("vRP/get_vehiclesList","SELECT * FROM concessionaria WHERE id = @id")
vRP._prepare("vRP/remove_stock","UPDATE concessionaria SET estoquecarro = estoquecarro - 1 WHERE id = @id")

local carros = {
	{id = 1,   nome = "ds4", 			precocarro = 73000,		pesocarro = 50, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639642487446700040/unknown.png"},
	{id = 2,   nome = "punto", 		precocarro = 70000,	 	pesocarro = 50, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639642582078455818/unknown.png"},
	{id = 3,   nome = "f150", 		precocarro = 175000,		pesocarro = 85, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639642611656818718/unknown.png"},
	{id = 4,  nome = "fusion", 			precocarro = 100000,  	pesocarro = 50, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639642631185367042/unknown.png"},	
    {id = 5, nome = "fordka",          precocarro = 45000, 	pesocarro = 50, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639689524032831488/unknown.png"},
    {id = 6,  nome = "vwgolf", 		precocarro = 60000,  	pesocarro = 50, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639642690375385098/unknown.png"},
    {id = 7, nome = "civic", precocarro = 55000, 	pesocarro = 50, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639642713662423050/unknown.png"},
    {id = 8, nome = "eletran17", precocarro = 110000, 	pesocarro = 50, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639642737913757726/unknown.png"},
    {id = 9, nome = "sonata18", precocarro = 120000, 	pesocarro = 50, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639642760785166336/unknown.png"},
    {id = 10,   nome = "veloster", 			precocarro = 85000,		pesocarro = 50, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639642794289397771/unknown.png"},
    {id = 11,  nome = "monza", 		precocarro = 13000,		pesocarro = 40, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639642814744887297/unknown.png"},
    {id = 12, nome = "p207", precocarro = 23000, 	pesocarro = 40, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639642846181457920/unknown.png"},
	{id = 13, nome = "vwpolo", precocarro = 90000, 	pesocarro = 50, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639642872626282506/unknown.png"},
	{id = 14,  nome = "evoq", 		precocarro = 220000,  	pesocarro = 50, imagemcarro = "htttps://cdn.discordapp.com/attachments/639489848297783296/639642895187443712/unknown.png"},
	{id = 15,  nome = "santafe", 		precocarro = 140000, 	pesocarro = 50, imagemcarro = "htps://cdn.discordapp.com/attachments/639489848297783296/639642915043278848/unknown.png"},
	{id = 16,  nome = "celta", 		precocarro = 17000, 	pesocarro = 40, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639607841493352448/unknown.png"},
	{id = 17,  nome = "amarok", 		precocarro = 185000, 	pesocarro = 80, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639687536201170944/unknown.png"},
	{id = 18,  nome = "civic2016", 		precocarro = 120000, 	pesocarro = 50, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639687580551610368/unknown.png"},
	{id = 19,  nome = "fiat", 		precocarro = 10000, 	pesocarro = 40, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639687614311563264/unknown.png"},
	{id = 20,  nome = "jetta2017", 		precocarro = 200000, 	pesocarro = 50, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639687693953138688/unknown.png"},
	{id = 21,  nome = "l200civil", 		precocarro = 180000, 	pesocarro = 80, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639687731831898112/unknown.png"},
	{id = 22,  nome = "saveiro", 		precocarro = 70000, 	pesocarro = 60, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639687759828615198/unknown.png"},
	{id = 23,  nome = "upzinho", 		precocarro = 20000, 	pesocarro = 30, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639687980017254400/unknown.png"},
	{id = 24,  nome = "voyage", 		precocarro = 40000, 	pesocarro = 50, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639688756382793728/unknown.png"},
	{id = 25,  nome = "golg7", 		precocarro = 85000, 	pesocarro = 50, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639607867506425857/unknown.png"},
	{id = 26,  nome = "fiattoro", 		precocarro = 80000, 	pesocarro = 70, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639607817866706994/unknown.png"},
	{id = 27,  nome = "palio", 		precocarro = 20000, 	pesocarro = 40, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639607791216230400/unknown.png"},
	{id = 28,  nome = "fiatuno", 		precocarro = 15000, 	pesocarro = 40, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639607896090345474/unknown.png"},
	{id = 29,  nome = "fiatstilo", 		precocarro = 80000, 	pesocarro = 50, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639688910695301140/unknown.png"},
    {id = 30,   nome = "surfer", 		precocarro = 50000,	 	pesocarro = 80, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/a/ac/Surfer-GTAV-front.png/revision/latest/scale-to-width-down/350?cb=20160409182213"},
    {id = 31,   nome = "panto", 			precocarro = 5000,		pesocarro = 20, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/a/ad/Panto-GTAV-front.png/revision/latest/scale-to-width-down/350?cb=20160406180025"},
    {id = 32,   nome = "blista", 		precocarro = 60000,		pesocarro = 40, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/c/c0/Blista-GTAV-front.png/revision/latest/scale-to-width-down/350?cb=20160409171328"},
    {id = 33,  nome = "sultan", 		precocarro = 150000,	pesocarro = 50, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/b/bb/Sultan-GTAV-front.png/revision/latest/scale-to-width-down/350?cb=20180331183641"},
    {id = 34,  nome = "bison", 			precocarro = 200000, 	pesocarro = 70, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/6/69/Bison-GTAV-front.png/revision/latest/scale-to-width-down/700?cb=20160406172803"},
	{id = 35,  nome = "rhapsody", 		precocarro = 7000,   	pesocarro = 30, imagemcarro = "https://wiki.rage.mp/images/e/e2/Rhapsody.png"},
	{id = 36,  nome = "prairie", 		precocarro = 10000,  	pesocarro = 25, imagemcarro = "https://wiki.rage.mp/images/thumb/3/3d/Prairie.png/800px-Prairie.png"},
	{id = 37,  nome = "felon", 			precocarro = 70000,  	pesocarro = 50, imagemcarro = "https://wiki.rage.mp/images/thumb/0/04/Felon.png/800px-Felon.png"},
	{id = 38,  nome = "jackal", 		precocarro = 60000,  	pesocarro = 30, imagemcarro = "https://wiki.rage.mp/images/thumb/7/70/Jackal.png/800px-Jackal.png"},
	{id = 39,  nome = "oracle", 		precocarro = 60000,  	pesocarro = 50, imagemcarro = "https://wiki.rage.mp/images/thumb/1/17/Oracle.png/800px-Oracle.png"},
	{id = 40, nome = "brioso", precocarro = 30000, 	pesocarro = 30, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/8/80/BriosoRA-GTAO-front.png/revision/latest/scale-to-width-down/700?cb=20160712123349"},
	-- MOTOS
	{id = 500, nome = "biz25", 		precocarro = 10000, 		pesocarro = 15, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639697375211814912/unknown.png"},
	{id = 501, nome = "150", 		precocarro = 13000, 		pesocarro = 15, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639697428303446026/unknown.png"},
	{id = 502, nome = "bros60", 		precocarro = 25000, 		pesocarro = 15, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639697447962017793/unknown.png"},
	{id = 503, nome = "xt66", 		precocarro = 40000, 		pesocarro = 15, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639697476005265408/unknown.png"},
	{id = 504, nome = "450crf", 		precocarro = 100000, 		pesocarro = 15, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639697501645176862/unknown.png"},
	{id = 505, nome = "xj", 		precocarro = 240000, 		pesocarro = 15, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639697542388383764/unknown.png"},
	{id = 506, nome = "hornet", 		precocarro = 260000, 		pesocarro = 15, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639697613092028416/unknown.png"},
	{id = 507, nome = "dm1200", 		precocarro = 300000, 		pesocarro = 15, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639697653411872778/unknown.png"},
	{id = 508, nome = "z1000", 		precocarro = 290000, 		pesocarro = 15, imagemcarro = "https://cdn.discordapp.com/attachments/639489848297783296/639697723825848320/unknown.png"},
    {id = 510, nome = "faggio2", 		precocarro = 5000, 		pesocarro = 15, imagemcarro = "https://wiki.rage.mp/images/2/25/Faggio2.png"},
	{id = 511, nome = "bati", 			precocarro = 300000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/d/d9/Bati801-GTAV-front.png/revision/latest/scale-to-width-down/350?cb=20160127211358"},
	{id = 512, nome = "hakuchou",		precocarro = 310000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/a/ab/Hakuchou-GTAV-front.png/revision/latest/scale-to-width-down/350?cb=20160302173513"},
	{id = 513, nome = "manchez",		precocarro = 290000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/c/c6/Manchez-GTAO-front.png/revision/latest/scale-to-width-down/700?cb=20161014165403"},
	{id = 514, nome = "sanchez2",		precocarro = 150000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/9/93/Sanchez2-GTAV-front.png/revision/latest/scale-to-width-down/350?cb=20160222221404"},
	{id = 515, nome = "double", 		precocarro = 300000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/8/8c/DoubleT-GTAV-front.png/revision/latest/scale-to-width-down/350?cb=20160126212153"},
	{id = 516, nome = "diablous2", 		precocarro = 380000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/1/11/DiabolusCustom-GTAO-front.png/revision/latest/scale-to-width-down/350?cb=20161213202213"},
	{id = 517, nome = "zombiea", 		precocarro = 230000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/a/af/ZombieBobber-GTAO-front.png/revision/latest/scale-to-width-down/350?cb=20161004181721"},
	{id = 518, nome = "akuma", 		precocarro = 420000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/9/9a/Akuma-GTAV-front.png/revision/latest/scale-to-width-down/700?cb=20160127214020"},
	{id = 519, nome = "bf400", 		precocarro = 260000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/0/00/BF400-GTAO-front.png/revision/latest/scale-to-width-down/700?cb=20161014164436"},
	{id = 520, nome = "carbonrs", 		precocarro = 300000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/2/2d/CarbonRS-GTAV-front.png/revision/latest/scale-to-width-down/700?cb=20160130214329"},
	{id = 521, nome = "daemon2", 		precocarro = 200000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/6/6b/Daemon2-GTAO-front.png/revision/latest/scale-to-width-down/700?cb=20161014164637"},
	{id = 522, nome = "hexer", 		precocarro = 180000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/6/64/Hexer-GTAV-front.png/revision/latest/scale-to-width-down/700?cb=20160211212015"},
	{id = 523, nome = "nightblade", 		precocarro = 340000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/6/6b/Nightblade-GTAO-front.png/revision/latest/scale-to-width-down/700?cb=20161014165516"},
	{id = 524, nome = "sanchez", 		precocarro = 150000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/9/93/Sanchez2-GTAV-front.png/revision/latest/scale-to-width-down/700?cb=20160222221404"},
	{id = 525, nome = "vader", 		precocarro = 280000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/9/9b/Vader-GTAV-front.png/revision/latest/scale-to-width-down/700?cb=20160130222000"},
	{id = 526, nome = "vortex", 		precocarro = 300000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/7/71/Vortex-GTAO-front.png/revision/latest/scale-to-width-down/700?cb=20161004181943"},
	{id = 527, nome = "wolfsbane", 		precocarro = 230000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/f/ff/Wolfsbane-GTAO-front.png/revision/latest/scale-to-width-down/700?cb=20161014165611"},
	{id = 528, nome = "zombieb", 		precocarro = 235000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/7/70/ZombieChopper-GTAO-front.png/revision/latest/scale-to-width-down/700?cb=20161004181804"},
	{id = 539, nome = "blazer", 		precocarro = 200000, 	pesocarro = 15, imagemcarro = "https://vignette.wikia.nocookie.net/gtawiki/images/3/35/Blazer-GTAV-front.png/revision/latest/scale-to-width-down/700?cb=20161018175627"},
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('offred_carshop:abrirPainel')
AddEventHandler('offred_carshop:abrirPainel',function()
	local src = source
	local user_id = vRP.getUserId(src)
    for _,rb in pairs(carros) do
		local rows = vRP.query("vRP/get_vehiclesList", {id = rb.id})
		if rows[1].id == rb.id then
			if rows[1].estoquecarro ~= 0 then
				TriggerClientEvent('offred_carshop:abrirPainel', src, rb.id, rb.nome, rb.pesocarro, rows[1].estoquecarro, rb.precocarro, rb.imagemcarro)
			end
		end
    end
end)



RegisterServerEvent('offred_carshop:comprarCarro')
AddEventHandler('offred_carshop:comprarCarro',function(value)
	local src = source
	local user_id = vRP.getUserId(src)
	--if user_id and vRP.hasPermission(user_id,"conssionaria.permissao") then
	for k,v in pairs(carros) do
		if v.id == tonumber(value) then
			local rows = vRP.query("vRP/get_vehiclesList", {id = tonumber(value)})
			if rows[1].estoquecarro ~= 0 then
				-- verifica quantidade de carros na garagem.
				local garagems = 3
				local totalv = vRP.query("vRP/get_maxcars",{ user_id = user_id })
				if vRP.hasPermission(user_id,"bronze.permissao") then
					if parseInt(totalv[1].quantidade) >= parseInt(garagems) + 3 then
						local typemessage = "error"
						local mensagem = "Você atingiu o número máximo de veículos em sua garagem"
						vRPclient.setDiv(source, "Alerta","body {font-family: 'Source Sans Pro', 'Helvetica Neue', Arial, sans-serif;color: #34495e;-webkit-font-smoothing: antialiased;line-height: 1.6em;}p {margin: 0;}.notice {margin: 1em;background: #F9F9F9;padding: 1em 1em 1em 2em;border-left: 4px solid #DDD;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.125);bottom: 7%;right: 1%;line-height: 22px;position: absolute;max-width: 500px;-webkit-border-radius: 5px; -webkit-animation: fadein 2s; -moz-animation: fadein 2s; -ms-animation: fadein 2s; -o-animation: fadein 2s; animation: fadein 2s;}.notice:before {position: absolute;top: 50%;margin-top: -17px;left: -17px;background-color: #DDD;color: #FFF;width: 30px;height: 30px;text-align: center;line-height: 30px;font-weight: bold;font-family: Georgia;text-shadow: 1px 1px rgba(0, 0, 0, 0.5);}.info {border-color: #0074D9;}.info:before {content: \"i\";background-color: #0074D9;}.sucesso {border-color: #2ECC40;}.sucesso:before {content: \"√\";background-color: #2ECC40;}.aviso {border-color: #FFDC00;}.aviso:before {content: \"!\";background-color: #FFDC00;}.error {border-color: #FF4136;}.error:before {content: \"X\";background-color: #FF4136;}@keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-moz-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-webkit-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-ms-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-o-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}","<div class=\"notice "..typemessage.."\"><p>"..mensagem..".</p></div>")
						SetTimeout(5000,function()
							vRPclient.removeDiv(source, "Alerta")
						end)
						return
					end
				elseif vRP.hasPermission(user_id,"prata.permissao") then
					if parseInt(totalv[1].quantidade) >= parseInt(garagems) + 6 then
						local typemessage = "error"
						local mensagem = "Você atingiu o número máximo de veículos em sua garagem"
						vRPclient.setDiv(source, "Alerta","body {font-family: 'Source Sans Pro', 'Helvetica Neue', Arial, sans-serif;color: #34495e;-webkit-font-smoothing: antialiased;line-height: 1.6em;}p {margin: 0;}.notice {margin: 1em;background: #F9F9F9;padding: 1em 1em 1em 2em;border-left: 4px solid #DDD;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.125);bottom: 7%;right: 1%;line-height: 22px;position: absolute;max-width: 500px;-webkit-border-radius: 5px; -webkit-animation: fadein 2s; -moz-animation: fadein 2s; -ms-animation: fadein 2s; -o-animation: fadein 2s; animation: fadein 2s;}.notice:before {position: absolute;top: 50%;margin-top: -17px;left: -17px;background-color: #DDD;color: #FFF;width: 30px;height: 30px;text-align: center;line-height: 30px;font-weight: bold;font-family: Georgia;text-shadow: 1px 1px rgba(0, 0, 0, 0.5);}.info {border-color: #0074D9;}.info:before {content: \"i\";background-color: #0074D9;}.sucesso {border-color: #2ECC40;}.sucesso:before {content: \"√\";background-color: #2ECC40;}.aviso {border-color: #FFDC00;}.aviso:before {content: \"!\";background-color: #FFDC00;}.error {border-color: #FF4136;}.error:before {content: \"X\";background-color: #FF4136;}@keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-moz-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-webkit-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-ms-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-o-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}","<div class=\"notice "..typemessage.."\"><p>"..mensagem..".</p></div>")
						SetTimeout(5000,function()
							vRPclient.removeDiv(source, "Alerta")
						end)
						return
					end
				elseif vRP.hasPermission(user_id,"ouro.permissao") then
					if parseInt(totalv[1].quantidade) >= parseInt(garagems) + 10 then
						local typemessage = "error"
						local mensagem = "Você atingiu o número máximo de veículos em sua garagem"
						vRPclient.setDiv(source, "Alerta","body {font-family: 'Source Sans Pro', 'Helvetica Neue', Arial, sans-serif;color: #34495e;-webkit-font-smoothing: antialiased;line-height: 1.6em;}p {margin: 0;}.notice {margin: 1em;background: #F9F9F9;padding: 1em 1em 1em 2em;border-left: 4px solid #DDD;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.125);bottom: 7%;right: 1%;line-height: 22px;position: absolute;max-width: 500px;-webkit-border-radius: 5px; -webkit-animation: fadein 2s; -moz-animation: fadein 2s; -ms-animation: fadein 2s; -o-animation: fadein 2s; animation: fadein 2s;}.notice:before {position: absolute;top: 50%;margin-top: -17px;left: -17px;background-color: #DDD;color: #FFF;width: 30px;height: 30px;text-align: center;line-height: 30px;font-weight: bold;font-family: Georgia;text-shadow: 1px 1px rgba(0, 0, 0, 0.5);}.info {border-color: #0074D9;}.info:before {content: \"i\";background-color: #0074D9;}.sucesso {border-color: #2ECC40;}.sucesso:before {content: \"√\";background-color: #2ECC40;}.aviso {border-color: #FFDC00;}.aviso:before {content: \"!\";background-color: #FFDC00;}.error {border-color: #FF4136;}.error:before {content: \"X\";background-color: #FF4136;}@keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-moz-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-webkit-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-ms-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-o-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}","<div class=\"notice "..typemessage.."\"><p>"..mensagem..".</p></div>")
						SetTimeout(5000,function()
							vRPclient.removeDiv(source, "Alerta")
						end)
						return
					end
				elseif vRP.hasPermission(user_id,"platina.permissao") then
					if parseInt(totalv[1].quantidade) >= parseInt(garagems) + 15 then
						local typemessage = "error"
						local mensagem = "Você atingiu o número máximo de veículos em sua garagem"
						vRPclient.setDiv(src, "Alerta","body {font-family: 'Source Sans Pro', 'Helvetica Neue', Arial, sans-serif;color: #34495e;-webkit-font-smoothing: antialiased;line-height: 1.6em;}p {margin: 0;}.notice {margin: 1em;background: #F9F9F9;padding: 1em 1em 1em 2em;border-left: 4px solid #DDD;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.125);bottom: 7%;right: 1%;line-height: 22px;position: absolute;max-width: 500px;-webkit-border-radius: 5px; -webkit-animation: fadein 2s; -moz-animation: fadein 2s; -ms-animation: fadein 2s; -o-animation: fadein 2s; animation: fadein 2s;}.notice:before {position: absolute;top: 50%;margin-top: -17px;left: -17px;background-color: #DDD;color: #FFF;width: 30px;height: 30px;text-align: center;line-height: 30px;font-weight: bold;font-family: Georgia;text-shadow: 1px 1px rgba(0, 0, 0, 0.5);}.info {border-color: #0074D9;}.info:before {content: \"i\";background-color: #0074D9;}.sucesso {border-color: #2ECC40;}.sucesso:before {content: \"√\";background-color: #2ECC40;}.aviso {border-color: #FFDC00;}.aviso:before {content: \"!\";background-color: #FFDC00;}.error {border-color: #FF4136;}.error:before {content: \"X\";background-color: #FF4136;}@keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-moz-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-webkit-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-ms-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-o-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}","<div class=\"notice "..typemessage.."\"><p>"..mensagem..".</p></div>")
						SetTimeout(5000,function()
							vRPclient.removeDiv(src, "Alerta")
						end)
						return
					end
				elseif vRP.hasPermission(user_id,"diamante.permissao") then
					if parseInt(totalv[1].quantidade) >= parseInt(garagems) + 25 then
						local typemessage = "error"
						local mensagem = "Você atingiu o número máximo de veículos em sua garagem"
						vRPclient.setDiv(src, "Alerta","body {font-family: 'Source Sans Pro', 'Helvetica Neue', Arial, sans-serif;color: #34495e;-webkit-font-smoothing: antialiased;line-height: 1.6em;}p {margin: 0;}.notice {margin: 1em;background: #F9F9F9;padding: 1em 1em 1em 2em;border-left: 4px solid #DDD;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.125);bottom: 7%;right: 1%;line-height: 22px;position: absolute;max-width: 500px;-webkit-border-radius: 5px; -webkit-animation: fadein 2s; -moz-animation: fadein 2s; -ms-animation: fadein 2s; -o-animation: fadein 2s; animation: fadein 2s;}.notice:before {position: absolute;top: 50%;margin-top: -17px;left: -17px;background-color: #DDD;color: #FFF;width: 30px;height: 30px;text-align: center;line-height: 30px;font-weight: bold;font-family: Georgia;text-shadow: 1px 1px rgba(0, 0, 0, 0.5);}.info {border-color: #0074D9;}.info:before {content: \"i\";background-color: #0074D9;}.sucesso {border-color: #2ECC40;}.sucesso:before {content: \"√\";background-color: #2ECC40;}.aviso {border-color: #FFDC00;}.aviso:before {content: \"!\";background-color: #FFDC00;}.error {border-color: #FF4136;}.error:before {content: \"X\";background-color: #FF4136;}@keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-moz-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-webkit-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-ms-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-o-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}","<div class=\"notice "..typemessage.."\"><p>"..mensagem..".</p></div>")
						SetTimeout(5000,function()
							vRPclient.removeDiv(src, "Alerta")
						end)
						return
					end
				elseif vRP.hasPermission(user_id,"supremo.permissao") then
					if parseInt(totalv[1].quantidade) >= parseInt(garagems) + 50 then
						local typemessage = "error"
						local mensagem = "Você atingiu o número máximo de veículos em sua garagem"
						vRPclient.setDiv(src, "Alerta","body {font-family: 'Source Sans Pro', 'Helvetica Neue', Arial, sans-serif;color: #34495e;-webkit-font-smoothing: antialiased;line-height: 1.6em;}p {margin: 0;}.notice {margin: 1em;background: #F9F9F9;padding: 1em 1em 1em 2em;border-left: 4px solid #DDD;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.125);bottom: 7%;right: 1%;line-height: 22px;position: absolute;max-width: 500px;-webkit-border-radius: 5px; -webkit-animation: fadein 2s; -moz-animation: fadein 2s; -ms-animation: fadein 2s; -o-animation: fadein 2s; animation: fadein 2s;}.notice:before {position: absolute;top: 50%;margin-top: -17px;left: -17px;background-color: #DDD;color: #FFF;width: 30px;height: 30px;text-align: center;line-height: 30px;font-weight: bold;font-family: Georgia;text-shadow: 1px 1px rgba(0, 0, 0, 0.5);}.info {border-color: #0074D9;}.info:before {content: \"i\";background-color: #0074D9;}.sucesso {border-color: #2ECC40;}.sucesso:before {content: \"√\";background-color: #2ECC40;}.aviso {border-color: #FFDC00;}.aviso:before {content: \"!\";background-color: #FFDC00;}.error {border-color: #FF4136;}.error:before {content: \"X\";background-color: #FF4136;}@keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-moz-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-webkit-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-ms-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-o-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}","<div class=\"notice "..typemessage.."\"><p>"..mensagem..".</p></div>")
						SetTimeout(5000,function()
							vRPclient.removeDiv(src, "Alerta")
						end)
						return
					end	
				elseif vRP.hasPermission(user_id,"lavagem.permissao") then
					if parseInt(totalv[1].quantidade) >= parseInt(garagems) + 50 then
						local typemessage = "error"
						local mensagem = "Você atingiu o número máximo de veículos em sua garagem"
						vRPclient.setDiv(src, "Alerta","body {font-family: 'Source Sans Pro', 'Helvetica Neue', Arial, sans-serif;color: #34495e;-webkit-font-smoothing: antialiased;line-height: 1.6em;}p {margin: 0;}.notice {margin: 1em;background: #F9F9F9;padding: 1em 1em 1em 2em;border-left: 4px solid #DDD;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.125);bottom: 7%;right: 1%;line-height: 22px;position: absolute;max-width: 500px;-webkit-border-radius: 5px; -webkit-animation: fadein 2s; -moz-animation: fadein 2s; -ms-animation: fadein 2s; -o-animation: fadein 2s; animation: fadein 2s;}.notice:before {position: absolute;top: 50%;margin-top: -17px;left: -17px;background-color: #DDD;color: #FFF;width: 30px;height: 30px;text-align: center;line-height: 30px;font-weight: bold;font-family: Georgia;text-shadow: 1px 1px rgba(0, 0, 0, 0.5);}.info {border-color: #0074D9;}.info:before {content: \"i\";background-color: #0074D9;}.sucesso {border-color: #2ECC40;}.sucesso:before {content: \"√\";background-color: #2ECC40;}.aviso {border-color: #FFDC00;}.aviso:before {content: \"!\";background-color: #FFDC00;}.error {border-color: #FF4136;}.error:before {content: \"X\";background-color: #FF4136;}@keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-moz-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-webkit-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-ms-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-o-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}","<div class=\"notice "..typemessage.."\"><p>"..mensagem..".</p></div>")
						SetTimeout(5000,function()
							vRPclient.removeDiv(src, "Alerta")
						end)
						return
					end					
				else
					if parseInt(totalv[1].quantidade) >= parseInt(garagems) then
						local typemessage = "error"
						local mensagem = "Você atingiu o número máximo de veículos em sua garagem"
						vRPclient.setDiv(src, "Alerta","body {font-family: 'Source Sans Pro', 'Helvetica Neue', Arial, sans-serif;color: #34495e;-webkit-font-smoothing: antialiased;line-height: 1.6em;}p {margin: 0;}.notice {margin: 1em;background: #F9F9F9;padding: 1em 1em 1em 2em;border-left: 4px solid #DDD;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.125);bottom: 7%;right: 1%;line-height: 22px;position: absolute;max-width: 500px;-webkit-border-radius: 5px; -webkit-animation: fadein 2s; -moz-animation: fadein 2s; -ms-animation: fadein 2s; -o-animation: fadein 2s; animation: fadein 2s;}.notice:before {position: absolute;top: 50%;margin-top: -17px;left: -17px;background-color: #DDD;color: #FFF;width: 30px;height: 30px;text-align: center;line-height: 30px;font-weight: bold;font-family: Georgia;text-shadow: 1px 1px rgba(0, 0, 0, 0.5);}.info {border-color: #0074D9;}.info:before {content: \"i\";background-color: #0074D9;}.sucesso {border-color: #2ECC40;}.sucesso:before {content: \"√\";background-color: #2ECC40;}.aviso {border-color: #FFDC00;}.aviso:before {content: \"!\";background-color: #FFDC00;}.error {border-color: #FF4136;}.error:before {content: \"X\";background-color: #FF4136;}@keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-moz-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-webkit-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-ms-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-o-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}","<div class=\"notice "..typemessage.."\"><p>"..mensagem..".</p></div>")
						SetTimeout(5000,function()
							vRPclient.removeDiv(src, "Alerta")
						end)
						return
					end
				end
				-- compra o veiculo
				if vRP.tryFullPayment(user_id,v.precocarro,false) then
					local compra = vRP.execute("vRP/add_vehicle",{ user_id = user_id, vehicle = v.nome })
					if compra > 0 then
						local row = vRP.execute("vRP/remove_stock", {id = tonumber(value)})
						if row > 0 then
							-- removeu stock
							-- atualizar no NUI
						end
						local typemessage = "sucesso"
						local mensagem = "Você pagou <font color=\"green\">$"..v.precocarro.."</font> dolares"
						vRPclient.setDiv(src, "Alerta","body {font-family: 'Source Sans Pro', 'Helvetica Neue', Arial, sans-serif;color: #34495e;-webkit-font-smoothing: antialiased;line-height: 1.6em;}p {margin: 0;}.notice {margin: 1em;background: #F9F9F9;padding: 1em 1em 1em 2em;border-left: 4px solid #DDD;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.125);bottom: 7%;right: 1%;line-height: 22px;position: absolute;max-width: 500px;-webkit-border-radius: 5px; -webkit-animation: fadein 2s; -moz-animation: fadein 2s; -ms-animation: fadein 2s; -o-animation: fadein 2s; animation: fadein 2s;}.notice:before {position: absolute;top: 50%;margin-top: -17px;left: -17px;background-color: #DDD;color: #FFF;width: 30px;height: 30px;text-align: center;line-height: 30px;font-weight: bold;font-family: Georgia;text-shadow: 1px 1px rgba(0, 0, 0, 0.5);}.info {border-color: #0074D9;}.info:before {content: \"i\";background-color: #0074D9;}.sucesso {border-color: #2ECC40;}.sucesso:before {content: \"√\";background-color: #2ECC40;}.aviso {border-color: #FFDC00;}.aviso:before {content: \"!\";background-color: #FFDC00;}.error {border-color: #FF4136;}.error:before {content: \"X\";background-color: #FF4136;}@keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-moz-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-webkit-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-ms-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-o-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}","<div class=\"notice "..typemessage.."\"><p>"..mensagem..".</p></div>")
						TriggerEvent('logs:ToDiscord', discord_webhook , "Logs", "```Player "..user_id.." \nComprou o veiculo: "..v.nome.." \nPreço: "..v.precocarro.."```", "https://www.tumarcafacil.com/wp-content/uploads/2017/06/RegistroDeMarca-01-1.png", false, false)


						SetTimeout(5000,function()
							vRPclient.removeDiv(src, "Alerta")
						end)
					else
						local typemessage = "error"
						local mensagem = "Você já possui este veículo em sua garagem."
						vRPclient.setDiv(src, "Alerta","body {font-family: 'Source Sans Pro', 'Helvetica Neue', Arial, sans-serif;color: #34495e;-webkit-font-smoothing: antialiased;line-height: 1.6em;}p {margin: 0;}.notice {margin: 1em;background: #F9F9F9;padding: 1em 1em 1em 2em;border-left: 4px solid #DDD;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.125);bottom: 7%;right: 1%;line-height: 22px;position: absolute;max-width: 500px;-webkit-border-radius: 5px; -webkit-animation: fadein 2s; -moz-animation: fadein 2s; -ms-animation: fadein 2s; -o-animation: fadein 2s; animation: fadein 2s;}.notice:before {position: absolute;top: 50%;margin-top: -17px;left: -17px;background-color: #DDD;color: #FFF;width: 30px;height: 30px;text-align: center;line-height: 30px;font-weight: bold;font-family: Georgia;text-shadow: 1px 1px rgba(0, 0, 0, 0.5);}.info {border-color: #0074D9;}.info:before {content: \"i\";background-color: #0074D9;}.sucesso {border-color: #2ECC40;}.sucesso:before {content: \"√\";background-color: #2ECC40;}.aviso {border-color: #FFDC00;}.aviso:before {content: \"!\";background-color: #FFDC00;}.error {border-color: #FF4136;}.error:before {content: \"X\";background-color: #FF4136;}@keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-moz-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-webkit-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-ms-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-o-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}","<div class=\"notice "..typemessage.."\"><p>"..mensagem..".</p></div>")
						SetTimeout(5000,function()
							vRPclient.removeDiv(src, "Alerta")
						end)
					end
				end
			else
				-- envia pro client NUi ( sem estoque )
			end
		end
	end
--end
end)
