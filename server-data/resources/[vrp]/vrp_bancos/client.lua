----------------------------------
------------ FUNÇÕES -------------
----------------------------------
function DrillAnimation() --ANIMAÇÃO DO MAÇARICO
	local playerPed = GetPlayerPed(-1)
	
	Citizen.CreateThread(function()
        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, false)               
	end)
end

function mycb(success, timeremaining) -- FUNÇÃO DO HACKEAR, NÃO MEXA!
	if success then
		print('Successo com '..timeremaining..'s restante.')
		TriggerEvent('mhacking:hide')
		TriggerEvent('chatMessage', 'SISTEMA', { 255, 69, 0 }, "Corra! Uma bomba explodira em alguns segundos.")
	    Citizen.Wait(15000)
	    AddExplosion(253.35618591309, 223.45489501953, 101.68347930908, 1, 1.0, 1, 0, 2.0)
	    Citizen.Wait(5000)
	    TriggerServerEvent('vrp_bancos:teleportar', source)
	else
		print('Falhou')
		TriggerEvent('mhacking:hide')
		TriggerEvent('chatMessage', 'SISTEMA', { 255, 69, 0 }, "Voce falhou em hackear o sistema do banco.")
	end
end

function bank_DisplayHelpText(str) --DESENHAR TEXTO
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function bank_drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline) --DESENHAR TEXTO
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

------------------------------
----------- LOCAL ------------
------------------------------
local banks = cfg.banks --LIGA AO BANK.LUA
local robbing = false
local bank = ""
local secondsRemaining = 0 --SEGUNDOS RESTANTES

local hackeando = false

local banconormal = false

----------------------------------
------------ EVENTS --------------
----------------------------------
RegisterNetEvent('vrp_bancos:muitolongelocal') --DISTÂNCIA DO BLIP
AddEventHandler('vrp_bancos:muitolongelocal', function(robb)
	robbing = false
	TriggerEvent('chatMessage', 'AVISO', { 255, 69, 0 }, "Você se afastou muito da área, por isso, o roubo foi cancelado.")
	robbingName = ""
	secondsRemaining = 0
	incircle = false
end)

RegisterNetEvent('vrp_bancos:jogadormorreulocal') --MORTE DO JOGADOR
AddEventHandler('vrp_bancos:jogadormorreulocal', function(robb)
	robbing = false
	TriggerEvent('chatMessage', 'AVISO', {255, 0, 0}, "Você morreu, o roubo foi cancelado.")
	robbingName = ""
	secondsRemaining = 0
	incircle = false
end)

RegisterNetEvent('vrp_bancos:hackermorreulocal') --MORTE DO JOGADOR (HACKER)
AddEventHandler('vrp_bancos:hackermorreulocal', function(robb)
	hackeando = false
	TriggerEvent('mhacking:hide')
	TriggerEvent('chatMessage', 'AVISO', {255, 0, 0}, "Você morreu, o processo de invasão foi cancelado.")
	robbingName = ""
	secondsRemaining = 0
	incircle = false
end)

-------------------------------
-------- THREADS & IFS --------
-------------------------------
Citizen.CreateThread(function() --SEGUNDOS RESTANTES
	while true do
		if robbing then
			Citizen.Wait(1000)
			if(secondsRemaining > 0)then
				secondsRemaining = secondsRemaining - 1
			end
		end

		Citizen.Wait(0)
	end
end)

if cfg.blips then -- BLIP DO MAPA
  Citizen.CreateThread(function()
	for k,v in pairs(banks)do
		local ve = v.blipposition

		local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
		SetBlipSprite(blip, 278)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Banco Roubável")
		EndTextCommandSetBlipName(blip)
	end
  end)
end
incircle = false
------------------------------------------------
------------------- COFRE ----------------------
------------------------------------------------
RegisterNetEvent('vrp_bancos:roubando') --COMEÇA O ROUBO + EXECUTA ANIMAÇÃO DO MAÇARICO
AddEventHandler('vrp_bancos:roubando', function(robb)
    robbing = true
    bank = robb
    secondsRemaining = cfg.seconds
    local pos = banks[bank].position
    TriggerServerEvent('robbaryInProgressPos', pos.x, pos.y, pos.z)
	DrillAnimation()
end)

RegisterNetEvent('vrp_bancos:completo') --COMPLETA O ROUBO + LIMPA ANIMAÇÃO
AddEventHandler('vrp_bancos:completo', function(reward)
	robbing = false
	TriggerEvent('chatMessage', 'GERENTE DO BANCO', { 255, 69, 0 }, "Aqui está o dinheiro, tem ^2R$ " .. reward .. "^0 neste saco.")
	bank = ""
	secondsRemaining = 0
	incircle = false
	ClearPedTasks(PlayerPedId())
end)

Citizen.CreateThread(function() -- THREAD DO COFRE
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		for k,v in pairs(banks)do
			local pos2 = v.position
            if (pos2 ~= nil) then
			    if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0)then
				    if not robbing then
					    DrawMarker(23, v.position.x, v.position.y, v.position.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)
					
					    if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 2)then
						    if (incircle == false) then
							    bank_DisplayHelpText("Pressione ~INPUT_CONTEXT~ para iniciar o roubo no ~b~" .. v.nameofbank .. "!")
						    end
						    incircle = true
						    if(IsControlJustReleased(1, 51))then
							    TriggerServerEvent('vrp_bancos:roubar', k)
						    end
					    elseif(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 2)then
						    incircle = false
					    end
				    end
			    end
			end
		end

		if robbing then
			
			bank_drawTxt(0.66, 1.44, 1.0,1.0,0.4, "Roubando o banco, faltam ~r~" .. secondsRemaining .. "~w~ segundos para abrir o cofre", 255, 255, 255, 255)
			
			local pos2 = banks[bank].position
			local ped = GetPlayerPed(-1)
			
            if IsEntityDead(ped) then
			TriggerServerEvent('vrp_bancos:jogadormorreu', bank)
			elseif (Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 15)then
				TriggerServerEvent('vrp_bancos:muitolonge', bank)
			end
		end

		Citizen.Wait(0)
	end
end)

------------------------------------------------
------------------- HACKER ---------------------
------------------------------------------------
RegisterNetEvent('vrp_bancos:hackeando') --COMEÇA A HACKEAR
AddEventHandler('vrp_bancos:hackeando', function(robb)
    hackeando = true
	TriggerEvent("mhacking:show")
    TriggerEvent("mhacking:start",7,30,mycb)
end)  

RegisterNetEvent('vrp_bancos:completohack') --COMPLETA O ROUBO + LIMPA ANIMAÇÃO
AddEventHandler('vrp_bancos:completohack', function()
	hackeando = false
	bank = ""
	secondsRemaining = 0
	incircle = false
end)

Citizen.CreateThread(function() -- THREAD DO HACKER
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		for k,v in pairs(banks)do
			local pos2 = v.hackearposition
		    if (pos2 ~= nil) then

			    if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0)then
				    if not hackeando then
					    DrawMarker(23, v.hackearposition.x, v.hackearposition.y, v.hackearposition.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)
					
					    if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 2)then
						    if (incircle == false) then
						    	bank_DisplayHelpText("Pressione ~INPUT_CONTEXT~ para começar a hackear o sistema de trancas do ~b~" .. v.nameofbank .. "!")
						    end
						    incircle = true
						    if(IsControlJustReleased(1, 51))then
						    	TriggerServerEvent('vrp_bancos:hackear', k)
						    end
					    elseif(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 2)then
					    	incircle = false
					    end
				    end
			    end
		    end
		end

		if hackeando then
			
			local ped = GetPlayerPed(-1)
            if IsEntityDead(ped) then
			TriggerServerEvent('vrp_bancos:hackermorreu', bank)
			end
		end

		Citizen.Wait(0)
	end
end)