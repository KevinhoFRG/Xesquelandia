local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
rob = {}
Tunnel.bindInterface("vrp_roubos",rob)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local variavel = 0
local assaltante = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO RECOMPENSA
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
--	{ id = 1 , nome = "Caixa Eletrônico" , segundos = 20 , cops = 2 , recompensa = math.random(20000,40000) },
--	{ id = 2 , nome = "Caixa Eletrônico" , segundos = 32 , cops = 2 , recompensa = math.random(20000,40000) },
--	{ id = 3 , nome = "Caixa Eletrônico" , segundos = 32 , cops = 2 , recompensa = math.random(20000,40000) },
--	{ id = 4 , nome = "Caixa Eletrônico" , segundos = 28 , cops = 2 , recompensa = math.random(20000,40000) },
--	{ id = 5 , nome = "Caixa Eletrônico" , segundos = 26 , cops = 2 , recompensa = math.random(20000,40000) },
--	{ id = 6 , nome = "Caixa Eletrônico" , segundos = 26 , cops = 2 , recompensa = math.random(20000,40000) },
--	{ id = 7 , nome = "Caixa Eletrônico" , segundos = 27 , cops = 2 , recompensa = math.random(20000,40000) },
--	{ id = 8 , nome = "Caixa Eletrônico" , segundos = 32 , cops = 2 , recompensa = math.random(20000,40000) },
--	{ id = 9 , nome = "Caixa Eletrônico" , segundos = 28 , cops = 2 , recompensa = math.random(20000,40000) },
--	{ id = 10 , nome = "Caixa Eletrônico" , segundos = 34 , cops = 2 , recompensa = math.random(20000,40000) },
--	{ id = 11 , nome = "Caixa Eletrônico" , segundos = 26 , cops = 2 , recompensa = math.random(20000,40000) },
--	{ id = 12 , nome = "Caixa Eletrônico" , segundos = 24 , cops = 2 , recompensa = math.random(20000,40000) },
	{ id = 13 , nome = "Loja de Departamento" , segundos = 100 , cops = 3 , recompensa = math.random(70000,140000) },
	{ id = 14 , nome = "Loja de Departamento" , segundos = 80 , cops = 3 , recompensa = math.random(70000,140000) },
	{ id = 15 , nome = "Loja de Departamento" , segundos = 80 , cops = 3 , recompensa = math.random(70000,140000) },
	{ id = 16 , nome = "Loja de Departamento" , segundos = 80 , cops = 3 , recompensa = math.random(70000,140000) },
	{ id = 17 , nome = "Loja de Departamento" , segundos = 90 , cops = 3 , recompensa = math.random(70000,140000) },
	{ id = 18 , nome = "Loja de Departamento" , segundos = 100 , cops = 3 , recompensa = math.random(70000,140000) },
	{ id = 19 , nome = "Loja de Departamento" , segundos = 120 , cops = 3 , recompensa = math.random(70000,140000) },
	{ id = 20 , nome = "Loja de Departamento" , segundos = 170 , cops = 3 , recompensa = math.random(70000,140000) },
	{ id = 21 , nome = "Loja de Departamento" , segundos = 150 , cops = 3 , recompensa = math.random(70000,140000) },
	{ id = 22 , nome = "Loja de Departamento" , segundos = 200 , cops = 3 , recompensa = math.random(70000,140000) },
	{ id = 23 , nome = "Loja de Departamento" , segundos = 180 , cops = 3 , recompensa = math.random(70000,140000) },
	{ id = 24 , nome = "Loja de Departamento" , segundos = 180 , cops = 3 , recompensa = math.random(70000,140000) },
	{ id = 25 , nome = "Loja de Departamento" , segundos = 150 , cops = 3 , recompensa = math.random(70000,140000) },
--	{ id = 26 , nome = "Joalheria" , segundos = 210 , cops = 0 , recompensa = math.random(140000,210000) }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function rob.IniciandoRoubo(id,x,y,z,head)
	local source = source
	local user_id = vRP.getUserId(source)
	local soldado = vRP.getUsersByPermission("policia.permissao")
	for _,item in pairs(locais) do
		if item.id == id then
			if #soldado < item.cops then
				TriggerClientEvent('chatMessage',source,"ALERTA",{255,70,50},"Número insuficiente de policiais no momento para iniciar um roubo.")
			elseif (os.time() - variavel) < 1500 then
				TriggerClientEvent('chatMessage',source,"ALERTA",{255,70,50},"Os cofres estão vazios, aguarde ^1"..(1500-(os.time() - variavel)).." segundos ^0até que os seguranças retornem com o dinheiro.")
			else
				assaltante = true
				variavel = os.time()
				TriggerClientEvent('iniciarroubo',source,item.segundos,head)
				vRPclient.playAnim(source,false,{{"anim@heists@ornate_bank@grab_cash_heels","grab",1}},true)
				for l,w in pairs(soldado) do
					local player = vRP.getUserSource(parseInt(w))
					if player then
						async(function()
							TriggerClientEvent('criarblip',player,x,y,z)
							vRPclient.playSound(player,"HUD_MINI_GAME_SOUNDSET","CHECKPOINT_AHEAD")
							TriggerClientEvent('chatMessage',player,"911",{65,130,255},"O roubo começou no(a) ^1"..item.nome.."^0, dirija-se até o local e intercepte os assaltantes.")
						end)
					end
				end
				SetTimeout(item.segundos*1000,function()
					if assaltante then
						for l,w in pairs(soldado) do
							local player = vRP.getUserSource(parseInt(w))
							if player then
								async(function()
									TriggerClientEvent('chatMessage',player,"911",{65,130,255},"O roubo terminou, os assaltantes estão correndo antes que vocês cheguem.")
								end)
							end
						end
						TriggerClientEvent('removerblip',-1)
						vRP.giveInventoryItem(user_id,"dinheirosujo",item.recompensa,false)
						assaltante = false
					end
				end)
			end
		end
	end
end

function rob.CancelandoRoubo()
	if assaltante then
		local soldado = vRP.getUsersByPermission("policia.permissao")
		for l,w in pairs(soldado) do
			local player = vRP.getUserSource(parseInt(w))
			if player then
				async(function()
					TriggerClientEvent('chatMessage',player,"911",{65,130,255},"O assaltante saiu correndo e deixou tudo para trás.")
				end)
			end
		end
		TriggerClientEvent('removerblip',-1)
		assaltante = false
	end
end