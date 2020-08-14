local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("nav_yakuza",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
	{ item = "wbody|WEAPON_PISTOL_MK2", quantidade = 1, compra = 3000, venda = 1500 },
	{ item = "wbody|WEAPON_MICROSMG", quantidade = 1, compra = 20000, venda = 10000 },
	{ item = "wbody|WEAPON_ASSAULTSMG", quantidade = 1, compra = 12000, venda = 6000 },
	{ item = "wbody|WEAPON_ASSAULTRIFLE", quantidade = 1, compra = 21000, venda = 10500 },
	{ item = "wbody|WEAPON_PUMPSHOTGUN_MK2", quantidade = 1, compra = 10000, venda = 5000 },
--	{ item = "wbody|WEAPON_GUSENBERG", quantidade = 1, compra = 15000, venda = 7500 },
  
	{ item = "wammo|WEAPON_PISTOL_MK2", quantidade = 50, compra = 100, venda = 50 },
    { item = "wammo|WEAPON_MICROSMG", quantidade = 50, compra = 100, venda = 50 },
	{ item = "wammo|WEAPON_ASSAULTRIFLE", quantidade = 50, compra = 120, venda = 60 },
    { item = "wammo|WEAPON_PUMPSHOTGUN_MK2", quantidade = 50, compra = 120, venda = 60 }
	--{ item = "wammo|WEAPON_GUSENBERG", quantidade = 50, compra = 120, venda = 60 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPRAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("yakuza-comprar")
AddEventHandler("yakuza-comprar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
					if vRP.tryGetInventoryItem(user_id,"aco",v.compra) then
						vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
						TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(v.quantidade).."x "..vRP.getItemName(v.item).."</b> por <b>"..vRP.format(parseInt(v.compra)).." Aços</b>.")
					else
						TriggerClientEvent("Notify",source,"negado","Aço insuficiente.")
					end
				else
					TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VENDER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("yakuza-vender")
AddEventHandler("yakuza-vender",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.tryGetInventoryItem(user_id,v.item,parseInt(v.quantidade)) then
					vRP.giveInventoryItem(user_id,"aco",parseInt(v.venda))
					TriggerClientEvent("Notify",source,"sucesso","Vendeu <b>"..parseInt(v.quantidade).."x "..vRP.getItemName(v.item).."</b> por <b>"..vRP.format(parseInt(v.venda)).." aços</b>.")
				else
					TriggerClientEvent("Notify",source,"negado","Não possui <b>"..parseInt(v.quantidade).."x "..vRP.getItemName(v.item).."</b> em sua mochila.")
				end
			end
		end
	end
end)

function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"yakuza.permissao")
end