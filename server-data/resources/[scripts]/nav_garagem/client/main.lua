local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
grS = Tunnel.getInterface("hkn_garages")
grg = {}
Tunnel.bindInterface("hkn_garages", grg)

local vehicles = {}
local currentGarage = nil
local spawnLocation = nil

-----------------------------------------------------------------------------------------------------------------------------------------
-- MAIN THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false, false)
	while true do
		Citizen.Wait(0)
		for _,details in pairs(config.garages) do
			for key,value in pairs(details.point) do
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), value.x, value.y, value.z, true) <= 3 then
					if IsControlJustPressed(0, 38) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then	
						currentGarage = _					
						SetNuiFocus(true, true)
						SendNUIMessage({action = "showMenu"})
					end
					DrawMarker(36,value.x,value.y,value.z+0.3-0.80,0,0,0,0,0,0,1.0,1.0,1.0,199,0,0,50,1,0,0,0)
					DrawMarker(23,value.x,value.y,value.z-0.97,0,0,0,0,0,0,1.3,1.3,0.3,199,0,0,50,0,0,0,0)
					
				end
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CALLBACK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("myVehicles", function(data, cb)
	local vehs = grS.getVehicles()	
	if vehs ~= nil then
		cb(vehs)
	end
end)

RegisterNUICallback("spawnVehicles", function(data, cb)
	if data.name then
		TriggerServerEvent('hkn_garages:spawnVehicle', data.name)
	end
end)

RegisterNUICallback("rentVehicles", function(data, cb)
	if data.name then
		local vehs = grS.rentVehicle()	
		if vehs then
			TriggerServerEvent('hkn_garages:spawnVehicle', data.name)
		end
	end
end)

RegisterNUICallback("deleteVehicles", function(data, cb)
	if data.name then
		if GetPlayersLastVehicle() == vehicles[data.name][2] then
			TriggerServerEvent('hkn_garages:despawnVehicle', data.name)
		else
			TriggerEvent('Notify', 'negado', 'Veículo não encontrado, entre e saia do mesmo e tente novamente.')
		end
	end
end)

RegisterNUICallback('NUIFocusOff', function()
	SetNuiFocus(false, false)
	SendNUIMessage({action = 'hideMenu'})
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function grg.setVehicleMods(custom,veh)
	if not veh then
		veh = GetVehiclePedIsUsing(PlayerPedId())
	end
	if custom and veh then
		SetVehicleModKit(veh,0)
		if custom.colour then
			SetVehicleColours(veh,tonumber(custom.colour.primary),tonumber(custom.colour.secondary))
			SetVehicleExtraColours(veh,tonumber(custom.colour.pearlescent),tonumber(custom.colour.wheel))
			if custom.colour.neon then
				SetVehicleNeonLightsColour(veh,tonumber(custom.colour.neon[1]),tonumber(custom.colour.neon[2]),tonumber(custom.colour.neon[3]))
			end
			if custom.colour.smoke then
				SetVehicleTyreSmokeColor(veh,tonumber(custom.colour.smoke[1]),tonumber(custom.colour.smoke[2]),tonumber(custom.colour.smoke[3]))
			end
			if custom.colour.custom then
				if custom.colour.custom.primary then
					SetVehicleCustomPrimaryColour(veh,tonumber(custom.colour.custom.primary[1]),tonumber(custom.colour.custom.primary[2]),tonumber(custom.colour.custom.primary[3]))
				end
				if custom.colour.custom.secondary then
					SetVehicleCustomSecondaryColour(veh,tonumber(custom.colour.custom.secondary[1]),tonumber(custom.colour.custom.secondary[2]),tonumber(custom.colour.custom.secondary[3]))
				end
			end
		end

		if custom.plate then
			SetVehicleNumberPlateTextIndex(veh,tonumber(custom.plate.index))
		end

		SetVehicleWindowTint(veh,tonumber(custom.janela))
		SetVehicleTyresCanBurst(veh,tonumber(custom.bulletproof))
		SetVehicleWheelType(veh,tonumber(custom.wheel))

		ToggleVehicleMod(veh,18,tonumber(custom.turbo))
		ToggleVehicleMod(veh,20,tonumber(custom.fumaca))
		ToggleVehicleMod(veh,22,tonumber(custom.farol))

		if custom.neon then
			SetVehicleNeonLightEnabled(veh,0,tonumber(custom.neon.left))
			SetVehicleNeonLightEnabled(veh,1,tonumber(custom.neon.right))
			SetVehicleNeonLightEnabled(veh,2,tonumber(custom.neon.front))
			SetVehicleNeonLightEnabled(veh,3,tonumber(custom.neon.back))
		end

		if custom.mods then
			for i,mod in pairs(custom.mods) do
				if i ~= 18 and i ~= 20 and i ~= 22 and i ~= 46 then
					SetVehicleMod(veh,tonumber(i),tonumber(mod))
				end
			end
		end
		
		SetVehicleMod(veh,23,tonumber(custom.tyres),custom.tyresvariation)
		SetVehicleMod(veh,24,tonumber(custom.tyres),custom.tyresvariation)
	end
end

function grg.spawnGarageVehicle(name,--[[custom,]]enginehealth,bodyhealth,fuellevel)
	local vehicle = vehicles[name]
	if vehicle == nil then
		local mhash = GetHashKey(name)
		while not HasModelLoaded(mhash) do
			RequestModel(mhash)
			Citizen.Wait(10)
		end
		if HasModelLoaded(mhash) then
			rand = 1
			for _,spawn in pairs(config.garages[currentGarage].spaces) do
				checkPos = GetClosestVehicle(spawn.x,spawn.y,spawn.z,3.001,0,71)
				if DoesEntityExist(checkPos) and checkPos ~= nil then
					rand = rand + 1
					if rand > #config.garages[currentGarage].spaces then
						rand = -1
						TriggerEvent('azt:notify', 'inform', 'Todas as vagas estão ocupadas no momento.')
						break
					end
				else
					spawnLocation = spawn
					break
				end
				Citizen.Wait(1)
			end

			if rand ~= -1 then
				nveh = CreateVehicle(mhash,spawnLocation.x,spawnLocation.y,spawnLocation.z+0.5,spawnLocation.h,true,false)
				netveh = VehToNet(nveh)

				NetworkRegisterEntityAsNetworked(nveh)
				while not NetworkGetEntityIsNetworked(nveh) do
					NetworkRegisterEntityAsNetworked(nveh)
					Citizen.Wait(1)
				end

				if NetworkDoesNetworkIdExist(netveh) then
					SetEntitySomething(nveh,true)
					if NetworkGetEntityIsNetworked(nveh) then
						SetNetworkIdExistsOnAllMachines(netveh,true)
					end
				end

				NetworkFadeInEntity(NetToEnt(netveh),true)
				SetVehicleIsStolen(NetToVeh(netveh),false)
				SetVehicleNeedsToBeHotwired(NetToVeh(netveh),false)
				SetEntityInvincible(NetToVeh(netveh),false)
				SetVehicleNumberPlateText(NetToVeh(netveh),vRP.getRegistrationNumber())
				SetEntityAsMissionEntity(NetToVeh(netveh),true,true)
				SetVehicleHasBeenOwnedByPlayer(NetToVeh(netveh),true)

				SetVehRadioStation(NetToVeh(netveh),"OFF")

				--[[if custom then
					grg.setVehicleMods(custom,NetToVeh(netveh))
				end]]

				SetVehicleEngineHealth(NetToVeh(netveh), enginehealth+0.0)
				SetVehicleBodyHealth(NetToVeh(netveh), bodyhealth+0.0)
				SetVehicleFuelLevel(NetToVeh(netveh),fuellevel+0.0)

				SetModelAsNoLongerNeeded(mhash)

				vehicles[name] = { name,nveh }
			end

			TriggerServerEvent("LSC:applyModifications", name, nveh)

			return true,VehToNet(nveh),name,mhash
		end
	end
	return false,0,nil
end

function grg.despawnGarageVehicle(name)
	local vehicle = vehicles[name][2]	
	if vehicle then
		TriggerEvent("LSC:save", name, vehicle)
		vehicles[name] = nil
		TriggerServerEvent("hkn_garages:saveVehicle", VehToNet(vehicle), GetVehicleEngineHealth(vehicle), GetVehicleBodyHealth(vehicle), GetVehicleFuelLevel(vehicle))
		TriggerServerEvent("hkn_garages:syncDelete", VehToNet(vehicle))
	end
end

function grg.syncDelete(vnet)	
	Citizen.CreateThread(function()
		if NetworkDoesNetworkIdExist(vnet) then
			SetVehicleAsNoLongerNeeded(vnet)
			SetEntityAsMissionEntity(vnet, true, true)
			local veh = NetToVeh(vnet)
			if DoesEntityExist(veh) then
				SetVehicleHasBeenOwnedByPlayer(veh, false)
				PlaceObjectOnGroundProperly(veh)
				SetEntityAsNoLongerNeeded(veh)
				SetEntityAsMissionEntity(veh, true, true)
				DeleteVehicle(veh)				
			end
		end
	end)	
end

function grg.checkInStreet(vehicle)
	local plate = vRP.getRegistrationNumber()
	for veh in EnumerateVehicles() do
		if GetVehicleNumberPlateText(veh) == plate and GetDisplayNameFromVehicleModel(GetEntityModel(veh)):lower() == vehicle then
			vehicles[vehicle] = { vehicle,veh }
			return true,VehToNet(veh),vehicle,GetEntityModel(veh)
		end
	end
	return false
end

function grg.closeNUI()
	SetNuiFocus(false, false)
	SendNUIMessage({action = 'hideMenu'})
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTITY
-----------------------------------------------------------------------------------------------------------------------------------------
local entityEnumerator = {
	__gc = function(enum)
	    if enum.destructor and enum.handle then
		    enum.destructor(enum.handle)
	    end
	    enum.destructor = nil
	    enum.handle = nil
	end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
	    local iter, id = initFunc()
	    if not id or id == 0 then
	        disposeFunc(iter)
		    return
	    end
	  
	    local enum = {handle = iter, destructor = disposeFunc}
	    setmetatable(enum, entityEnumerator)
	  
	    local next = true
	    repeat
		    coroutine.yield(id)
		    next, id = moveFunc(iter)
	    until not next
	  
	    enum.destructor, enum.handle = nil, nil
	    disposeFunc(iter)
	end)
end

function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end