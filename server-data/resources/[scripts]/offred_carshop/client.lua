-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local aberto = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEFINIÇÃO
-----------------------------------------------------------------------------------------------------------------------------------------
local conces = {
   {-54.83,-1095.97,26.42},
--   {-32.10,-1114.31,26.42},
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- Abrir MENU
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(1)
        for _,y in pairs(conces) do
			local ped = PlayerPedId()
			local px,py,pz = table.unpack(GetEntityCoords(ped,true))
            local distancia = GetDistanceBetweenCoords(y[1],y[2],y[3],px,py,pz,true)
            if not aberto then
                if distancia <= 50 then
                    if distancia <= 1.5 then
                        DrawText3Ds(y[1],y[2],y[3],"PRESSIONE ~r~E~w~ PARA ABRIR CONCESSIONARIA")
                        if IsControlJustPressed(0,38) and not IsPedInAnyVehicle(ped,false) then
                            TriggerServerEvent('offred_carshop:abrirPainel')
							PlaySoundFrontend( -1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1 )
                            aberto = true
						end
					end
				end
            end
        end
    end
end)

RegisterNetEvent('offred_carshop:abrirPainel')
AddEventHandler('offred_carshop:abrirPainel', function(id, nome, peso, estoque, preco, imagem)
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = "open",
        id = id,
		nomeVeiculo = nome,
		pesoVeiculo = peso,
		estoqueVeiculo = estoque,
		precoVeiculo = preco,
		imagemVeiculo = imagem
	})
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- NUI FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback('escape', function()
    aberto = false
	SendNUIMessage({
		action = "close"
	})
	SetNuiFocus(false, false)
end)

RegisterNUICallback('comprarVeiculo', function(data)
    TriggerServerEvent('offred_carshop:comprarCarro', data.carro)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
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
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function drawTxt(x,y,width,height,scale,text,r,g,b,a)
    SetTextFont(4)
    SetTextScale(scale,scale)
    SetTextColour(r,g,b,a)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x,y)
end

function GetMinimapAnchor()
    local safezone = GetSafeZoneSize()
    local safezone_x = 1.0 / 20.0
    local safezone_y=1.0 / 20.0
    local aspect_ratio = GetAspectRatio(0)
    local res_x, res_y=GetActiveScreenResolution()
    local xscale = 1.0 / res_x
    local yscale = 1.0 / res_y
    local Minimap = {}
    Minimap.width = xscale * (res_x / (4 * aspect_ratio))
    Minimap.height = yscale * (res_y / 5.674)
    Minimap.left_x = xscale * (res_x * (safezone_x * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.bottom_y=1.0 - yscale * (res_y * (safezone_y * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.right_x = Minimap.left_x + Minimap.width
    Minimap.top_y=Minimap.bottom_y - Minimap.height
    Minimap.x = Minimap.left_x
    Minimap.y=Minimap.top_y
    Minimap.xunit = xscale
    Minimap.yunit = yscale
    return Minimap
end