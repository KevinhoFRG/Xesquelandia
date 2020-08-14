local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_bancos")
-------------------------
--------- LOCAL ---------
-------------------------
local banks = cfg.banks
local robbers = {}
---------------------------------
----------- WEBHOOK -------------
---------------------------------
RegisterServerEvent("webhook:enviarlog") --ENVIA O LOG DO BANCO PARA O DISCORD
AddEventHandler("webhook:enviarlog",function(name,message)
	if message == nil or message == '' or message:sub(1, 1) == '/' then return FALSE end
	PerformHttpRequest('https://discordapp.com/api/webhooks/601178581699133440/zhuAdDsGguiVB7YuZCWFUn8dbI11rXKdkR_jYEu6Mg3Yfr4zfBAMPxtJdCYKi-8TOlv', function(err, text, headers) end, 'POST', json.encode({username = name, content = message}), { ['Content-Type'] = 'application/json' })
end)
---------------------------------
----------- FUNCTION ------------
---------------------------------
function get3DDistance(x1, y1, z1, x2, y2, z2) -- PEGA A DISTÂNCIA 3D
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end
---------------------------------------------
------------------ EVENT --------------------
---------------------------------------------
RegisterServerEvent('vrp_bancos:muitolonge')
AddEventHandler('vrp_bancos:muitolonge', function(robb)
	if(robbers[source])then
		TriggerClientEvent('vrp_bancos:muitolongelocal', source)
		robbers[source] = nil
		TriggerClientEvent('chatMessage', -1, 'MÍDIA', { 105, 105, 105 }, "Os assaltantes fugiram do ^2" .. banks[robb].nameofbank ..".")
	end
end)

RegisterServerEvent('vrp_bancos:jogadormorreu')
AddEventHandler('vrp_bancos:jogadormorreu', function(robb)
	if(robbers[source])then
		TriggerClientEvent('vrp_bancos:jogadormorreulocal', source)
		robbers[source] = nil
		TriggerClientEvent('chatMessage', -1, 'MÍDIA', { 105, 105, 105 }, "Os assaltantes fugiram do ^2" .. banks[robb].nameofbank ..".")
	end
end)

RegisterServerEvent('vrp_bancos:hackermorreu')
AddEventHandler('vrp_bancos:hackermorreu', function(robb)
	if(robbers[source])then
		TriggerClientEvent('vrp_bancos:hackermorreulocal', source)
		robbers[source] = nil
		TriggerClientEvent('chatMessage', -1, 'MÍDIA', { 105, 105, 105 }, "A tentativa de hackear o sistema do ^2" .. banks[robb].nameofbank .." falhou.")
	end
end)

RegisterServerEvent('vrp_bancos:teleportar')
AddEventHandler('vrp_bancos:teleportar', function()
    local source = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	vRPclient.teleport(source, 253.35618591309,223.45489501953,101.68347930908) 
end)
------------------------------------------------
------------------- COFRE ----------------------
------------------------------------------------
RegisterServerEvent('vrp_bancos:roubar')
AddEventHandler('vrp_bancos:roubar', function(robb)
  local user_id = vRP.getUserId(source)
  local player = vRP.getUserSource(user_id)
  local cops = vRP.getUsersByPermission(cfg.permission)
  if vRP.hasPermission(user_id,cfg.permission) then
	TriggerClientEvent('chatMessage', player, 'BANCO', { 255, 69, 0 }, "Policiais não podem assaltar bancos, cai fora.")
  else
    if #cops >= cfg.cops then
	  if banks[robb] then
		  local bank = banks[robb]

		  if (os.time() - bank.lastrobbed) < cfg.seconds+cfg.cooldown and bank.lastrobbed ~= 0 then
			  TriggerClientEvent('chatMessage', player, 'BANCO', { 255, 69, 0 }, "Acabamos de ser assaltados, a nova remessa vem em ^2" .. (cfg.seconds+cfg.cooldown - (os.time() - bank.lastrobbed)) .. "^0 segundos.")
			  return
		  end
		  TriggerClientEvent('chatMessage', -1, 'MÍDIA', { 128, 0, 0 }, "Uma tentativa de roubar o cofre foi iniciado no ^2" .. bank.nameofbank)
		  TriggerClientEvent('chatMessage', player, 'AVISO', { 0, 0x99, 255 }, "Você começou a arrombar o cofre do ^2" .. bank.nameofbank .. "^0, fique na área até a finalização!")
		  TriggerEvent("webhook:enviarlog", "Assalto", "ID: "..user_id.." ("..GetPlayerName(player)..") começou a arrombar o cofre do "..bank.nameofbank)
		  TriggerClientEvent('chatMessage', player, 'AVISO', { 0, 0x99, 255 }, "Aguente firme por alguns minutos e o dinheiro será todo seu!")
		  TriggerClientEvent('vrp_bancos:roubando', player, robb)
		  banks[robb].lastrobbed = os.time()
		  robbers[player] = robb
		  local savedSource = player
		  SetTimeout(cfg.seconds*1000, function()
			  if(robbers[savedSource])then
				  if(user_id)then
					  vRP.giveInventoryItem(user_id,"dinheirosujo",bank.reward,true)
						TriggerClientEvent('chatMessage', -1, 'MÍDIA', { 128, 0, 0 }, "Os assaltantes conseguiram roubar o cofre do ^2" .. bank.nameofbank .. "^0!")
						TriggerEvent("webhook:enviarlog", "Assalto", "ID: "..user_id.." ("..GetPlayerName(player)..") roubou o cofre do "..bank.nameofbank.." e conseguiu roubar "..bank.reward)
						
					  TriggerClientEvent('vrp_bancos:completo', savedSource, bank.reward)
				  end
			  end
		  end)
	  end
    else
	  TriggerClientEvent('chatMessage', player, 'BANCO', { 255, 69, 0 }, "Não há policiais o suficiente para iniciar um roubo.")
    end
  end
end)
------------------------------------------------
------------------- HACKER ---------------------
------------------------------------------------
RegisterServerEvent('vrp_bancos:hackear')
AddEventHandler('vrp_bancos:hackear', function(robb)
  local user_id = vRP.getUserId(source)
  local player = vRP.getUserSource(user_id)
  local cops = vRP.getUsersByPermission(cfg.permission)
  if vRP.hasPermission(user_id,cfg.permission) then
	TriggerClientEvent('chatMessage', player, 'BANCO', { 255, 69, 0 }, "Policiais não podem hackear bancos, cai fora.")
  else
    if #cops >= cfg.cops then
	  if banks[robb] then
		  local bank = banks[robb]

		  if (os.time() - bank.lasthackeado) < cfg.seconds+cfg.cooldown and bank.lasthackeado ~= 0 then
			  TriggerClientEvent('chatMessage', player, 'BANCO', { 255, 69, 0 }, "Acabamos de ser assaltados, a nova remessa vem em ^2" .. (cfg.seconds+cfg.cooldown - (os.time() - bank.lasthackeado)) .. "^0 segundos.")
			  return
		  end
		  TriggerClientEvent('chatMessage', -1, 'MÍDIA', { 128, 0, 0 }, "Uma tentativa de hackear o sistema de trancas do cofre foi iniciado no ^2" .. bank.nameofbank)
		  TriggerClientEvent('chatMessage', player, 'AVISO', { 0, 0x99, 255 }, "Você começou a hackear o sistema de trancas do ^2" .. bank.nameofbank .. "^0, boa sorte!")
		  TriggerEvent("webhook:enviarlog", "Assalto", "ID: "..user_id.." ("..GetPlayerName(player)..") começou a hackear o cofre do "..bank.nameofbank)
		  TriggerClientEvent('vrp_bancos:hackeando', player, robb)
		  banks[robb].lasthackeado = os.time()
		  robbers[player] = robb
		  local savedSource = player
		  SetTimeout(cfg.seconds*1000, function()
			  if(robbers[savedSource])then
				TriggerClientEvent('vrp_bancos:completohack', savedSource)
			  end
		  end)
	  end
    else
	  TriggerClientEvent('chatMessage', player, 'BANCO', { 255, 69, 0 }, "Não há policiais o suficiente para iniciar um roubo.")
    end
  end
end)