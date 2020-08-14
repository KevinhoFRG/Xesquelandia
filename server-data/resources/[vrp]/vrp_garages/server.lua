local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
grC = Tunnel.getInterface("vrp_garages")
grg = {}
Tunnel.bindInterface("vrp_garages", grg)

local cfg = module("vrp_garages","cfg/cars")
local cfg_inventory = module("vrp","cfg/inventory")

vRP._prepare("vRP/getMyVehicles", "SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id")
vRP._prepare("vRP/getSpecificVehicle", "SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("vRP/setSpecificVehicle", "UPDATE vrp_user_vehicles SET engine = @engine, body = @body, fuel = @fuel WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("vRP/setDetained", "UPDATE vrp_user_vehicles SET detido = @detido, time = @time WHERE user_id = @user_id AND vehicle = @vehicle")

local idveh = {}
local insurerValue = 0.018
local detainedValue = 0.060

-----------------------------------------------------------------------------------------------------------------------------------------
-- EVENTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vrp_garages:spawnVehicle")
AddEventHandler("vrp_garages:spawnVehicle", function(vehicle)
	local source = source
	local user_id = vRP.getUserId(source)
	local rows = vRP.query("vRP/getSpecificVehicle", { user_id = user_id, vehicle = vehicle })
	if #rows > 0 then
		local vehDetails = grg.searchVehicle(vehicle)
		if vehDetails ~= nil then
			if rows[1].detido == 1 then
				grC.closeNUI(source)
				if parseInt(rows[1].time) == 0 then
					value = parseInt(vehDetails[2]*insurerValue)
					ok = vRP.request(source, 'Veículo roubado, deseja acionar o seguro pagando <b>$'..vRP.format(value)..'</b> dólares?', 60)					
				else
					value = parseInt(vehDetails[2]*detainedValue)
					ok = vRP.request(source, 'Veículo detido, deseja liberar pagando <b>$'..vRP.format(value)..'</b> dólares?', 60)					
				end				
				if ok then
					if vRP.tryFullPayment(user_id, value) then					
						vRP.execute("vRP/setDetained", { user_id = user_id, vehicle = vehicle, detido = 0, time = 0 })
						TriggerClientEvent('Notify', source, 'sucesso', 'Veículo liberado.')
					else
						TriggerClientEvent('Notify', source, 'negado', 'Dinheiro insuficiente.')
					end
				end
			else
				local vehState,netid,carname = grC.checkInStreet(source, vehicle)
				if not vehState then				
					local data = vRP.getSData("custom:u"..user_id.."veh_"..vehicle)
					local custom = json.decode(data) or ""
					local cond,netid,carname = grC.spawnGarageVehicle(source, vehicle, custom, parseInt(rows[1].engine), parseInt(rows[1].body), parseInt(rows[1].fuel))
					if cond then
						idveh[netid] = { user_id, carname }
					else
						TriggerClientEvent('Notify', source, 'aviso', 'Você já tem um veículo deste modelo fora da garagem.')
					end
				else
					idveh[netid] = { user_id, carname }
					TriggerClientEvent('Notify', source, 'aviso', 'Você já tem um veículo deste modelo fora da garagem.')
				end
			end			
		else
			TriggerClientEvent('Notify', source, 'negado', 'Veículo não encontrado!')
		end
	end	
end)

RegisterServerEvent("vrp_garages:spawnVehicle2")
AddEventHandler("vrp_garages:spawnVehicle2", function(vehicle,preco)
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.tryFullPayment(user_id, tonumber(preco)) then
		local vehState,netid,carname = grC.checkInStreet(source, vehicle)
		if not vehState then				
			local cond,netid,carname = grC.spawnGarageVehicle(source, vehicle, nil, 1000, 1000, 100)
			if cond then
				idveh[netid] = { user_id, carname }
			else
				TriggerClientEvent('Notify', source, 'aviso', 'Você já tem um veículo deste modelo fora da garagem.')
			end
		else
			idveh[netid] = { user_id, carname }
			TriggerClientEvent('Notify', source, 'aviso', 'Você já tem um veículo deste modelo fora da garagem.')
		end
	else
		TriggerClientEvent('Notify', source, 'aviso', 'Você não possui dinheiro para alugar esse veículo.')
	end	
end)

RegisterServerEvent("vrp_garages:despawnVehicle")
AddEventHandler("vrp_garages:despawnVehicle", function(vehicle)
	local source = source
	local user_id = vRP.getUserId(source)
	for _,vnet in pairs(idveh) do
		if vnet[1] == user_id and vnet[2] == vehicle then			
			grC.despawnGarageVehicle(source, vehicle)
		end
	end	
end)

RegisterServerEvent("vrp_garages:admDelete")
AddEventHandler("vrp_garages:admDelete",function(vnet)
	if idveh[vnet] and vnet ~= 0 then
		local user_id = idveh[vnet][1]
		local carname = idveh[vnet][2]
		local player = vRP.getUserSource(user_id)
		if player then
			grC.despawnGarageVehicle(player,carname)
		end
	end
	grC.deleteVehicle(-1,vnet)
end)


RegisterServerEvent("vrp_garages:saveVehicle")
AddEventHandler("vrp_garages:saveVehicle", function(vnet, engine, body, fuel)	
	local source = source
	local user_id = vRP.getUserId(source)
	local rows = vRP.query("vRP/getSpecificVehicle", { user_id = user_id, vehicle = idveh[vnet][2] })
	if #rows > 0 then
		if engine < 0 then engine = 0 end
		if body < 0 then body = 0 end
		if fuel > 100 then fuel = 100 end
		vRP.execute("vRP/setSpecificVehicle", { user_id = user_id, vehicle = idveh[vnet][2], engine = parseInt(engine), body = parseInt(body), fuel = parseInt(fuel) })
		idveh[vnet] = nil
	end
end)

RegisterServerEvent("vrp_garages:syncDelete")
AddEventHandler("vrp_garages:syncDelete", function(vnet)
	if vnet then
		grC.syncDelete(-1, vnet)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function grg.getVehicles()
	local source = source
	local user_id = vRP.getUserId(source)
	local vehicles = vRP.query("vRP/getMyVehicles", {user_id = user_id})
	if #vehicles > 0 then
		for i,k in pairs(vehicles) do
			local vehDetails = grg.searchVehicle(k.vehicle)		
			if k.detido == 1 then
				if parseInt(k.time) == 0 then
					k.detido = '$'..vRP.format(parseInt(vehDetails[2]*insurerValue))
				else
					k.detido = '$'..vRP.format(parseInt(vehDetails[2]*detainedValue))								
				end
			else
				k.detido = 'Não necessario!'
			end
			k.preco = vRP.format(parseInt(vehDetails[2]))
		end
		return vehicles
	end
	return nil
end

function grg.getGVehicles(currentGarage)
	local source = source
	local cars = {}
	local user_id = vRP.getUserId(source)
	for _,value in pairs(cfg.garage_types) do
		local con = false
		for x,y in pairs(currentGarage) do
			if y:lower() == _:lower() then
				con = true
			end
		end
		
		if con then
			local p = nil
			for i,k in pairs(value) do
				if i ~= "_config" then
					if _ == "Motorista" or _ == "Carteiro" or _ == "Lixeiro" or _ == "Bicicletario" or _ == "Embarcacoes" or _ == "Garimpeiro" or _ == "Caminhao" then
						 p = true
						table.insert(cars, {vehicle = i, preco = k[2]})
					elseif _ == "Taxista" and vRP.hasPermission(user_id,"taxista.permissao") then
						p = true
						table.insert(cars, {vehicle = i, preco = k[2]})
					elseif _ == "Policia" and vRP.hasPermission(user_id,"policia.permissao") then
						p = true
						table.insert(cars, {vehicle = i, preco = k[2]})
					elseif _ == "PoliciaB" and vRP.hasPermission(user_id,"policia.permissao") then
						p = true
						table.insert(cars, {vehicle = i, preco = k[2]})
					elseif _ == "PoliciaH" and vRP.hasPermission(user_id,"policia.permissao") then
						p = true
						table.insert(cars, {vehicle = i, preco = k[2]})
					elseif _ == "Paramedico" and vRP.hasPermission(user_id,"paramedico.permissao") then
						p = true
						table.insert(cars, {vehicle = i, preco = k[2]})		
					elseif _ == "ParamedicoH" and vRP.hasPermission(user_id,"paramedico.permissao") then
						p = true
						table.insert(cars, {vehicle = i, preco = k[2]})
					elseif _ == "Motoclube" and vRP.hasPermission(user_id,"motoclub.permissao") then
						p = true
					    table.insert(cars, {vehicle = i, preco = k[2]})
					elseif _ == "Groove" and vRP.hasPermission(user_id,"grove.permissao") then
						p = true	
						table.insert(cars, {vehicle = i, preco = k[2]})		
					elseif _ == "Ballas" and vRP.hasPermission(user_id,"ballas.permissao") then
						p = true
						table.insert(cars, {vehicle = i, preco = k[2]})		
					elseif _ == "Vagos" and vRP.hasPermission(user_id,"vagos.permissao") then
						p = true	
					    table.insert(cars, {vehicle = i, preco = k[2]})		
					elseif _ == "Yakuza" and vRP.hasPermission(user_id,"yakuza.permissao") then
						p = true	
					    table.insert(cars, {vehicle = i, preco = k[2]})		
					elseif _ == "Russa" and vRP.hasPermission(user_id,"russa.permissao") then
						p = true	
					    table.insert(cars, {vehicle = i, preco = k[2]})		
					elseif _ == "Corleone" and vRP.hasPermission(user_id,"mafia.permissao") then
						p = true
					    table.insert(cars, {vehicle = i, preco = k[2]})		
					elseif _ == "VipPlatinaH" and vRP.hasPermission(user_id,"platina.permissao") then						
					
						table.insert(cars, {vehicle = i, preco = k[2]})
					else p = false end
					if p == nil then
						table.insert(cars, {vehicle = i, preco = k[2]})
					end
				end
			end
		end
	end
	return cars
end

function grg.rentVehicle(vehicle)
	local source = source
	local user_id = vRP.getUserId(source)
		for i,k in pairs(vehicles) do
			if i == vehicle then
				local vehDetails = grg.searchVehicle(k.vehicle)
				if vRP.tryFullPayment(parseInt(vehDetails[2])) then
					return true
				end
			end
		end
	return false
end

function grg.searchVehicle(vehicle)
	for _,value in pairs(cfg.garage_types) do
		for i,k in pairs(value) do
			if i == vehicle then
				return k
			end
		end
	end
	return nil
end
