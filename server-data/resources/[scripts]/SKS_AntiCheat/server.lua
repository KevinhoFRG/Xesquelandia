local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","HG_AntiCheat")

ExecuteCommand(('sets AntiCheat "Ativado"'))


Citizen.CreateThread(function()
	ac_webhook_inventario = GetConvar("ac_webhook_inventario", "none")

	function SendWebhookMessage(webhook,message)
	if webhook ~= "none" then
	PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
	end
end)


RegisterServerEvent("HG_AntiCheat:Cars")
AddEventHandler("HG_AntiCheat:Cars", function()
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local name = GetPlayerName(source)
	local cfg = getConfig()
	print(cfg.anticheat.name.." | " ..name.. "["..user_id.. "] "..cfg.cars.desc.." ("..cfg.cars.reason..")!")
	SendWebhookMessage(ac_webhook_inventario,""..cfg.anticheat.name.." | " ..name.. "["..user_id.. "] "..cfg.cars.desc.." ("..cfg.cars.reason..")!")
	TriggerClientEvent('chatMessage', -1, '^3'..cfg.anticheat.name, {255, 0, 0}, "^1" ..name.. "^3[ID:" ..user_id.. "]^1 "..cfg.cars.desc.." ^3("..cfg.anticheat.reason..": "..cfg.cars.reason..")!" )
	DropPlayer(source, cfg.anticheat.name.." | "..cfg.cars.kick.."! ("..cfg.cars.reason..")")
end)

RegisterServerEvent("HG_AntiCheat:Jump")
AddEventHandler("HG_AntiCheat:Jump", function()
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local name = GetPlayerName(source)
	local cfg = getConfig()
	print(cfg.anticheat.name.." | " ..name.. "["..user_id.. "] "..cfg.jump.desc.." ("..cfg.jump.reason..")!")
	
	SendWebhookMessage(ac_webhook_inventario,""..cfg.anticheat.name.." | " ..name.. "["..user_id.. "] "..cfg.jump.desc.." ("..cfg.jump.reason..")!")
	
	TriggerClientEvent('chatMessage', -1, '^3'..cfg.anticheat.name, {255, 0, 0}, "^1" ..name.. "^3[ID:" ..user_id.. "]^1 "..cfg.jump.desc.." ^3("..cfg.anticheat.reason..": "..cfg.jump.reason..")!" )
	DropPlayer(source, cfg.anticheat.name.." | "..cfg.jump.kick.."! ("..cfg.jump.reason..")")
end)

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
	local resourceName = ""..GetCurrentResourceName()..""
	local cfg = getConfig()
	vRPclient.notifyPicture(source,{"CHAR_LESTER",1,cfg.anticheat.name,false,cfg.anticheat.protect})
end)

AddEventHandler('playerConnecting', function(playerName, kick)
	local mysource = source
	local identifiers = GetPlayerIdentifiers(mysource)
	local steamid = identifiers[1]
	local cfg = getConfig()
	if cfg.anticheat.steam_require then
	if steamid:sub(1,6) == "steam:" then
	else
	kick(cfg.anticheat.name..""..cfg.anticheat.steam)
	CancelEvent()
	end
	end
end)

RegisterCommand("ac", function(source)
	local user_id = vRP.getUserId(source)	
	local player = vRP.getUserSource(user_id)
	local name = GetPlayerName(source)
	local cfg = getConfig()
    if vRP.hasPermission(user_id, cfg.anticheat.perm) then
	TriggerClientEvent("HG_AntiCheat:Toggle", -1, 1)
    else
	vRPclient.notifyPicture(source,{"CHAR_LESTER",1,cfg.anticheat.name,false,cfg.anticheat.no_perm})
    end
end)

PerformHttpRequest( "https://www.hackergeo.com/anticheat.txt", function( err, text, headers )
	Citizen.Wait( 1000 )
	local resourceName = "("..GetCurrentResourceName()..")"
	local cfg = getConfig()

	if ( text ~= cfg.version.version ) then
	else
	end
end, "GET", "", { what = 'this' } )