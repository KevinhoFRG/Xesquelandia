local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

emP = {}
Tunnel.bindInterface("emp_drogas",emP)
local idgens = Tools.newIDGenerator()
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
local quantidade = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUANTIDADE
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.Quantidade()
	local source = source
	if quantidade[source] == nil then
		quantidade[source] = math.random(2,3)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkItens()
	emP.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.hasPermission(user_id,"trafico2.permissao") then
			return vRP.getInventoryItemAmount(user_id,"maconha") or vRP.getInventoryItemAmount(user_id,"cocaina") or vRP.getInventoryItemAmount(user_id,"metanfetamina") >= quantidade[source]
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAGAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local policia = vRP.getUsersByPermission("policia.permissao")
		if vRP.tryGetInventoryItem(user_id,"cocaina",quantidade[source]) or vRP.tryGetInventoryItem(user_id,"metanfetamina",quantidade[source]) or vRP.tryGetInventoryItem(user_id,"maconha",quantidade[source]) then 
			vRP.giveInventoryItem(user_id,"dinheirosujo",math.random(350,400)*quantidade[source]+(#policia*50))
			vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
			quantidade[source] = nil
		end
	end
end

function emP.MarcarOcorrencia()
	local source = source
	local user_id = vRP.getUserId(source)
	local x,y,z = vRPclient.getPosition(source)
	if user_id then
		TriggerClientEvent("Notify",source,"aviso","A policia foi acionada.")
		local soldado = vRP.getUsersByPermission("policia.permissao")
		for l,w in pairs(soldado) do
			local player = vRP.getUserSource(parseInt(w))
			if player then
				async(function()
					local id = idgens:gen()
					blips[id] = vRPclient.addBlip(player,x,y,z,153,84,"Ocorrência",0.5,false)
					vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
					TriggerClientEvent('chatMessage',player,"190",{65,130,255},"Recebemos uma denuncia de drogas, verifique o ocorrido.")
					SetTimeout(15000,function() vRPclient.removeBlip(player,blips[id]) idgens:free(id) end)
				end)
			end
		end
	end
end