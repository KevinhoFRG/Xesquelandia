local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
func = {}
Tunnel.bindInterface("vrp_mochila",func)

function func.checkweight()
	local user_id = vRP.getUserId(source)
	local weight = vRP.getInventoryMaxWeight(user_id)
	if weight > 5 then
		return true
	else
		return false
	end		
end