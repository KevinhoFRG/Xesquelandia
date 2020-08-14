------------------------------------------------------
----------https://github.com/DaviReisVieira-----------
------------EMAIL:VIEIRA08DAVI38@GMAIL.COM------------
---------------DISCORD: DAVI REIS #2602---------------
------------------------------------------------------
-- vRP TUNNEL/PROXY
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

-- RESOURCE TUNNEL/PROXY
vRPlv = {}
Tunnel.bindInterface("vrp_lavagem",vRPlv)
Proxy.addInterface("vrp_lavagem",vRPlv)
LVserver = Tunnel.getInterface("vrp_lavagem")

cfg = module("vrp_lavagem", "cfg/config")

local contador = 0

-------------------------------------------------------------------------------------------------------------------------------------
---------MARKER
-------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		for k, v in ipairs(cfg.lavagem) do
			local x,y,z = table.unpack(v)
			local player = PlayerPedId()
			local Coordenadas = GetEntityCoords(player)
			local Distancia = GetDistanceBetweenCoords(Coordenadas.x, Coordenadas.y, Coordenadas.z, x,y,z, true)
			if Distancia < 6.0 then
				Opacidade = math.floor(255 - (Distancia * 40))
				TextoMarker(x,y,z+0.4, "APERTE ~r~[ F ]~w~ PARA LAVAR O DINHEIRO", Opacidade)
					DrawMarker(cfg.marker.idmarker, x,y,z-0.99, 0, 0, 0, 0, 0, 0, cfg.marker.x1,cfg.marker.y1,cfg.marker.z1,cfg.marker.r,cfg.marker.g,cfg.marker.b,cfg.marker.a, cfg.marker.pula, 0, 0, cfg.marker.gira)
				if contador == 0 then
					TextoMarker(x,y,z+0.1, "~r~Lavagem: ~g~".. (cfg.lavagemporcento)*100 .."%", Opacidade)
					if (IsControlJustPressed(1,49)) then
						--if LVserver.permissao() then
						if true then
							SetEntityCoords(player, cfg.lavagemcoord)
							SetEntityHeading(player, cfg.heading)
							RequestAnimDict('missheist_jewel@hacking')
                            while not HasAnimDictLoaded('missheist_jewel@hacking') do
                                Wait(10)
                            end
                            TaskPlayAnim(player, "missheist_jewel@hacking", "hack_loop", 8.0, 1.0, -1, 1, 0, 0, 0, 0)
							contador = 5
							LVserver.lavarabrir()
						else
							TextoSuperior("Você não tem ~r~Autorização~w~ para isso.")
						end
					end
				else
					TextoMarker(x,y,z+0.8, "AGUARDE ~r~".. contador .. " ~w~SEGUNDOS PARA LAVAR NOVAMENTE", Opacidade)
				end
			end
		end
	end
end)


function vRPlv.jalimpououn()
	ClearPedTasks(PlayerPedId())
end

-------------------------------------------------------------------------------------------------------------------------------------
---------BLIP
-------------------------------------------------------------------------------------------------------------------------------------
--Citizen.CreateThread(function()
	--for k,v in pairs(cfg.lavagem) do
		--local x,y,z = table.unpack(v)
      	--NossoBlip = AddBlipForCoord(x,y,z)
      	--SetBlipSprite(NossoBlip,cfg.blip.id)
      	--SetBlipColour(NossoBlip,cfg.blip.cor)
		--SetBlipScale(NossoBlip, cfg.blip.escala)
      	--SetBlipAsShortRange(NossoBlip, true)
      	--BeginTextCommandSetBlipName("STRING")
      	--AddTextComponentString(cfg.blip.nome)
      	--EndTextCommandSetBlipName(NossoBlip)
    --end
--end)
-------------------------------------------------------------------------------------------------------------------------------------
---------CONTADOR
-------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Wait(1000)
		if contador > 0 then
			contador = contador - 1
		end
	end
end)
-------------------------------------------------------------------------------------------------------------------------------------
---------TEXTO NO CANTO
-------------------------------------------------------------------------------------------------------------------------------------
function TextoSuperior(s)
	SetTextComponentFormat("STRING")
	AddTextComponentString(s)
	EndTextCommandDisplayHelp(0,0,0,-1)
end
-------------------------------------------------------------------------------------------------------------------------------------
---------TEXTO
-------------------------------------------------------------------------------------------------------------------------------------
function TextoMarker(x,y,z, text, Opacidade)
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