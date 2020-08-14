local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_minerador",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
local peixes = {
	[1] = { x = "mouro" },
	[2] = { x = "mferro" },
	[3] = { x = "mbronze" },
	[4] = { x = "mrubi" },
	[5] = { x = "mesmeralda" },
	[6] = { x = "diamante" },
}

function emP.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("mferro") <= vRP.getInventoryMaxWeight(user_id) then
				if math.random(100) >= 98 then
					vRP.giveInventoryItem(user_id,"diamante",1)
				else
					vRP.giveInventoryItem(user_id,peixes[math.random(5)].x,1)
				end
				return true
		end
	end
end