local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

inMenu                      = true
local Menu = true
local player = PlayerPedId()

local arsenal = {
	{ 459.11001586914,-979.72705078125,30.689596176147 }, --RECOM/BPCHQ
	{ 825.6015625,164.20104980469,86.386734008789 }, --BOPE
	{ 470.20706176758,-1086.1563720703,38.706546783447 }, --PF
	{ -2514.3581542969,3583.7380371094,16.498008728027 }, --PRF
	{ -2050.4089355469,-456.18185424805,16.424406051636 } -- PMERJ
}

if Menu then
	Citizen.CreateThread(function()
	while true do
		Wait(0)
		for _,lugares in pairs(arsenal) do
			local x,y,z = table.unpack(lugares)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),x,y,z,true)
			DrawMarker(25,x,y+0.33,z-0.90,0,0,0,0,180.0,130.0,2.0,2.0,1.0,25,25,122,50,0,0,0,0)
			if distance <= 2 then
				if IsControlJustPressed(0, 51) then
					TriggerServerEvent('crz_arsenal:permissao')
				end
			end
		end
	end
		if IsControlJustPressed(1, 3) then
		  inMenu = false
		  SetNuiFocus(false)
		  SendNUIMessage({type = 'close'})
		end
	end)
end

RegisterNetEvent('crz_arsenal:permissao')
AddEventHandler('crz_arsenal:permissao',function()
	inMenu = true
	SetNuiFocus(true, true)
	SendNUIMessage({type = 'openGeneral'})
end)


RegisterNUICallback('NUIFocusOff', function()
  inMenu = false
  SetNuiFocus(false)
  SendNUIMessage({type = 'closeAll'})
end)

RegisterNUICallback('Agua', function()
	local ped = PlayerPedId()
	GiveWeaponToPed(ped,GetHashKey("WEAPON_BZGAS"),1,0,0)
end)
RegisterNUICallback('Cerveja', function()
	local ped = PlayerPedId()
	GiveWeaponToPed(ped,GetHashKey("WEAPON_STUNGUN"),0,0,0)
end)
RegisterNUICallback('Vodka', function()
	local ped = PlayerPedId()
	GiveWeaponToPed(ped,GetHashKey("WEAPON_NIGHTSTICK"),0,0,0)
end)
RegisterNUICallback('Conhaque', function()
	TriggerServerEvent('crz_arsenal:colete')
	print('a')
end)
RegisterNUICallback('Whisky', function()
	local ped = PlayerPedId()
	GiveWeaponToPed(ped,GetHashKey("WEAPON_FIREEXTINGUISHER"),25000,0,1)
end)
RegisterNUICallback('Tequila', function()
	local ped = PlayerPedId()
	GiveWeaponToPed(ped,GetHashKey("WEAPON_FLASHLIGHT"),0,0,0)
end)
RegisterNUICallback('Leite', function()
	local ped = PlayerPedId()
	RemoveAllPedWeapons(ped,true)
end)
RegisterNUICallback('Dourado', function()
	local ped = PlayerPedId()
		SetPedAmmo(ped,GetHashKey("WEAPON_COMBATPISTOL"),0)
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_COMBATPISTOL"))
		GiveWeaponToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),100,0,1)
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),GetHashKey("COMPONENT_COMBATPISTOL_CLIP_02"))
end)
RegisterNUICallback('Taco', function()
	local ped = PlayerPedId()
		SetPedAmmo(ped,GetHashKey("WEAPON_SMG"),0)
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_SMG"))
		GiveWeaponToPed(ped,GetHashKey("WEAPON_SMG"),200,0,1)
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_SMG_CLIP_02"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_AT_AR_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_AT_SCOPE_MACRO_02"))
end)
RegisterNUICallback('Donut', function()
	local ped = PlayerPedId()
		SetPedAmmo(ped,GetHashKey("WEAPON_COMBATPDW"),0)
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_COMBATPDW"))
		GiveWeaponToPed(ped,GetHashKey("WEAPON_COMBATPDW"),200,0,1)
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_COMBATPDW_CLIP_02"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_AR_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_SCOPE_SMALL"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
end)
RegisterNUICallback('DonutX', function()
	local ped = PlayerPedId()
		SetPedAmmo(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),0)
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"))
		GiveWeaponToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),30,0,1)
end)
RegisterNUICallback('Hamburguer', function()
	local ped = PlayerPedId()
		SetPedAmmo(ped,GetHashKey("WEAPON_CARBINERIFLE"),0)
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_CARBINERIFLE"))
		GiveWeaponToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),200,0,1)
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_CARBINERIFLE_CLIP_02"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_AR_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
end)
RegisterNUICallback('HotDog', function()
	local ped = PlayerPedId()
	GiveWeaponToPed(ped,GetHashKey("WEAPON_KNIFE"),0,0,1)
end)
RegisterNUICallback('Salmao', function()
	local ped = PlayerPedId()
	RemoveAllPedWeapons(ped,true)
end)