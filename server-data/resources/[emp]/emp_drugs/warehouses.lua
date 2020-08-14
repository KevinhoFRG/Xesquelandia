local l = 0
local g = 0
local premisa = 0
local cocaina = 0
function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÃO COCAINA  
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------RegisterNetEvent('setCheckPos')
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if cocaina == 0 then
		DrawMarker(23, -1108.7979736328,4952.0249023438,218.64978027344-0.9701, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 13, 232, 255, 155, 0, 0, 2, 0, 0, 0, 0)
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1108.7979736328,4952.0249023438,218.64978027344, true) <= 1.0 then	
			DisplayHelpText("Pressione ~g~E~s~ para pegar os ~g~Reagentes")		
			if IsControlJustPressed(0, 38) then
cocaina = 1			
				DisplayHelpText("Pegando o ~g~Reagentes")
				TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_BUM_BIN", 0, true)
				Citizen.Wait(7000)
				DisplayHelpText("Você pegou os ~g~Reagentes")
				ClearPedTasksImmediately(GetPlayerPed(-1))
				TriggerServerEvent('receber:Cocaine')
			end
		end	
elseif cocaina == 1 then		
		DrawMarker(23, -1106.1357421875,4946.7099609375,218.64979553223-0.9701, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 13, 232, 255, 155, 0, 0, 2, 0, 0, 0, 0)
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1106.1357421875,4946.7099609375,218.64979553223, true) <= 1.0 then	
			DisplayHelpText("Pressione ~g~E~s~ para separar a solução dos ~g~reagentes")		
			if IsControlJustPressed(0, 38) then		
			cocaina = 2
				DisplayHelpText("Separando os ~g~Reagentes")
				TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_PARKING_METER", 0, true)
				Citizen.Wait(6000)
				DisplayHelpText("Você separou os ~g~Reagentes")
				ClearPedTasksImmediately(GetPlayerPed(-1))
				TriggerServerEvent('processar:Cocaine')
			end
		end
elseif cocaina == 2 then
		DrawMarker(23, -1107.1978759766,4941.6489257813,218.64979553223-0.9701, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 13, 232, 255, 155, 0, 0, 2, 0, 0, 0, 0)
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1107.1978759766,4941.6489257813,218.64979553223, true) <= 1.0 then	
			DisplayHelpText("Pressione ~g~E~s~ para limpar a ~g~Cocaina")		
			if IsControlJustPressed(0, 38) then		
			cocaina = 3
				DisplayHelpText("Limpando a ~g~Cocaina")
				TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_PARKING_METER", 0, true)
				Citizen.Wait(5000)
				DisplayHelpText("Você limpou a ~g~Cocaina")
				ClearPedTasksImmediately(GetPlayerPed(-1))
				TriggerServerEvent('limpar:Solucao')
			end
		end
elseif cocaina == 3 then
		DrawMarker(23, -1111.8142089844,4942.3784179688,218.64979553223-0.9701, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 13, 232, 255, 155, 0, 0, 2, 0, 0, 0, 0)
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1111.8142089844,4942.3784179688,218.64979553223, true) <= 1.0 then	
			DisplayHelpText("Pressione ~g~E~s~ para embalar a ~g~Cocaína")		
			if IsControlJustPressed(0, 38) then		
			cocaina = 0
				DisplayHelpText("Embalando a ~g~Cocaína")
				TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_BUM_BIN", 0, true)
				Citizen.Wait(7000)
				DisplayHelpText("Você embalou a ~g~Solução")
				ClearPedTasksImmediately(GetPlayerPed(-1))
				TriggerServerEvent('embalar:Cocaine')
			end
		end
		end
	end
end)

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÃO METANFETAMINA
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------RegisterNetEvent('setCheckPos')
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if premisa == 0 then
			DrawMarker(23, 1505.5209960938,6392.111328125,20.783918380737-0.9701, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 13, 232, 255, 155, 0, 0, 2, 0, 0, 0, 0)
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1505.5209960938,6392.111328125,20.783918380737, true) <= 1.0 then	
				DisplayHelpText("Pressione ~g~E~s~ para pegar os ~g~Reagentes")		
				if IsControlJustPressed(0, 38) then		
					premisa = 1
					DisplayHelpText("Pegando o ~g~Reagentes")
					TaskStartScenarioInPlace(GetPlayerPed(-1), "prop_human_bum_bin", 0, true)
					Citizen.Wait(7000)
					DisplayHelpText("Você pegou os ~g~Reagentes")
					ClearPedTasksImmediately(GetPlayerPed(-1))
					TriggerServerEvent('receber:Reagentes')
				end
			end
		elseif premisa == 1 then
			DrawMarker(23, 1493.416015625,6390.2421875,21.257762908936-0.9701, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 13, 232, 255, 155, 0, 0, 2, 0, 0, 0, 0)
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1493.416015625,6390.2421875,21.257762908936, true) <= 1.0 then	
				DisplayHelpText("Pressione ~g~E~s~ para processar os ~g~reagentes")		
				if IsControlJustPressed(0, 38) then		
					premisa = 2
					DisplayHelpText("Processando os ~g~Reagentes")
					TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_BUM_BIN", 0, true)
					Citizen.Wait(6000)
					DisplayHelpText("Você processou os ~g~Reagentes")
					ClearPedTasksImmediately(GetPlayerPed(-1))
					TriggerServerEvent('processar:Reagentes')
				end
			end
		elseif premisa == 2 then
			DrawMarker(23, 1502.8494873047,6393.55859375,20.783916473389-0.9701, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 13, 232, 255, 155, 0, 0, 2, 0, 0, 0, 0)
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1502.8494873047,6393.55859375,20.783916473389, true) <= 1.0 then	
				DisplayHelpText("Pressione ~g~E~s~ para limpar a ~g~Metanfetamina")		
				if IsControlJustPressed(0, 38) then		
					premisa = 0	
					DisplayHelpText("Limpando a ~g~Metanfetamina")
					TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_PARKING_METER", 0, true)
					Citizen.Wait(6000)
					DisplayHelpText("Você limpou a ~g~Metanfetamina")
					ClearPedTasksImmediately(GetPlayerPed(-1))
					TriggerServerEvent('limpar:Reagentes')
				end
			end
		end
	end
end)

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÃO MACONHA
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------RegisterNetEvent('setCheckPos')

l = math.random(1,9)
g = math.random(1,3)

Citizen.CreateThread(function()
	while true do
		Wait(0)
		DrawMarker(23, 104.21949768066,6337.7036132813,31.500224685669-0.9701, 0, 0, 0, 0, 0, 0, 6.0, 6.0, 5.0, 13, 232, 255, 155, 0, 0, 5, 0, 0, 0, 0)
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 104.21949768066,6337.7036132813,31.400224685669, true) <= 1.0 then	
			DisplayHelpText("Pressione ~g~E~s~ para colher o ~g~Cannabis")		
			if IsControlJustPressed(0, 38) then		
				DisplayHelpText("Pegando o ~g~Cannabis")
				TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_GARDENER_PLANT", 0, true)
				Citizen.Wait(10000)
				ClearPedTasksImmediately(GetPlayerPed(-1))
				TriggerServerEvent('receber:Maconha')
				l = math.random(1,9)
			end
		end		

		DrawMarker(23, 99.263763427734,6346.849609375,31.375881195068-0.9701, 0, 0, 0, 0, 0, 0, 6.0, 6.0, 5.0, 13, 232, 255, 155, 0, 0, 5, 0, 0, 0, 0)
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 99.263763427734,6346.849609375,31.375881195068, true) <= 1.0 then	
			DisplayHelpText("Pressione ~g~E~s~ para colher o ~g~Cannabis")		
			if IsControlJustPressed(0, 38) then		
				DisplayHelpText("Pegando o ~g~Cannabis")
				TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_GARDENER_PLANT", 0, true)
				Citizen.Wait(10000)
				ClearPedTasksImmediately(GetPlayerPed(-1))
				TriggerServerEvent('receber:Maconha')
				l = math.random(1,9)
			end
		end		
		

		DrawMarker(27, 113.23827362061,6360.431640625,32.407746887207-0.9701, 0, 0, 0, 0, 0, 0, 4.0, 4.0, 1.0, 13, 232, 255, 155, 0, 0, 2, 0, 0, 0, 0)
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 113.23827362061,6360.431640625,32.307746887207, true) <= 1.0 then	
			DisplayHelpText("Pressione ~g~E~s~ para processar o ~g~Cannabis")		
			if IsControlJustPressed(0, 38) then		
				DisplayHelpText("Processando o ~g~Cannabis")
				TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_PARKING_METER", 0, true)
				Citizen.Wait(10000)
				ClearPedTasksImmediately(GetPlayerPed(-1))
				TriggerServerEvent('processar:Maconha')
				l = math.random(1,9)
			end
		end
	end
end)


RegisterNetEvent('roxos:permissao')
AddEventHandler('roxos:permissao', function()
loadWeed()
end)

RegisterNetEvent('amarelos:permissao')
AddEventHandler('amarelos:permissao', function()
loadMeta()
end)

RegisterNetEvent('verdes:permissao')
AddEventHandler('verdes:permissao', function()
loadCoke()
end)

RegisterNetEvent('sem:espaco')
AddEventHandler('sem:espaco', function()
	DisplayHelpText("Seu inventário está cheio irmão..")
	vRP.notify("~r~Seu invetário está cheio irmão..")
end)

RegisterNetEvent('sem:maconha')
AddEventHandler('sem:maconha', function()
	vRP.notify("~r~Você não tem permissão para colher isso.")
end)
RegisterNetEvent('sem:cannabis')
AddEventHandler('sem:cannabis', function()
	vRP.notify("~r~Você não tem permissão para colher isso.")
end)

function loadLavagem()
		local ped = GetPlayerPed(-1)
		local playerCoords = GetEntityCoords(GetPlayerPed(-1), true)
		DoScreenFadeOut(1000)
		Citizen.Wait(1500)
		SetEntityCoords(GetPlayerPed(-1), 1137.9711914063,-3196.814453125,-39.665672302246)
		DoScreenFadeIn(1000)
end
function loadWeed()
		local ped = GetPlayerPed(-1)
		local playerCoords = GetEntityCoords(GetPlayerPed(-1), true)
		DoScreenFadeOut(1000)
		Citizen.Wait(1500)
		SetEntityCoords(GetPlayerPed(-1), 1065.6181640625,-3183.4802246094,-39.163505554199)
		DoScreenFadeIn(1000)
end

function loadBlanqueo()
		local ped = GetPlayerPed(-1)
		local playerCoords = GetEntityCoords(GetPlayerPed(-1), true)
		DoScreenFadeOut(1000)
		Citizen.Wait(1500)
		SetEntityCoords(GetPlayerPed(-1), 1118.683, -3193.319, -40.391)
		DoScreenFadeIn(1000)
end

function loadMeta()
		local ped = GetPlayerPed(-1)
		local playerCoords = GetEntityCoords(GetPlayerPed(-1), true)
		DoScreenFadeOut(1000)
		Citizen.Wait(1500)
		SetEntityCoords(GetPlayerPed(-1), 996.8969116211,-3200.6459960938,-36.39372253418)
		DoScreenFadeIn(1000)
end

function loadCoke()
		local ped = GetPlayerPed(-1)
		local playerCoords = GetEntityCoords(GetPlayerPed(-1), true)
		DoScreenFadeOut(1000)
		Citizen.Wait(1500)
		SetEntityCoords(GetPlayerPed(-1), 1088.803, -3188.257, -38.993)
		DoScreenFadeIn(1000)
end

function loadMotero()
		local ped = GetPlayerPed(-1)
		local playerCoords = GetEntityCoords(GetPlayerPed(-1), true)
		DoScreenFadeOut(1000)
		Citizen.Wait(1500)
		SetEntityCoords(GetPlayerPed(-1), 996.97509765625,-3157.9213867188,-38.907146453858)
		DoScreenFadeIn(1000)
end