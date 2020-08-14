local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
healSv = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
Tunnel.bindInterface("crazy_healing",healSv)

local message = 0
local deitadoMaca = 0
cabeca = nil
peito = nil
calca = nil

RegisterNetEvent('vestimenta')
AddEventHandler('vestimenta', function(funcao)
	if funcao == 1 then
		if(GetEntityModel(GetPlayerPed(-1)) == GetHashKey("mp_m_freemode_01")) then
			cabeca = GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 3)
			peito = GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 4)
			calca = GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 11)
			SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)  --Bulletproof Vest
			SetPedComponentVariation(GetPlayerPed(-1), 4, 84, 5, 2)  --Bulletproof Vest
			SetPedComponentVariation(GetPlayerPed(-1), 11, 186, 5, 2)  --Bulletproof Vest
			if IsEntityDead(GetPlayerPed(-1)) then -- if dead, resurrect
	        	SetEntityHealth(GetPlayerPed(-1), 0)
	        end
		elseif(GetEntityModel(GetPlayerPed(-1)) == GetHashKey("mp_f_freemode_01")) then
			cabeca = GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 3)
			peito = GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 4)
			calca = GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 11)
			SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)
			SetPedComponentVariation(GetPlayerPed(-1), 4, 86, 5, 2)
			SetPedComponentVariation(GetPlayerPed(-1), 11, 188, 5, 2)
			if IsEntityDead(GetPlayerPed(-1)) then -- if dead, resurrect
	        	SetEntityHealth(GetPlayerPed(-1), 0)
	        end
		end
	elseif funcao == 0 then
		SetPedComponentVariation(GetPlayerPed(-1), 3, cabeca, 0, 2) -- Cabeca
		SetPedComponentVariation(GetPlayerPed(-1), 4, peito, 5, 2)  -- Peitoral
		SetPedComponentVariation(GetPlayerPed(-1), 11, calca, 5, 2) -- Calca
	end
end)

RegisterNetEvent('mancandoJogador')
AddEventHandler('mancandoJogador', function (verific)
	if verific == 1 then
		message = 1
	else
		ResetPedMovementClipset(GetPlayerPed(-1), 0)
		message = 0
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if message == 1 then
			RequestAnimSet("move_injured_generic")
			while not HasAnimSetLoaded("move_injured_generic") do
				Citizen.Wait(0)
			end
			SetPedMovementClipset(GetPlayerPed(-1), "move_injured_generic", 1 )
			DisableControlAction(0,20,true) -- disable Z
			DisableControlAction(0,21,true) -- disable shift
			DisableControlAction(0,22,true) -- disable spacebar
			DisableControlAction(0,25,true) -- disable aim
			textoManagement("Você está em ~r~recuperação~w~.")
		end
	end
end)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

local freezePlayer = false

RegisterNetEvent('xDbR:freezar')
AddEventHandler('xDbR:freezar',function(time)
    freezePlayer = not freezePlayer
    local ped = GetPlayerPed(-1)
    if freezePlayer then
        SetEntityInvincible(ped,true)
        SetEntityVisible(ped,true)
		SetEntityHeading(ped, -49.05)
        FreezeEntityPosition(ped,true)
        SetTimeout(time,function()
            SetEntityInvincible(ped,false)
            SetEntityVisible(ped,true)
            FreezeEntityPosition(ped,false)
        end)
    end
end)

Citizen.CreateThread( function()
	while true do 
		--- Sistema De Roupa
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 336.06500244141,-574.91906738281,42.283996582031, true ) < 1 then
				DisplayHelpText("~g~E~w~ - Pegar colete médico")
		end
		local playerCoords = GetEntityCoords(GetPlayerPed(-1), true)
		DrawMarker(23, 336.06500244141,-574.91906738281,42.283996582031, 0, 0, 0, 0, 0, 0, 1.0001,1.0001,1.0001, 95,140,30,30, 0, 0, 2, 0, 0, 0, 0)
		if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 343.09255981445,-574.82928466797,42.283988952637, true) <= 1.0 then
			if IsControlJustPressed(0, 38) then
				TriggerServerEvent('xDbR:Roupa')
			end
		end

		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 343.09255981445,-574.82928466797,42.283988952637, true ) < 1 then
				DisplayHelpText("Pressione ~g~E~s~ para pegar equipamento do paramédico")
		end
		local playerCoords = GetEntityCoords(GetPlayerPed(-1), true)
		DrawMarker(23, 343.09255981445,-574.82928466797,42.283988952637, 0, 0, 0, 0, 0, 0, 1.0001,1.0001,1.0001, 95,140,30,30, 0, 0, 2, 0, 0, 0, 0)
		if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, 343.09255981445,-574.82928466797,42.283988952637, true) <= 1.0 then
			if IsControlJustPressed(0, 38) then
				TriggerServerEvent('xDbR:Equipamento')
			end
		end	
		Citizen.Wait(0)
	end 
end)

function Texto3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())    
    if onScreen then
        SetTextScale(0.54, 0.54)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function Texto3D(x,y,z, text, Opacidade)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())    
    if onScreen then
        SetTextScale(0.54, 0.54)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, Opacidade)
        SetTextDropshadow(0, 0, 0, 0, Opacidade)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

RegisterNetEvent('xDbR:Entrar')
AddEventHandler('xDbR:Entrar', function()
abrirHospital()
end)
RegisterNetEvent('xDbR:Sair')
AddEventHandler('xDbR:Sair', function()
sairHospital()
end)

RegisterNetEvent('xDbR:EntrarHeli')
AddEventHandler('xDbR:EntrarHeli', function()
entrarHeliHosp()
end)

RegisterNetEvent('xDbR:SairHeli')
AddEventHandler('xDbR:SairHeli', function()
sairHeliHosp()
end)

function entrarHeliHosp()
		local ped = GetPlayerPed(-1)
		local playerCoords = GetEntityCoords(GetPlayerPed(-1), true)
		--DoScreenFadeOut(1000)
		Citizen.Wait(1500)
		SetEntityCoords(GetPlayerPed(-1), 339.84210205078,-584.13690185547,74.165664672852)
		--DoScreenFadeIn(1000)
end
function sairHeliHosp()
		local ped = GetPlayerPed(-1)
		local playerCoords = GetEntityCoords(GetPlayerPed(-1), true)
		--DoScreenFadeOut(1000)
		Citizen.Wait(1500)
		SetEntityCoords(GetPlayerPed(-1), 325.17544555664,-598.56365966797,43.291828155518)
		--DoScreenFadeIn(1000)
end

 
offset = {x = 0.160, y = 0.95}
scale = 0.40
function textoManagement(text)
  SetTextProportional(1)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
	SetTextColour(255, 255, 255, 155)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
	SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(offset.x, offset.y)
end
