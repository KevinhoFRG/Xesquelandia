-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
local idgens = Tools.newIDGenerator()
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_robnpcs",src)
vCLIENT = Tunnel.getInterface("vrp_robnpcs")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local pedlist = {}
local blips = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PEDLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkPedlist(npc)
	if pedlist[npc] then
		return true
	else
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESSEDPEDLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function src.pressedPedlist(npc)
	pedlist[npc] = true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local itemlist = {
	[1] = { ['index'] = "maconha", ['qtd'] = math.random(5,10), ['name'] = "Maconhas" },
	[2] = { ['index'] = "relogioroubado", ['qtd'] = 1, ['name'] = "Relógio" },
	[3] = { ['index'] = "pulseiraroubada", ['qtd'] = 1, ['name'] = "Pulseira" },
	[4] = { ['index'] = "anelroubado", ['qtd'] = 1, ['name'] = "Anel" },
	[5] = { ['index'] = "colarroubado", ['qtd'] = 1, ['name'] = "Colar" },
	[6] = { ['index'] = "brincoroubado", ['qtd'] = 2, ['name'] = "Brincos" },
	[7] = { ['index'] = "carteiraroubada", ['qtd'] = 1, ['name'] = "Carteira" },
	[8] = { ['index'] = "tabletroubado", ['qtd'] = 1, ['name'] = "Tablet" },
	[9] = { ['index'] = "sapatosroubado", ['qtd'] = 1, ['name'] = "Sapatos" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	local x,y,z = vRPclient.getPosition(source)
	if user_id then
		local randlist = math.random(100)
		if randlist >= 40 and randlist <= 89 then
			local randitem = math.random(#itemlist)
			vRP.giveInventoryItem(user_id,itemlist[randitem].index,itemlist[randitem].qtd)
			TriggerClientEvent("Notify",source,"sucesso","Você recebeu "..itemlist[randitem].qtd.."x <b>"..itemlist[randitem].name.."</b>.")
		elseif randlist >= 90 then
			TriggerClientEvent("Notify",source,"aviso","A policia foi acionada.")
			local policia = vRP.getUsersByPermission("policia.permissao")
			for k,v in pairs(policia) do
				local player = vRP.getUserSource(parseInt(v))
				if player then
					local ids = idgens:gen()
					vRPclient.playSound(player,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
					blips[ids] = vRPclient.addBlip(player,x,y,z,1,59,"Roubo em andamento",0.5,true)
					TriggerClientEvent('chatMessage',player,"911",{65,130,255},"Recebemos uma denuncia de roubo, verifique o ocorrido.")
					SetTimeout(30000,function() vRPclient.removeBlip(player,blips[ids]) idgens:free(ids) end)
				end
			end
		end
		local randmoney = math.random(200,400)
		vRP.giveMoney(user_id,parseInt(randmoney))
		TriggerClientEvent("Notify",source,"sucesso","Recebeu <b>"..parseInt(randmoney).." dólares</b>.")
	end
end