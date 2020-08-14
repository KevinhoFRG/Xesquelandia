local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
CMDclient = Tunnel.getInterface("vrp_cmds")
Healclient = Tunnel.getInterface("crazy_healing")

RegisterServerEvent('xDbR:Roupa')
AddEventHandler('xDbR:Roupa', function()
	local source = source
	local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
	local gender = Healclient.mulherHomem(source)
	if vRP.tryGetInventoryItem(user_id, "rpprotecao", 1) then
		local old_custom = vRPclient.getCustomization(source)
		old_custom.modelhash = nil
		TriggerClientEvent('chatMessage',source,"ALERTA",{255,70,50},"Você equipou a roupa de proteção indicada pelo médico.")
		TriggerClientEvent('mancandoJogador', source, 1)
		TriggerClientEvent('vestimenta', source, 1)
		SetTimeout(300000, function()
			vRPclient._setCustomization(source,old_custom)
			TriggerClientEvent('mancandoJogador', source, 0)	
			TriggerClientEvent('chatMessage',source,"ALERTA",{255,70,50},"Você se recuperou.")
			vRPclient.setHealth(source, 200)
		end)
	else
		TriggerClientEvent('chatMessage',source,"ALERTA",{255,70,50},"Você não possui o kit enviado pelo médico.")
	end
end)

RegisterServerEvent('xDbR:Equipamento')
AddEventHandler('xDbR:Equipamento', function()
	local source = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if vRP.hasPermission(user_id,"paramedico.permissao") then
		vRP.giveInventoryItem(user_id, "rpprotecao", 1, true)
	else
		TriggerClientEvent('chatMessage',source,"ALERTA",{255,70,50},"Você não é do Paramédico.")
	end
end)