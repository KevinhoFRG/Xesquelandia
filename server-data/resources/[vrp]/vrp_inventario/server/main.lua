local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_inventario")
Dclient = Tunnel.getInterface("vrp_inventario")
local cfg_inventory = module("vrp","cfg/inventory")
local cfg_homes = module("vrp","cfg/homes")


local openInventory = {}

RegisterServerEvent("vrp_inventarios:openGui")
AddEventHandler("vrp_inventarios:openGui",function(user_id,dt,name,pName, style)
	local player = vRP.getUserSource(user_id)
	TriggerClientEvent("vrp_inventario:openGui", player, dt, name, pName, style)
end)

RegisterServerEvent("vrp_inventario:openGui")
AddEventHandler("vrp_inventario:openGui",function(dt,name,pName, style)
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local data = nil
	local pdata = nil
	local pinventory = {}
	local inventory = {}
	if name ~= "home" then
		name = "chest:".."u"..user_id.."veh_"..name
	end
	
	pdata = vRP.getUserDataTable(user_id)
	pdata = pdata.inventory
	
	if dt >= 2 then --inventario carro
		data = vRP.getSData(name)
		if data == "" then data = {} end
	end
	
	if pdata then
		if type(pdata) == "string" then pdata = json.decode(pdata) end
		if type(items) == "string" then items = json.decode(items) end
		for data_k, data_v in pairs(pdata) do
			for items_k, items_v in pairs(items) do
				if data_k == items_k then
					local item_name = vRP.getItemName(data_k)
					local itemWeight = vRP.getItemWeight(data_k)*data_v.amount
					if item_name then
						table.insert(pinventory,
						{
							name = item_name,
							amount = data_v.amount,
							item_peso = itemWeight,
							idname = data_k,
							icon = items_v[5]
						}
						)
					end
				end
			end
		end
	end
	
	if data then
		if type(data) == "string" then data = json.decode(data) end
		if type(items) == "string" then items = json.decode(items) end
		for data_k, data_v in pairs(data) do
			for items_k, items_v in pairs(items) do
				if data_k == items_k then
					local item_name = vRP.getItemName(data_k)
					local itemWeight = vRP.getItemWeight(data_k)*data_v.amount
					if item_name then
						table.insert(inventory,
						{
							name = item_name,
							amount = data_v.amount,
							item_peso = itemWeight,
							idname = data_k,
							icon = items_v[5]
						})
					end
				end
			end
		end
	end
		
	local weight = 0
	local maxWeight = 0
	local iWeight = 0
	local iMaxWeight = 0
	weight = vRP.getInventoryWeight(user_id)
	maxWeight = vRP.getInventoryMaxWeight(user_id)
	
	if dt > 1 then
		iWeight = vRP.getInventoryWeightDataReady(data)
	end
	
	if dt == 2 then
		iMaxWeight = cfg_inventory.vehicle_chest_weights[string.lower(pName)] or 50
	elseif dt == 3 then
		iMaxWeight = cfg_homes.slot_types[string.lower(pName)] or 200
	end
	
	if dt == 1 then
        local weapons = vRPclient.getWeapons(player)
        for k,v in pairs(weapons) do
            local item_name = vRP.getItemName("wbody|"..k)
            table.insert(inventory,
                {
                    id = item_name,
                    icon = items["wbody|"..k][5],
                    nome = vRP.getItemName("wbody|"..k),
                    municao = parseInt(v.ammo)
                }
            )
        end
	end
	
	TriggerClientEvent("vrp_inventario:updateInventory", player, pinventory, inventory, weight, maxWeight, iWeight, iMaxWeight, {name, pName, dt}, style)
end)

RegisterServerEvent("vrp_inventario:storeAll")
AddEventHandler("vrp_inventario:storeAll",function(args)
local user_id = vRP.getUserId(source)
if user_id then
	local weapons = vRPclient.replaceWeapons(source,{})
	for k,v in pairs(weapons) do
		vRP.giveInventoryItem(user_id,"wbody|"..k,1)
		if v.ammo > 0 then
			vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
		end
	end
	TriggerClientEvent("Notify",source,"sucesso","Guardou seu armamento na mochila.")
end
end)


RegisterServerEvent("vrp_inventario:useItem")
AddEventHandler("vrp_inventario:useItem",function(args)
	local data = args
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	
	if data.idname then
		for k, v in pairs(items) do
			if data.idname == k then
				useItem(user_id, player, k, v[1], v[2], v[3], v[4], data.amount, data.dataType)
			end
		end
	end
end)

RegisterServerEvent("vrp_inventario:putItem")
AddEventHandler("vrp_inventario:putItem",function(args)
	local data = args
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if data.idname then
		for k, v in pairs(items) do
			if data.idname == k then
				if vRP.tryGetInventoryItem(user_id, data.idname, data.amount, {data.dataType[1], data.dataType[2], 1}) then
					if data.dataType[3] == 2 then
						data.dataType[4] = cfg_inventory.vehicle_chest_weights[string.lower(data.dataType[2])] or 50
					elseif data.dataType[3] == 3 then
						data.dataType[4] = cfg_homes.slot_types[string.lower(data.dataType[2])] or 200
					end
					vRP.giveInventoryItem(user_id, data.idname, data.amount, data.dataType)
				end
			end
		end
	end
end)

RegisterServerEvent("vrp_inventario:takeItem")
AddEventHandler("vrp_inventario:takeItem",function(args)
	local data = args
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if data.idname then
		for k, v in pairs(items) do
			if data.idname == k then
				if vRP.tryGetInventoryItem(user_id, data.idname, data.amount, data.dataType) then
					vRP.giveInventoryItem(user_id, data.idname, data.amount, {data.dataType[1], data.dataType[2], 1, vRP.getInventoryMaxWeight(user_id)})
				end
			end
		end
	end
end)

RegisterServerEvent("vrp_inventario:dropItem")
AddEventHandler("vrp_inventario:dropItem",function(data)
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local amount = parseInt(data.amount)
	local peso = true
	local idname = data.idname
	local px,py,pz = vRPclient.getPosition(source)
	if vRPclient.isInComa(player) then
		vRPclient.notify(player,"Você está em coma.")
	else
		if idname == "mochila" then		
			peso = vRP.setMochila(user_id,0)
		end
		if peso then
			if vRP.tryGetInventoryItem(user_id, data.idname, amount, data.dataType) then
				TriggerClientEvent("vrp_inventario:closeGui", player)
				TriggerEvent("DropSystem:create", idname, amount, px,py,pz) 
				vRPclient.playAnim(player, true, {{"pickup_object", "pickup_low", 1}}, false)
				TriggerClientEvent('xpk_inventory:test',source,'test')
				
			else
				TriggerClientEvent("Notify",player,"negado","Ocorreu um problema.")
			end
		else
			TriggerClientEvent("Notify",player,"negado","Esvazie a mochila primeiro.")
		end	
	end 
end)


function split(str, sep)
	local array = {}
	local reg = string.format("([^%s]+)", sep)
	for mem in string.gmatch(str, reg) do
		table.insert(array, mem)
	end
	return array
end

local bandagem = {}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(bandagem) do
			if v > 0 then
				bandagem[k] = v - 1
			end
		end
	end
end)
function useItem(user_id, player, idname, type, varyhealth, varyThirst, varyHunger, amount, dataType)
	if vRPclient.isInComa(player) then
		TriggerClientEvent("Notify",player,"negado","Você está em coma.")
		
	else
		if type == "weapon" or type == "ammo" or type == "mochila" or type == "maconha" or type == "energetico" or type == "pao" or type == "chocolate" or type == "salgadinho" or type == "colete" or type == "rosquinha" or type == "pizza" or type == "sanduiche" or type == "agua" or type == "cafe" or type == "limonada"  or type == "refrigerante" or type == "cerveja" or type == "absinto" or type == "tequila" or type == "vodka" or type == "conhaque" or type == "whisky" or type == "bandagem" or type == "cocaina"or type == "heroina" or type == "lockpick" or type == "capuz" or type == "masterpick" then
			
			if type == "weapon" then
				if vRP.tryGetInventoryItem(user_id, idname, tonumber(amount),dataType) then
					local fullidname = split(idname, "|")
					vRPclient.giveWeapons(
					player,
					{
						[fullidname[2]] = {ammo = 0}
					},
					false
					)
				end
			end
			if type == "ammo" then
				local fullidname = split(idname, "|")
				local exists = false
				local weapons = vRPclient.getWeapons(player)
				for k, v in pairs(weapons) do
					if k == fullidname[2] then
						exists = true
					end
				end
				if exists == true then
					if vRP.tryGetInventoryItem(user_id, idname, tonumber(amount),dataType) then
						vRPclient.giveWeapons(
						player,
						{
							[fullidname[2]] = {ammo = tonumber(amount)}
						},
						false
						)
					end
				else
					TriggerClientEvent("Notify",player,"negado","Você não tem a arma para essa munição.") 
				end
				
			end
			if type == "mochila" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"mochila",1,dataType) then
					vRP.varyExp(user_id,"physical","strength",650)
					TriggerClientEvent("Notify",player,"sucesso","Mochila utilizada com sucesso.")
					TriggerClientEvent('colocar:mochila',player)
				else
					TriggerClientEvent("Notify",player,"negado","Mochila não encontrada na mochila.")
				end 
			end 
			if type == "hamburguer" then
				if vRP.tryGetInventoryItem(user_id,"hamburguer",1,dataType) then
					TriggerClientEvent("Notify",player,"aviso","Comendo Hamburguer.")
					play_f1(player)
					
					SetTimeout(10000,function()
						vRPclient._stopAnim(player,true)
						vRPclient._stopAnim(player,false) 
						Dclient.playMovement(player,"MOVE_M@DRUNK@SLIGHTLYDRUNK",true,true,false,false)
						Dclient.playScreenEffect(player, "DMT_flight", 120) 
					end)
					SetTimeout(120000,function()
						Dclient.resetMovement(player,false) 
					end)
				end
			end 
			if type == "maconha" then
				if vRP.tryGetInventoryItem(user_id,"maconha",1,dataType) then
					TriggerClientEvent("Notify",player,"aviso","Fumando Maconha.")
					play_f1(player)
					
					SetTimeout(10000,function()
						vRPclient._stopAnim(player,true)
						vRPclient._stopAnim(player,false) 
						Dclient.playMovement(player,"MOVE_M@DRUNK@SLIGHTLYDRUNK",true,true,false,false)
						Dclient.playScreenEffect(player, "DMT_flight", 120) 
					end)
					SetTimeout(120000,function()
						Dclient.resetMovement(player,false) 
					end)
				end
			end
			if type == "bandagem" then
				local source = source
				local user_id = vRP.getUserId(source)
				vida = vRPclient.getHealth(source)
				if vida > 100 and vida < 400 then
					if bandagem[user_id] == 0 or not bandagem[user_id] then
						if vRP.tryGetInventoryItem(user_id,"bandagem",1,dataType) then
							bandagem[user_id] = 900
							vRP.varyExp(user_id,"physical","strength",650)
							TriggerClientEvent('cancelando',source,true)
							vRPclient._CarregarObjeto(source,"amb@world_human_clipboard@male@idle_a","idle_c","v_ret_ta_firstaid",49,60309)
							TriggerClientEvent('bandagem',source)
							TriggerClientEvent("progress",source,60000,"curando")
							SetTimeout(60000,function()
								TriggerClientEvent('cancelando',source,false)
								vRPclient._DeletarObjeto(source)
								TriggerClientEvent("Notify",player,"sucesso","Bandagem utilizada com sucesso.")
							end)
						end
					end
				end
			end
			if type == "capuz" then
				if vRP.getInventoryItemAmount(user_id,"capuz") >= 1 then
					local user_id = vRP.getUserId(source)
					local nplayer = vRPclient.getNearestPlayer(source,2)
					if nplayer then
						vRPclient.setCapuz(nplayer)
						vRP.closeMenu(nplayer)
						TriggerClientEvent("Notify",source,"sucesso","Capuz utilizado com sucesso.")
					else
						TriggerClientEvent("Notify",source,"negado","Vitima não encotrada.")
					end
				end
			end
			if type == "cocaina" then
				if vRP.tryGetInventoryItem(user_id,"cocaina",1,dataType) then
					TriggerClientEvent("Notify",player,"aviso","Cheirando Cocaina.")
					play_f2(player)
					SetTimeout(10000,function()
						Dclient.playMovement(player,"MOVE_M@DRUNK@SLIGHTLYDRUNK",true,true,false,false)
						Dclient.playScreenEffect(player, "DrugsTrevorClownsFight", 120) 
					end)
					SetTimeout(120000,function()
						Dclient.resetMovement(player,false)
					end)
				end
			end
			if type == "metanfetamina" then
				if vRP.tryGetInventoryItem(user_id,"metanfetamina",1,dataType) then
					TriggerClientEvent("Notify",player,"aviso","Injetando Metanfetamina.")
					play_drink(player)
					SetTimeout(10000,function()
						Dclient.playMovement(player,"MOVE_M@DRUNK@SLIGHTLYDRUNK",true,true,false,false)
						Dclient.playScreenEffect(player, "DMT_flight", 120) 
					end)
					SetTimeout(120000,function()
						Dclient.resetMovement(player,{false})
					end)
				end
			end 

			if type == "colete" then
				if vRP.tryGetInventoryItem(user_id,"colete",1) then
					vRPclient.setArmour(source,200)
					TriggerClientEvent("Notify",player,"aviso","Colete Equipado.")
				end
			end 

			if type == "lockpick" then 
				local src = source
				local mPlaca,mName,mNet,mPrice,mBanido,mLock,mModel,mStreet = vRPclient.ModelName(src,7)
				local mPlacaUser = vRP.getUserByRegistration(mPlaca)
				if vRP.getInventoryItemAmount(user_id,"lockpick") >= 1 and mName then
					vRP.tryGetInventoryItem(user_id,"lockpick",1,false,dataType)
					if vRP.hasPermission(user_id,"policia.permissao") then
						TriggerClientEvent("syncLock",-1,mNet)
						return
					end
					
					TriggerClientEvent('cancelando',src,true)
					vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
					TriggerClientEvent("progress",src,30000,"roubando")
					SetTimeout(30000,function()
						TriggerClientEvent('cancelando',src,false)
						vRPclient._stopAnim(src,false)
						
						if not mPlacaUser then
							TriggerClientEvent("syncLock",-1,mNet)
							TriggerClientEvent("vrp_sound:source",src,'lock',0.1)
						else
							if math.random(100) >= 80 then
								TriggerClientEvent("syncLock",-1,mNet)
								TriggerClientEvent("vrp_sound:source",src,'lock',0.1)
							else
								TriggerClientEvent("Notify",player,"negado","Roubo do veículo falhou e as autoridades foram acionadas.")
								local policia = vRP.getUsersByPermission("policia.permissao")
								local x,y,z = vRPclient.getPosition(src)
								for k,v in pairs(policia) do
									local player = vRP.getUserSource(parseInt(v))
									if player then
										async(function()
											local id = idgens:gen()
											TriggerClientEvent('chatMessage',player,"911",{65,130,255},"Roubo na ^1"..mStreet.."^0 do veículo ^1"..mModel.."^0 de placa ^1"..mPlaca.."^0 verifique o ocorrido.")
											pick[id] = vRPclient.addBlip(player,x,y,z,153,84,"Ocorrência",0.5,false)
											SetTimeout(60000,function() vRPclient.removeBlip(player,pick[id]) idgens:free(id) end)
										end)
									end
								end
							end
						end
					end)
				else
					TriggerClientEvent("Notify",player,"negado","Precisa de uma <b>Lockpick</b> para iniciar o roubo do veículo.")
				end
			end
			if type == "masterpick" then 
				local src = source
				local mPlaca,mName,mNet,mPrice,mBanido,mLock,mModel,mStreet = vRPclient.ModelName(src,7)
				local mPlacaUser = vRP.getUserByRegistration(mPlaca)
				if vRP.getInventoryItemAmount(user_id,"masterpick") >= 1 and mName then 
					if vRP.hasPermission(user_id,"policia.permissao") then
						TriggerClientEvent("syncLock",-1,mNet)
						return
					end
					
					TriggerClientEvent('cancelando',src,true)
					vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
					TriggerClientEvent("progress",src,60000,"roubando")
					
					SetTimeout(60000,function()
						TriggerClientEvent("vrp_sound:source",src,'lock',0.1)
						TriggerClientEvent('cancelando',src,false)
						TriggerClientEvent("syncLock",-1,mNet)
						vRPclient._stopAnim(src,false)
						
						local policia = vRP.getUsersByPermission("policia.permissao")
						local x,y,z = vRPclient.getPosition(src)
						for k,v in pairs(policia) do
							local player = vRP.getUserSource(parseInt(v))
							if player then
								async(function()
									local id = idgens:gen()
									TriggerClientEvent('chatMessage',player,"911",{65,130,255},"Roubo na ^1"..mStreet.."^0 do veículo ^1"..mModel.."^0 de placa ^1"..mPlaca.."^0 verifique o ocorrido.")
									pick[id] = vRPclient.addBlip(player,x,y,z,153,84,"Ocorrência",0.5,false)
									SetTimeout(60000,function() vRPclient.removeBlip(player,pick[id]) idgens:free(id) end)
								end)
							end
						end
					end)
				else
					TriggerClientEvent("Notify",player,"negado","Precisa de uma <b>Masterpick</b> para iniciar o roubo do veículo.")
				end
			end
			if type == "energetico" then 
				local src = source
				if vRP.tryGetInventoryItem(user_id,"energetico",1,dataType) then

					TriggerClientEvent('cancelando',src,true)
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_energy_drink",49,28422)
					TriggerClientEvent("progress",src,10000,"bebendo")

					SetTimeout(10000,function()

						if varyHunger ~= 0 then vRP.varyHunger(user_id,varyHunger) end
						if varyThirst ~= 0 then vRP.varyThirst(user_id,varyThirst) end

						TriggerClientEvent('energeticos',src,true)
						TriggerClientEvent('cancelando',src,false)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",player,"sucesso","Energético utilizado com sucesso.")
					end)

					SetTimeout(60000,function()
						TriggerClientEvent('energeticos',src,false)
						TriggerClientEvent("Notify",player,"aviso","O efeito do energético passou e o coração voltou a bater normalmente.")
					end)
				else
					TriggerClientEvent("Notify",player,"negado","Energético não encontrada na mochila.")
				end
			end 
			if type == "agua" then 
				local src = source
				if vRP.tryGetInventoryItem(user_id,"agua",1,dataType) then
					TriggerClientEvent('cancelando',src,true)
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_energy_drink",49,28422)
					TriggerClientEvent("progress",src,10000,"bebendo")

					SetTimeout(10000,function()
						
						if varyHunger ~= 0 then vRP.varyHunger(user_id,varyHunger) end
						if varyThirst ~= 0 then vRP.varyThirst(user_id,varyThirst) end
						
						TriggerClientEvent('agua',src,true)
						TriggerClientEvent('cancelando',src,false)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",player,"sucesso","Água utilizado com sucesso.")
					end)
				end
			end 
			if type == "limonada" then 
				local src = source
				if vRP.tryGetInventoryItem(user_id,"limonada",1,dataType) then
					TriggerClientEvent('cancelando',src,true)
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","ng_proc_sodacup_01b",49,28422)
					TriggerClientEvent("progress",src,10000,"bebendo")

					SetTimeout(10000,function()
						
						if varyHunger ~= 0 then vRP.varyHunger(user_id,varyHunger) end
						if varyThirst ~= 0 then vRP.varyThirst(user_id,varyThirst) end
						
						TriggerClientEvent('limonada',src,true)
						TriggerClientEvent('cancelando',src,false)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",player,"sucesso","Limonada utilizado com sucesso.")
					end)
				end
			end 
			if type == "refrigerante" then 
				local src = source
				if vRP.tryGetInventoryItem(user_id,"refrigerante",1,dataType) then
					TriggerClientEvent('cancelando',src,true)
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_cs_bs_cup",49,28422)
					TriggerClientEvent("progress",src,10000,"bebendo")

					SetTimeout(10000,function()
						
						if varyHunger ~= 0 then vRP.varyHunger(user_id,varyHunger) end
						if varyThirst ~= 0 then vRP.varyThirst(user_id,varyThirst) end
						
						TriggerClientEvent('refrigerante',src,true)
						TriggerClientEvent('cancelando',src,false)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",player,"sucesso","Refrigerante utilizado com sucesso.")
					end)
				end
			end 
			if type == "cerveja" then 
				local src = source
				if vRP.tryGetInventoryItem(user_id,"cerveja",1,dataType) then
					TriggerClientEvent('cancelando',src,true)
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_amb_beer_bottle",49,28422)
					TriggerClientEvent("progress",src,10000,"bebendo")

					SetTimeout(10000,function()
						
						if varyHunger ~= 0 then vRP.varyHunger(user_id,varyHunger) end
						if varyThirst ~= 0 then vRP.varyThirst(user_id,varyThirst) end
						
						TriggerClientEvent('cerveja',src,true)
						TriggerClientEvent('cancelando',src,false)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",player,"sucesso","Cerveja utilizado com sucesso.")
					end)
				end
			end 
			if type == "cafe" then 
				local src = source
				if vRP.tryGetInventoryItem(user_id,"cafe",1,dataType) then
					TriggerClientEvent('cancelando',src,true)
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","p_ing_coffeecup_01",49,28422)
					TriggerClientEvent("progress",src,10000,"bebendo")

					SetTimeout(10000,function()
						
						if varyHunger ~= 0 then vRP.varyHunger(user_id,varyHunger) end
						if varyThirst ~= 0 then vRP.varyThirst(user_id,varyThirst) end
						
						TriggerClientEvent('cafe',src,true)
						TriggerClientEvent('cancelando',src,false)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",player,"sucesso","Café utilizado com sucesso.")
					end)
				end
			end 
			if type == "pao" then 
				local src = source
				if vRP.tryGetInventoryItem(user_id,"pao",1,dataType) then
					TriggerClientEvent('cancelando',src,true)
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","v_ret_247_bread1",49,28422)
					TriggerClientEvent("progress",src,10000,"comendo")

					SetTimeout(10000,function()
						
						if varyHunger ~= 0 then vRP.varyHunger(user_id,varyHunger) end
						if varyThirst ~= 0 then vRP.varyThirst(user_id,varyThirst) end
						
						TriggerClientEvent('pao',src,true)
						TriggerClientEvent('cancelando',src,false)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",player,"sucesso","Pão utilizado com sucesso.")
					end)
				end
			end 
			if type == "chocolate" then 
				local src = source
				if vRP.tryGetInventoryItem(user_id,"chocolate",1,dataType) then
					TriggerClientEvent('cancelando',src,true)
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","ng_proc_candy01a",49,28422)
					TriggerClientEvent("progress",src,10000,"comendo")

					SetTimeout(10000,function()
						
						if varyHunger ~= 0 then vRP.varyHunger(user_id,varyHunger) end
						if varyThirst ~= 0 then vRP.varyThirst(user_id,varyThirst) end
						
						TriggerClientEvent('chocolate',src,true)
						TriggerClientEvent('cancelando',src,false)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",player,"sucesso","Chocolate utilizado com sucesso.")
					end)
				end
			end 
			if type == "salgadinho" then 
				local src = source
				if vRP.tryGetInventoryItem(user_id,"salgadinho",1,dataType) then
					TriggerClientEvent('cancelando',src,true)
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","ng_proc_food_chips01b",49,28422)
					TriggerClientEvent("progress",src,10000,"comendo")

					SetTimeout(10000,function()
						
						if varyHunger ~= 0 then vRP.varyHunger(user_id,varyHunger) end
						if varyThirst ~= 0 then vRP.varyThirst(user_id,varyThirst) end
						
						TriggerClientEvent('salgadinho',src,true)
						TriggerClientEvent('cancelando',src,false)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",player,"sucesso","Salgadinho utilizado com sucesso.")
					end)
				end
			end 
			if type == "rosquinha" then 
				local src = source
				if vRP.tryGetInventoryItem(user_id,"rosquinha",1,dataType) then
					TriggerClientEvent('cancelando',src,true)
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_donut_02b",49,28422)
					TriggerClientEvent("progress",src,10000,"comendo")

					SetTimeout(10000,function()
						
						if varyHunger ~= 0 then vRP.varyHunger(user_id,varyHunger) end
						if varyThirst ~= 0 then vRP.varyThirst(user_id,varyThirst) end
						
						TriggerClientEvent('rosquinha',src,true)
						TriggerClientEvent('cancelando',src,false)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",player,"sucesso","Rosquinha utilizado com sucesso.")
					end)
				end
			end 
			if type == "pizza" then 
				local src = source
				if vRP.tryGetInventoryItem(user_id,"pizza",1,dataType) then
					TriggerClientEvent('cancelando',src,true)
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","v_res_tt_pizzaplate",49,28422)
					TriggerClientEvent("progress",src,10000,"comendo")

					SetTimeout(10000,function()
						
						if varyHunger ~= 0 then vRP.varyHunger(user_id,varyHunger) end
						if varyThirst ~= 0 then vRP.varyThirst(user_id,varyThirst) end
						
						TriggerClientEvent('pizza',src,true)
						TriggerClientEvent('cancelando',src,false)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",player,"sucesso","Pizza utilizado com sucesso.")
					end)
				end
			end 
			if type == "sanduiche" then 
				local src = source
				if vRP.tryGetInventoryItem(user_id,"sanduiche",1,dataType) then
					TriggerClientEvent('cancelando',src,true)
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_cs_burger_01",49,28422)
					TriggerClientEvent("progress",src,10000,"comendo")

					SetTimeout(10000,function()
						
						if varyHunger ~= 0 then vRP.varyHunger(user_id,varyHunger) end
						if varyThirst ~= 0 then vRP.varyThirst(user_id,varyThirst) end
						
						TriggerClientEvent('sanduiche',src,true)
						TriggerClientEvent('cancelando',src,false)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",player,"sucesso","Café utilizado com sucesso.")
					end)
				end
			end 
			if type == "whisky" then 
				if vRP.tryGetInventoryItem(user_id,"whisky",1,dataType) then
					TriggerClientEvent('cancelando',source,true)
					vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","p_whiskey_notop",49,28422)
					TriggerClientEvent("progress",source,10000,"bebendo")
					SetTimeout(10000,function()
						Dclient.playMovement(player,"MOVE_M@DRUNK@SLIGHTLYDRUNK",true,true,false,false)
						Dclient.playScreenEffect(player, "DrugsTrevorClownsFight", 120) 
						TriggerClientEvent('cancelando',source,false)
						vRPclient._DeletarObjeto(source)
						TriggerClientEvent("Notify",source,"sucesso","whisky utilizada com sucesso.")
					end)
					SetTimeout(120000,function()
						Dclient.resetMovement(player,false)
					end)
				else
					TriggerClientEvent("Notify",source,"negado","Vodka não encontrada na mochila.")
				end
			end
			if type == "abisinto" then 
				if vRP.tryGetInventoryItem(user_id,"abisinto",1,dataType) then
					TriggerClientEvent('cancelando',source,true)
					vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","p_whiskey_notop",49,28422)
					TriggerClientEvent("progress",source,10000,"bebendo")
					SetTimeout(10000,function()
						Dclient.playMovement(player,"MOVE_M@DRUNK@SLIGHTLYDRUNK",true,true,false,false)
						Dclient.playScreenEffect(player, "DrugsTrevorClownsFight", 120) 
						TriggerClientEvent('cancelando',source,false)
						vRPclient._DeletarObjeto(source)
						TriggerClientEvent("Notify",source,"sucesso","Abisinto utilizada com sucesso.")
					end)
					SetTimeout(120000,function()
						Dclient.resetMovement(player,false)
					end)
				else
					TriggerClientEvent("Notify",source,"negado","Vodka não encontrada na mochila.")
				end
			end
			if type == "tequila" then 
				if vRP.tryGetInventoryItem(user_id,"tequila",1,dataType) then
					TriggerClientEvent('cancelando',source,true)
					vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","p_whiskey_notop",49,28422)
					TriggerClientEvent("progress",source,10000,"bebendo")
					SetTimeout(10000,function()
						Dclient.playMovement(player,"MOVE_M@DRUNK@SLIGHTLYDRUNK",true,true,false,false)
						Dclient.playScreenEffect(player, "DrugsTrevorClownsFight", 120) 
						TriggerClientEvent('cancelando',source,false)
						vRPclient._DeletarObjeto(source)
						TriggerClientEvent("Notify",source,"sucesso","Tequila utilizada com sucesso.")
					end)
					SetTimeout(120000,function()
						Dclient.resetMovement(player,false)
					end)
				else
					TriggerClientEvent("Notify",source,"negado","Vodka não encontrada na mochila.")
				end
			end
			if type == "conhaque" then 
				if vRP.tryGetInventoryItem(user_id,"conhaque",1,dataType) then
					TriggerClientEvent('cancelando',source,true)
					vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","p_whiskey_notop",49,28422)
					TriggerClientEvent("progress",source,10000,"bebendo")
					SetTimeout(10000,function()
						Dclient.playMovement(player,"MOVE_M@DRUNK@SLIGHTLYDRUNK",true,true,false,false)
						Dclient.playScreenEffect(player, "DrugsTrevorClownsFight", 120) 
						TriggerClientEvent('cancelando',source,false)
						vRPclient._DeletarObjeto(source)
						TriggerClientEvent("Notify",source,"sucesso","Conhaque utilizada com sucesso.")
					end)
					SetTimeout(120000,function()
						Dclient.resetMovement(player,false)
					end)
				else
					TriggerClientEvent("Notify",source,"negado","Vodka não encontrada na mochila.")
				end
			end
			if type == "vodka" then 
				if vRP.tryGetInventoryItem(user_id,"vodka",1,dataType) then
					TriggerClientEvent('cancelando',source,true)
					vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_amb_beer_bottle",49,28422)
					TriggerClientEvent("progress",source,10000,"bebendo")
					SetTimeout(10000,function()
						Dclient.playMovement(player,"MOVE_M@DRUNK@SLIGHTLYDRUNK",true,true,false,false)
						Dclient.playScreenEffect(player, "DrugsTrevorClownsFight", 90) 
						TriggerClientEvent('cancelando',source,false)
						vRPclient._DeletarObjeto(source)
						TriggerClientEvent("Notify",source,"sucesso","Bebenco utilizada com sucesso.")
					end)
					SetTimeout(120000,function()
						Dclient.resetMovement(player,false)
					end)
				else
					TriggerClientEvent("Notify",source,"negado","Vodka não encontrada na mochila.")
				end
			end
		end
		
		if type == "none" then
			TriggerClientEvent("Notify",source,"negado","Este item não pode ser usado.") 
		end
	end 
end


RegisterServerEvent("vrp_inventario:giveItem")
AddEventHandler("vrp_inventario:giveItem",function(data)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if data.dataType[3] == 1 then
			local nplayer = vRPclient.getNearestPlayer(source,2)
			if nplayer then
				local nuser_id = vRP.getUserId(nplayer)
				if nuser_id then
					local amount = parseInt(data.amount)
					if amount > 0 then
						if vRP.getInventoryWeight(nuser_id)+vRP.getItemWeight(data.idname)*amount <= vRP.getInventoryMaxWeight(nuser_id) then
							if vRP.tryGetInventoryItem(user_id,data.idname,amount) then
								vRP.giveInventoryItem(nuser_id,data.idname,amount)
								vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
								TriggerClientEvent("Notify",source,"sucesso","Enviou <b>"..data.idname.." x"..amount.."</b>.")
								TriggerClientEvent("Notify",nplayer,"sucesso","Recebeu <b>"..data.idname.." x"..amount.."</b>.")
							end
						else
							TriggerClientEvent("Notify",nplayer,"negado","Inventário cheio.")
							TriggerClientEvent("Notify",source,"negado","Inventário cheio.")
						end
					end
				end
			end
		elseif data.dataType[3] == 2 then
			local amount = parseInt(data.amount)
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(data.idname)*amount <= vRP.getInventoryMaxWeight(user_id) then
				if vRP.tryGetInventoryItem(user_id,data.idname,amount, data.dataType) then
					vRP.giveInventoryItem(user_id,data.idname,amount, {data.dataType[1], data.dataType[2], 1, cfg_inventory.vehicle_chest_weights[string.lower(data.dataType[2])] or 50})
					TriggerClientEvent("Notify",source,"sucesso","Recebeu <b>"..data.idname.." x"..amount.."</b>.")
				end
			else
				TriggerClientEvent("Notify",source,"negado","Inventário cheio.")
			end
		end
	end 
end)


function play_f1(player)
	vRPclient._playAnim(player, true, {task="WORLD_HUMAN_SMOKING_POT"}, false)
end
function play_f2(player)
	vRPclient._playAnim(player,true,{{"mp_player_int_uppersmoke","mp_player_int_smoke"}},false)
end 