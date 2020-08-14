local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
grC = Tunnel.getInterface("hkn_garages")
grg = {}
Tunnel.bindInterface("hkn_garages", grg)

local cfg = module("vrp_adv_garages", "cfg/garages")

vRP._prepare("vRP/getMyVehicles", "SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id")
vRP._prepare("vRP/getSpecificVehicle", "SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("vRP/setSpecificVehicle", "UPDATE vrp_user_vehicles SET engine = @engine, body = @body, fuel = @fuel WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("vRP/setDetained", "UPDATE vrp_user_vehicles SET detido = @detido, time = @time WHERE user_id = @user_id AND vehicle = @vehicle")

local idveh = {}
local insurerValue = 0.008
local detainedValue = 0.020

-----------------------------------------------------------------------------------------------------------------------------------------
-- EVENTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("hkn_garages:spawnVehicle")
AddEventHandler("hkn_garages:spawnVehicle", function(vehicle)
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
					--local data = vRP.getSData("custom:u"..user_id.."veh_"..vehicle)
					--local custom = json.decode(data) or ""
					local cond,netid,carname = grC.spawnGarageVehicle(source, vehicle, --[[custom,]] parseInt(rows[1].engine), parseInt(rows[1].body), parseInt(rows[1].fuel))
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

RegisterServerEvent("hkn_garages:despawnVehicle")
AddEventHandler("hkn_garages:despawnVehicle", function(vehicle)
	local source = source
	local user_id = vRP.getUserId(source)
	for _,vnet in pairs(idveh) do
		if vnet[1] == user_id and vnet[2] == vehicle then			
			grC.despawnGarageVehicle(source, vehicle)
		end
	end	
end)

RegisterServerEvent("hkn_garages:saveVehicle")
AddEventHandler("hkn_garages:saveVehicle", function(vnet, engine, body, fuel)	
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

RegisterServerEvent("hkn_garages:syncDelete")
AddEventHandler("hkn_garages:syncDelete", function(vnet)
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

function grg.rentVehicle(vehicle)
	if #vehicles > 0 then
		for i,k in pairs(vehicles) do
			if i == vehicle then
				local vehDetails = grg.searchVehicle(k.vehicle)
				if vRP.tryFullPayment(parseInt(vehDetails[2])) then
					return true
				end
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