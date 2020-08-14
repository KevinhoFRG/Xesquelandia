local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
	{ item = "nitro", quantidade = 1, compra = 5000, venda = 2500 },
	{ item = "repairkit", quantidade = 1, compra = 2000, venda = 1000 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPRAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("mecanicos-comprar")
AddEventHandler("mecanicos-comprar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if item == "colete" then
			if vRP.tryPayment(user_id,4000) then
				vRPclient.setArmour(source,100)
				TriggerClientEvent("Notify",source,"sucesso","Comprou <b>1x Colete</b> por <b>$4.000 dólares</b>.")
			else
				TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
			end
		else
			for k,v in pairs(valores) do
				if item == v.item then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
						if vRP.tryPayment(user_id,parseInt(v.compra)) then
							vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
							TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(v.quantidade).."x "..vRP.getItemName(v.item).."</b> por <b>$"..vRP.format(parseInt(v.compra)).." dólares</b>.")
						else
							TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
						end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VENDER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("mecanicos-vender")
AddEventHandler("mecanicos-vender",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.tryGetInventoryItem(user_id,v.item,parseInt(v.quantidade)) then
					vRP.giveMoney(user_id,parseInt(v.venda))
					TriggerClientEvent("Notify",source,"sucesso","Vendeu <b>"..parseInt(v.quantidade).."x "..vRP.getItemName(v.item).."</b> por <b>$"..vRP.format(parseInt(v.venda)).." dólares</b>.")
				else
					TriggerClientEvent("Notify",source,"negado","Não possui <b>"..parseInt(v.quantidade).."x "..vRP.getItemName(v.item).."</b> em sua mochila.")
				end
			end
		end
	end
end)