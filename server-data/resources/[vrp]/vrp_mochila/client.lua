local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
func = Tunnel.getInterface("vrp_trafico")

--enableBackPack = true
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if func.checkweight() then
			local ped = GetPlayerPed(-1)
			if (GetEntityModel(ped) == GetHashKey("mp_m_freemode_01")) then
				SetPedComponentVariation(ped, 7, 23, 0, 2)
			end	
		end
	end
end)

--[[RegisterCommand("mochila",function(source,args)
	local ped = GetPlayerPed(-1)
	if args[1] == "on" then
		enableBackPack = true
	elseif args[1] == "off" then
		enableBackPack = false
		SetPedComponentVariation(ped, 7, 0, 0, 2)	
	end		 
end)]]