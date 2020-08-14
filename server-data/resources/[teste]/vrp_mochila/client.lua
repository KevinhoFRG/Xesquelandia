local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
func = Tunnel.getInterface("vrp_mochila")

enableBackPack = true
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if and func.checkweight() and enableBackPack then
			local ped = GetPlayerPed(-1)
			if (GetEntityModel(ped) == GetHashKey("mp_m_freemode_01")) then
				SetPedComponentVariation(ped, 7, 15, 0, 2)
			elseif (GetEntityModel(ped) == GetHashKey("mp_f_freemode_01")) then
				SetPedComponentVariation(ped, 5, 32, 0, 2)
			end
		elseif not func.checkweight() and enableBackPack then
			local ped = GetPlayerPed(-1)
			if (GetEntityModel(ped) == GetHashKey("mp_m_freemode_01")) then
				SetPedComponentVariation(ped, 7, 0, 0, 2)
			elseif (GetEntityModel(ped) == GetHashKey("mp_f_freemode_01")) then
				SetPedComponentVariation(ped, 5, 0, 0, 2)	
			end	
		end
	end
end)

RegisterCommand("mochila",function(source,args)
	local ped = GetPlayerPed(-1)
	if args[1] == "on" then
		enableBackPack = true
	elseif args[1] == "off" then
		enableBackPack = false
		SetPedComponentVariation(ped, 7, 0, 0, 2)	
	end		 
end)