vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_inventario")


local show = false
local temp_pinventory = nil
local temp_inventory = nil
local temp_weight = nil
local temp_maxWeight = nil
local temp_iWeight = nil
local temp_iMaxWeight = nil
local cooldown = 0

function openGui(pinventory, inventory, weight, maxWeight, iWeight, iMaxWeight, dt, style)
  if show == false then
    show = true
    SetNuiFocus(true, true)
    SendNUIMessage(
      {
        show = true,
		pinventory = pinventory,
        inventory = inventory,
        p_i_weight = weight,
        p_i_maxWeight = maxWeight,
		i_weight = iWeight,
		i_maxWeight = iMaxWeight,
		dataType = dt,
		style = style
      }
    )
  end
end

function closeGui()
  show = false
  SetNuiFocus(false)
  SendNUIMessage({show = false})
end

RegisterNetEvent("vrp_inventario:openGui")
AddEventHandler("vrp_inventario:openGui",function(dt,name,name2, style)
      TriggerServerEvent("vrp_inventario:openGui",dt,name,name2, style)
end)

RegisterNetEvent("vrp_inventario:updateInventory")
AddEventHandler("vrp_inventario:updateInventory",function(pinventory, inventory, weight, maxWeight, iWeight, iMaxWeight, dt, style)
    cooldown = Config.AntiSpamCooldown
    temp_pinventory = pinventory
	temp_inventory = inventory
    temp_weight = weight
    temp_maxWeight = maxWeight
	temp_iWeight = iWeight
    temp_iMaxWeight = iMaxWeight
    openGui(temp_pinventory, temp_inventory, temp_weight, temp_maxWeight, temp_iWeight, temp_iMaxWeight, dt, style)
  end
)

RegisterNetEvent("vrp_inventario:UINotification")
AddEventHandler("vrp_inventario:UINotification",function(type, title, message)
    show = true
    SetNuiFocus(true, true)
    SendNUIMessage(
      {
        show = true,
        notification = true,
        type = type,
        title = title,
        message = message
      }
    )
  end
)

RegisterNetEvent("vrp_inventario:closeGui")
AddEventHandler("vrp_inventario:closeGui",function()
  closeGui()
end)

RegisterNetEvent("vrp_inventario:objectForAnimation")
AddEventHandler("vrp_inventario:objectForAnimation",function(type)
    local ped = PlayerPedId()
    DeleteObject(object)
    bone = GetPedBoneIndex(ped, 60309)
    coords = GetEntityCoords(ped)
    modelHash = GetHashKey(type)

    RequestModel(modelHash)
    object = CreateObject(modelHash, coords.x, coords.y, coords.z, true, true, false)
    AttachEntityToEntity(object, ped, bone, 0.1, 0.0, 0.0, 1.0, 1.0, 1.0, 1, 1, 0, 0, 2, 1)
    Citizen.Wait(2500)
    DeleteObject(object)
  end
)

RegisterNUICallback("close",function(data)
    closeGui()
  end
)

RegisterNUICallback("storeAll",function(data)
    cooldown = 0
    closeGui()
    TriggerServerEvent("vrp_inventario:storeAll", data)
end)

RegisterNUICallback("useItem",function(data)
    cooldown = 0
    closeGui()
    TriggerServerEvent("vrp_inventario:useItem", data)
end)

RegisterNUICallback("dropItem",function(data)
    cooldown = 0
    closeGui()
    TriggerServerEvent("vrp_inventario:dropItem", data)
  end
)

RegisterNUICallback("giveItem",function(data)
    cooldown = 0
    closeGui()
    TriggerServerEvent("vrp_inventario:giveItem", data)
  end
)

RegisterNUICallback("putItem",function(data)
	cooldown = 0
	closeGui()
	TriggerServerEvent("vrp_inventario:putItem", data)
end)

RegisterNUICallback("takeItem",function(data)
	cooldown = 0
	closeGui()
	TriggerServerEvent("vrp_inventario:takeItem", data)
end)

RegisterCommand("moc",function(source, args)
	local ped = PlayerPedId()
	local veh = GetVehiclePedIsIn(ped,false)
	if veh ~= 0 then
		TriggerEvent("vrp_inventario:openGui",1,string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(veh))),string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(veh))),1)
	else
		TriggerEvent("vrp_inventario:openGui",1,0,0,1)
	end
end)

RegisterCommand("bau",function(source, args)
	local ped = PlayerPedId()
	local veh = GetVehiclePedIsIn(ped,false)
	if veh ~= 0 then
		TriggerEvent("vrp_inventario:openGui",2,string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(veh))),string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(veh))),2)
	end
end)

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(0)
      if IsControlPressed(0, Config.OpenMenu) then
		local ped = PlayerPedId()
		local veh = GetVehiclePedIsIn(ped,false)
		if veh ~= 0 then
			TriggerEvent("vrp_inventario:openGui",1,string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(veh))),string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(veh))),1)
		else
			TriggerEvent("vrp_inventario:openGui",1,0,0,1)
		end
      end
    end
  end
)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    if cooldown > 0 then 
      cooldown = cooldown - 1
    end
  end
end)

AddEventHandler("onResourceStop",function(resource)
    if resource == GetCurrentResourceName() then
      closeGui()
    end
  end
)

local cancelando = false
RegisterNetEvent('cancelando')
AddEventHandler('cancelando',function(status)
    cancelando = status
end)
--------------------------------------------------------------
--INVENTÁRIO FOME E SEDE
--------------------------------------------------------------

RegisterNetEvent('crz_inventory:usarAgua')
AddEventHandler('crz_inventory:usarAgua', function(propobject, variation)
	local ped = PlayerPedId()
	TriggerEvent('cancelando')
    RequestAnimDict('amb@world_human_drinking@beer@male@idle_a')
    while not HasAnimDictLoaded('amb@world_human_drinking@beer@male@idle_a') do
		Citizen.Wait(0)
    end
	local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.0,-5.0)
	object = CreateObject(GetHashKey(propobject),coords.x,coords.y,coords.z,true,true,true)
	
    Citizen.CreateThread(function()
		TaskPlayAnim(ped,"amb@world_human_drinking@beer@male@idle_a","idle_a",3.0,3.0,-1,49,0,0,0,0)
		AttachEntityToEntity(object,ped,GetPedBoneIndex(ped,28422),0.0,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
		SetEntityAsMissionEntity(object,true,true)
		Citizen.Wait(10000)
		TriggerEvent('cancelando')
		if DoesEntityExist(object) then
			if IsEntityAnObject(object) then
				ClearPedTasks(ped)
				TriggerServerEvent('DRP_ID:variation',0,variation)
				SetEntityAsMissionEntity(object,false,true)
				DetachEntity(object,true,true)
				DeleteObject(object)
				object = nil
			end
		end
    end)
end)

RegisterNetEvent('crz_inventory:usarBebidas')
AddEventHandler('crz_inventory:usarBebidas', function(propobject, variation)
	local ped = PlayerPedId()
	TriggerEvent('cancelando')
    RequestAnimDict('amb@world_human_drinking@beer@male@idle_a')
    while not HasAnimDictLoaded('amb@world_human_drinking@beer@male@idle_a') do
		Citizen.Wait(0)
    end
	local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.0,-5.0)
	object = CreateObject(GetHashKey(propobject),coords.x,coords.y,coords.z,true,true,true)
	
    Citizen.CreateThread(function()
		TaskPlayAnim(ped,"amb@world_human_drinking@beer@male@idle_a","idle_a",3.0,3.0,-1,49,0,0,0,0)
		AttachEntityToEntity(object,ped,GetPedBoneIndex(ped,28422),0.0,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
		SetEntityAsMissionEntity(object,true,true)
		Citizen.Wait(10000)
		vRP.playScreenEffect("RaceTurbo",180)
		vRP.playScreenEffect("DrugsTrevorClownsFight",180)
		TriggerEvent('cancelando')
		if DoesEntityExist(object) then
			if IsEntityAnObject(object) then
				ClearPedTasks(ped)
				TriggerServerEvent('DRP_ID:variation',10,variation)
				SetEntityAsMissionEntity(object,false,true)
				DetachEntity(object,true,true)
				DeleteObject(object)
				object = nil
			end
		end
    end)
end)

RegisterNetEvent('crz_inventory:comerAlgo')
AddEventHandler('crz_inventory:comerAlgo', function(propobject, variation)
	local ped = PlayerPedId()
	TriggerEvent('cancelando')
    RequestAnimDict('mp_player_inteat@burger')
    while not HasAnimDictLoaded('mp_player_inteat@burger') do
		Citizen.Wait(0)
    end
	local x,y,z = table.unpack(GetEntityCoords(ped))
	object = CreateObject(GetHashKey(propobject),x,y,z+0.2,true,true,true)
	
    Citizen.CreateThread(function()
		TaskPlayAnim(ped, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
		AttachEntityToEntity(object,ped,GetPedBoneIndex(ped,18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
		SetEntityAsMissionEntity(object,true,true)
		Citizen.Wait(10000)
		TriggerEvent('cancelando')
		if DoesEntityExist(object) then
			if IsEntityAnObject(object) then
				ClearPedTasks(ped)
				TriggerServerEvent('DRP_ID:variation',variation,0)
				SetEntityAsMissionEntity(object,false,true)
				DetachEntity(object,true,true)
				DeleteObject(object)
				object = nil
			end
		end
    end)
end)

RegisterNetEvent('crz_inventory:comerNotAnim')
AddEventHandler('crz_inventory:comerNotAnim', function(variation)
	local ped = PlayerPedId()
	TriggerEvent('cancelando')
    RequestAnimDict('mp_player_inteat@burger')
    while not HasAnimDictLoaded('mp_player_inteat@burger') do
		Citizen.Wait(0)
    end
    Citizen.CreateThread(function()
		TaskPlayAnim(ped, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
		Citizen.Wait(10000)
		TriggerEvent('cancelando')
		ClearPedTasks(ped)
		TriggerServerEvent('DRP_ID:variation',variation,0)
    end)
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if cancelando then
			DisableControlAction(0,288,true)
			DisableControlAction(0,289,true)
			DisableControlAction(0,170,true)
			DisableControlAction(0,166,true)
			DisableControlAction(0,187,true)
			DisableControlAction(0,189,true)
			DisableControlAction(0,190,true)
			DisableControlAction(0,188,true)
			DisableControlAction(0,57,true)
			DisableControlAction(0,73,true)
			DisableControlAction(0,167,true)
			DisableControlAction(0,311,true)
			DisableControlAction(0,344,true)
			DisableControlAction(0,29,true)
			DisableControlAction(0,182,true)
			DisableControlAction(0,245,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,47,true)
			DisableControlAction(0,38,true)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- MOCHILA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("colocar:mochila")
AddEventHandler("colocar:mochila",function()
	local prop_name = 'prop_michael_backpack'
	local playerPed = PlayerPedId()
	Citizen.CreateThread(function()
		local x,y,z = table.unpack(GetEntityCoords(playerPed))
		DeleteObject(prop)
		prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
		AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 24818), 0.046, -0.17, -0.040, 0.0, 90.0, 180.0, true, true, false, true, 1, true)
	end)
end)

RegisterCommand("tmochila",function(source,args)
	DeleteObject(prop)
end)