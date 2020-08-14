local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

emP = Tunnel.getInterface("emp_housethief")
---  // VARIABLES --
--  // ENTRY POINT 

local entrar = false
local assalto = true

-- //  SEARCHS
local abajur = true
local abajur2 = false
local abajur3 = false
local mesinha = true
local safrao = true
local livros = false
local book = false
local banheiro = false
local trocando = false

local casaspoint = 1 

local casas = {
	[1] = { ['x'] = 206.340, ['y'] = -85.69, ['z'] = 69.22 },
	[2] = { ['x'] = -41.371, ['y'] = -58.63, ['z'] = 63.65 },
	[3] = { ['x'] = -1107.68, ['y'] = 594.35, ['z'] = 104.45 },
	[4] = { ['x'] = -1808.03, ['y'] = 333.26, ['z'] = 89.56 },
	[5] = { ['x'] = -3089.40, ['y'] = 221.219, ['z'] = 14.11 },
	[6] = { ['x'] = -3229.05, ['y'] = 927.36, ['z'] = 13.96 },
	[7] = { ['x'] = -1886.570, ['y'] = 2050.12, ['z'] = 140.98 },
	[8] = { ['x'] = 1880.49, ['y'] = 3920.67, ['z'] = 33.21 },
	[9] = { ['x'] = 1663.95, ['y'] = 4739.57, ['z'] = 42.01 }
}

RegisterNetEvent('check')
AddEventHandler('check', function()
	FreezeEntityPosition(PlayerPedId(),true)
	TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_WELDING", 0, true)
	procent(70)
	TriggerServerEvent("vrp_sound",player)
	local random = math.random(100)

	if random >= 80 then
       TriggerServerEvent("marcarqth",player)
	end
	
	Citizen.Wait(8000)
	FreezeEntityPosition(PlayerPedId(),false)
    ClearPedTasksImmediately(PlayerPedId())
end)


Citizen.CreateThread( function()
	while true do
		if not assalto then
		casaspoint = emP.getCasapoint()
		end
		Citizen.Wait(120000)
	end
end)

local henrique = true
RegisterCommand("roubo",function(source,args)
	if args[1] == "casa" then 
		if not henrique then
		TriggerEvent("Notify","sucesso","Recebemos uma denuncia de roubo a ^1Residência^0.")
		henrique = true
		CriandoBlip(casas,casaspoint)
		SetTimeout(120000,function()
			RemoveBlip(blipsC)
			henrique = true
		end)
	else
		TriggerEvent("Notify","sucesso","Residência marcada no teu <b>GPS</b>.")
	end

	end

end)

Citizen.CreateThread(function()
	while true do
		Wait(1)
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),casas[casaspoint].x,casas[casaspoint].y,casas[casaspoint].z, true) <= 10.0 then	
		if entrar == false then
			DrawText3Ds(casas[casaspoint].x,casas[casaspoint].y,casas[casaspoint].z+0.5,"~b~[E]~s~ PARA ARROMBAR")
			if IsControlJustPressed(0, 38) then		
			  TriggerServerEvent("check",scr)
		    end
		else
           DrawText3Ds(-1.89,-1442.049,30.96+0.5,"~b~[E]~s~ PARA ASSALTAR")
		   if IsControlJustPressed(0, 38) then		
			DoScreenFadeOut(1000)
			Citizen.Wait(1500)
			SetEntityCoords(PlayerPedId(), 346.76,-1011.75,-99.196)
			Citizen.Wait(1000)
			DoScreenFadeIn(1000)
			assalto = true
			end
		end	
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 346.76,-1011.75,-99.196, true) <= 1.0 then	
		if assalto == true then
		
           DrawText3Ds(346.76,-1011.75,-99.196+0.5,"~r~[E]~s~ CANCELAR ASSALTO")
		   if IsControlJustPressed(0, 38) then		
			DoScreenFadeOut(1000)
			
			Citizen.Wait(1000)
			SetEntityCoords(PlayerPedId(), casas[casaspoint].x,casas[casaspoint].y,casas[casaspoint].z)
			Citizen.Wait(1000)
			DoScreenFadeIn(1000)
			assalto = false
			abajur = false
			entrar = false
			abajur2 = false
 			abajur3 = false
			mesinha = false
			safrao = false
			livros = false
			book = false
			banheiro = false 
		   end
		end
		end
	end
end)
--  // SEARCH POINT / STEP - ABAJUR
Citizen.CreateThread(function()
	while true do
		Wait(1) 
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 346.10668945313,-1001.5721435547,-99.196266174316, true) <= 1.0 then	
		if assalto == true then

	    if abajur == false then

			DrawText3Ds(346.10668945313,-1001.5721435547,-99.196266174316+0.5,"~g~[E]~s~ PROCURAR")
		  		 if IsControlJustPressed(0, 38) then		
				  TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
                  FreezeEntityPosition(PlayerPedId(),true)
				  TriggerServerEvent("searchabajur",scr)
				  procent(50)
                  Citizen.Wait(800)
                  FreezeEntityPosition(PlayerPedId(),false)
                  ClearPedTasksImmediately(PlayerPedId())
				  abajur = true
		  		 end
				 else
	      	DrawText3Ds(346.10668945313,-1001.5721435547,-99.196266174316+0.5,"~r~VAZIO")
			end
	    end
		end
	end
end)
--  // SEARCH POINT / STEP - ABAJUR 2
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		
		if assalto == true then
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 350.89041137695,-999.31005859375,-99.196266174316, true) <= 1.0 then	

	       if abajur2 == false then
          		 DrawText3Ds(350.89041137695,-999.31005859375,-99.196266174316+0.5,"~g~[E]~s~ PROCURAR")
		  		 if IsControlJustPressed(0, 38) then		
				  TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
				  procent(50)
                  FreezeEntityPosition(PlayerPedId(),true)
				  TriggerServerEvent("searchabajur2",scr)
                  Citizen.Wait(800)
                  FreezeEntityPosition(PlayerPedId(),false)
                  ClearPedTasksImmediately(PlayerPedId())
				  abajur2 = true
		  		 end
				 else

				DrawText3Ds(350.89041137695,-999.31005859375,-99.196266174316+0.5,"~r~VAZIO")
				   
			end
			
		
	    end
		end
	end
end)
--  // SEARCH POINT / STEP - ABAJUR 3

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		
		if assalto == true then
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 351.91787719727,-998.63232421875,-99.196266174316, true) <= 1.0 then	

	       if abajur3 == false then
          		 DrawText3Ds(351.91787719727,-998.63232421875,-99.196266174316+0.5,"~g~[E]~s~ PROCURAR")
		  		 if IsControlJustPressed(0, 38) then		
				  TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
				  procent(50)
                  FreezeEntityPosition(PlayerPedId(),true)
				  TriggerServerEvent("searchabajur3",scr)
                  Citizen.Wait(800)
                  FreezeEntityPosition(PlayerPedId(),false)
                  ClearPedTasksImmediately(PlayerPedId())
				  abajur3 = true
		  		 end
				 else
	      	     DrawText3Ds(351.91787719727,-998.63232421875,-99.196266174316+0.5,"~r~VAZIO")
			end
			
		
	    end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		
		if assalto == true then
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 339.27249145508,-1003.4240722656,-99.19620513916, true) <= 1.0 then	

	       if banheiro == false then
          		 DrawText3Ds(339.27249145508,-1003.4240722656,-99.19620513916+0.5,"~g~[E]~s~ PROCURAR")
		  		 if IsControlJustPressed(0, 38) then		
				  TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
				  procent(50)
                  FreezeEntityPosition(PlayerPedId(),true)
				  TriggerServerEvent("searchbanheiro",scr)
                  Citizen.Wait(800)
                  FreezeEntityPosition(PlayerPedId(),false)
                  ClearPedTasksImmediately(PlayerPedId())
				  banheiro = true
		  		 end
				 else
	      	     DrawText3Ds(339.27249145508,-1003.4240722656,-99.19620513916+0.5,"~r~VAZIO")
			end
	    end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		
		if assalto == true then
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 349.17443847656,-994.74621582031,-99.196159362793, true) <= 1.0 then	

	       if safrao == false then
          		 DrawText3Ds(349.17443847656,-994.74621582031,-99.196159362793+0.5,"~g~[E]~s~ PROCURAR")
		  		 if IsControlJustPressed(0, 38) then		
				  TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
				  procent(50)
                  FreezeEntityPosition(PlayerPedId(),true)
				  TriggerServerEvent("searchsafrao",scr)
                  Citizen.Wait(800)
                  FreezeEntityPosition(PlayerPedId(),false)
                  ClearPedTasksImmediately(PlayerPedId())
				  safrao = true
		  		 end
				 else
	      	     DrawText3Ds(349.17443847656,-994.74621582031,-99.196159362793+0.5,"~r~VAZIO")
			end
			
		
	    end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		
		if assalto == true then
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 338.10928344727,-994.98718261719,-99.196174621582, true) <= 1.0 then	

	       if livros == false then
          		 DrawText3Ds(338.10928344727,-994.98718261719,-99.196174621582+0.5,"~g~[E]~s~ PROCURAR")
		  		 if IsControlJustPressed(0, 38) then		
				  TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
				  procent(50)
                  FreezeEntityPosition(PlayerPedId(),true)
				  TriggerServerEvent("searchlivros",scr)
                  Citizen.Wait(800)
                  FreezeEntityPosition(PlayerPedId(),false)
                  ClearPedTasksImmediately(PlayerPedId())
				  livros = true
		  		 end
				 else
	      	     DrawText3Ds(338.10928344727,-994.98718261719,-99.196174621582+0.5,"~r~VAZIO")
			end
			
		
	    end
		end
	end
end)
--  // SEARCH POINT / STEP - BOOKS

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		
		if assalto == true then
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 338.21548461914,-998.12261962891,-99.196174621582, true) <= 1.0 then	

	       if book == false then
          		 DrawText3Ds(338.21548461914,-998.12261962891,-99.196174621582+0.5,"~g~[E]~s~ PROCURAR")
		  		 if IsControlJustPressed(0, 38) then		
				  TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
				  procent(50)
                  FreezeEntityPosition(PlayerPedId(),true)
				  TriggerServerEvent("searchbook",scr)
                  Citizen.Wait(800)
                  FreezeEntityPosition(PlayerPedId(),false)
                  ClearPedTasksImmediately(PlayerPedId())
				  book = true
		  		 end
				 else
	      	     DrawText3Ds(338.21548461914,-998.12261962891,-99.196174621582+0.5,"~r~VAZIO")
			end
	    end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		
		if assalto == true then
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 345.29925537109,-995.75347900391,-99.196174621582, true) <= 1.0 then	

	       if mesinha == false then
          		 DrawText3Ds(345.29925537109,-995.75347900391,-99.196174621582+0.5,"~g~[E]~s~ PROCURAR")
		  		 if IsControlJustPressed(0, 38) then		
				  TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
				  procent(50)
                  FreezeEntityPosition(PlayerPedId(),true)
				  TriggerServerEvent("searchmesinha",scr)
                  Citizen.Wait(800)
                  FreezeEntityPosition(PlayerPedId(),false)
                  ClearPedTasksImmediately(PlayerPedId())
				  mesinha = true
		  		 end
				 else
	      	     DrawText3Ds(345.29925537109,-995.75347900391,-99.196174621582+0.5,"~r~VAZIO")
			end
			
		
	    end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
    Citizen.Wait(6)
      if showPro == true then
    	  local playerPed = PlayerPedId()
		  local coords = GetEntityCoords(playerPed)
      	  DrawText3D(coords.x, coords.y, coords.z, TimeLeft .. '~g~%', 0.4)
      end
	end
end)

function procent(time)
  showPro = true
  TimeLeft = 0
  repeat
  TimeLeft = TimeLeft + 1  
  
  FreezeEntityPosition(PlayerPedId(),true)
                                
  Citizen.Wait(time)
  until(TimeLeft == 100)
  FreezeEntityPosition(PlayerPedId(),false)
  ClearPedTasksImmediately(PlayerPedId())
  showPro = false
  entrar = true
end

function DrawText3D(x, y, z, text, scale)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

  SetTextScale(scale, scale)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextEntry("STRING")
  SetTextCentre(1)
  SetTextColour(255, 255, 255, 255)
  SetTextOutline()

  AddTextComponentString(text)
  DrawText(_x, _y)

  local factor = (string.len(text)) / 270
  DrawRect(_x, _y + 0.015, 0.005 + factor, 0.03, 31, 31, 31, 155)
end


function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0,0,0, 68)
end


function CriandoBlip(casas,casaspoint)
	blipsC = AddBlipForCoord(casas[casaspoint].x,casas[casaspoint].y,casas[casaspoint].z)
	SetBlipSprite(blipsC,40)
	SetBlipColour(blipsC,6)
	SetBlipScale(blipsC,0.4)
	SetBlipAsShortRange(blipsC,true)
	SetBlipRoute(blipsC,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Casa Roubável")
	EndTextCommandSetBlipName(blipsC)
end
