--Settings--
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

emP = {}
Tunnel.bindInterface("emp_housethief",emP)

-- // TimeLeft
local casaspoint = 1

local timers = 0

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1800000)
		casaspoint = math.random(1,9)
	end
end)

function emP.getCasapoint()
	return parseInt(casaspoint)
end

RegisterServerEvent('check')
AddEventHandler('check', function()
	local src = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local policia = vRP.getUsersByPermission("policia.permissao")
	if user_id then
		if #policia < 0 then
			TriggerClientEvent("Notify",source,"negado","Número insuficiente de policias em serviço.")
		elseif (os.time()-timers) <= 1800 then
			TriggerClientEvent("Notify",source,"negado","A casa foi assaltada recentemente, aguarde "..vRP.format(parseInt((1800-(os.time()-timers)))).." segundos .")
		else

		if vRP.tryGetInventoryItem(user_id,"lockpick",1,true) then
		timers = os.time()
			TriggerClientEvent('check',source)
			vRP.giveInventoryItem(user_id, "lockpick",-1,true)
		else
			TriggerClientEvent("Notify",source,"negado","Tu não tens um <b>Lockpick</b>.")
		end
       end
	end
end)

RegisterServerEvent('marcarqth')
AddEventHandler('marcarqth', function()
    local source = source
    local user_id = vRP.getUserId(source)
    local x,y,z = vRPclient.getPosition(source)
		local policia = vRP.getUsersByPermission("policia.permissao")

    if user_id then
     for l,w in pairs(policia) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						vRPclient.playSound(player,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
					end)
				end
			end
    end
end)
RegisterServerEvent('vrp_sound')
AddEventHandler('vrp_sound', function()
    local source = source
    local user_id = vRP.getUserId(source)
    local x,y,z = vRPclient.getPosition(source)
    if user_id then


TriggerClientEvent("vrp_sound:source",source,'lockingDoor',0.5)
Citizen.Wait(5000)
TriggerClientEvent("vrp_sound:source",source,'residencia',0.5)

	TriggerClientEvent("vrp_sound:fixed",-1,source,x,y,z,100,'residencia',0.7)

    end
end)
RegisterServerEvent('searchabajur')
AddEventHandler('searchabajur', function()
	local src = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)

	if user_id then
	local quantidade = math.random(1,8)
	vRP.giveInventoryItem(user_id, "anelroubado", quantidade,true) 

	end
end)
RegisterServerEvent('searchabajur2')
AddEventHandler('searchabajur2', function()
	local src = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)

	if user_id then
	local quantidade = math.random(1,8)

	vRP.giveInventoryItem(user_id, "colarroubado", quantidade,true)

	end
end)
RegisterServerEvent('searchabajur3')
AddEventHandler('searchabajur3', function()
	local src = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)

	if user_id then
	local quantidade = math.random(1,5)
vRP.giveInventoryItem(user_id, "brincoroubado", quantidade,true)

	end
end)
RegisterServerEvent('searchsafrao')
AddEventHandler('searchsafrao', function()
	local src = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)

	if user_id then
	local quantidade = math.random(1,7)
vRP.giveInventoryItem(user_id, "carteiraroubada", quantidade,true)

	end
end)
RegisterServerEvent('searchbook')
AddEventHandler('searchbook', function()
	local src = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)

	if user_id then
	local quantidade = math.random(1,5)
vRP.giveInventoryItem(user_id, "vibradorroubado", quantidade,true)

	end
end)
RegisterServerEvent('searchbanheiro')
AddEventHandler('searchbanheiro', function()
	local src = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)

	if user_id then
	local quantidade = math.random(1,5)
vRP.giveInventoryItem(user_id, "perfumeroubado", quantidade,true)

	end
end)
RegisterServerEvent('searchlivros')
AddEventHandler('searchlivros', function()
	local src = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)

	if user_id then
	local quantidade = math.random(1,2)
vRP.giveInventoryItem(user_id, "tabletroubado", quantidade,true)

	end
end)
RegisterServerEvent('searchmesinha')
AddEventHandler('searchmesinha', function()
	local src = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)

	if user_id then
	local quantidade = math.random(1,7)
vRP.giveInventoryItem(user_id, "carregadorroubado", quantidade,true)

	end
end)
