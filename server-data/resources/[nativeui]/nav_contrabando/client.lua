local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("nav_contrabando")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "utilidades-comprar-algemas" then
		TriggerServerEvent("contrabando-comprar","algemas")
	elseif data == "utilidades-comprar-capuz" then
		TriggerServerEvent("contrabando-comprar","capuz")
	elseif data == "utilidades-comprar-lockpick" then
		TriggerServerEvent("contrabando-comprar","lockpick")
	elseif data == "utilidades-comprar-masterpick" then
		TriggerServerEvent("contrabando-comprar","masterpick")
	elseif data == "utilidades-comprar-pendrive" then
		TriggerServerEvent("contrabando-comprar","pendrive")
	elseif data == "utilidades-comprar-rebite" then
		TriggerServerEvent("contrabando-comprar","rebite")
	elseif data == "utilidades-comprar-bomba" then
		TriggerServerEvent("contrabando-comprar","bombaadesiva")
	elseif data == "utilidades-comprar-placa" then
		TriggerServerEvent("contrabando-comprar","placa")
	elseif data == "utilidades-comprar-colete" then
		TriggerServerEvent("contrabando-comprar","colete")

	elseif data == "utilidades-vender-algemas" then
		TriggerServerEvent("contrabando-vender","algemas")
	elseif data == "utilidades-vender-capuz" then
		TriggerServerEvent("contrabando-vender","capuz")
	elseif data == "utilidades-vender-lockpick" then
		TriggerServerEvent("contrabando-vender","lockpick")
	elseif data == "utilidades-vender-masterpick" then
		TriggerServerEvent("contrabando-vender","masterpick")
	elseif data == "utilidades-vender-bomba" then
		TriggerServerEvent("contrabando-vender","bombaadesiva")
	elseif data == "utilidades-vender-pendrive" then
		TriggerServerEvent("contrabando-vender","pendrive")
	elseif data == "utilidades-vender-rebite" then
		TriggerServerEvent("contrabando-vender","rebite")
	elseif data == "utilidades-vender-placa" then
		TriggerServerEvent("contrabando-vender","placa")

	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(1)
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),2556.2380371094,4661.6108398438,34.075294494629,true)
		if distance <= 30 then
			DrawMarker(20,2556.2380371094,4661.6108398438,35.075294494629-0.97,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,100,1,0,0,0)
			if distance <= 1.1 then
				if IsControlJustPressed(0,38) and emP.checkPermission() then
					ToggleActionMenu()
				end
			end
		end
	end
end)