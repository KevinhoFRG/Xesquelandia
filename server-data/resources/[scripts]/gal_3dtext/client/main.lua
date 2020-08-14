-- texto 3d por gal
-- texto 3d by gal

-- do not edit the code below unless you know what youre doing, in case you dont know what youre doing, contact gal#7990 for 100% of support.
-- não edite o código abaixo a menos que você saiba oque está fazendo, caso você não saiba oque está fazendo, contate gal#7990 para 100% de suporte.

function texto3d(x, y, z, text) -- essa é a função que determina como será a aparencia do texto que iremos dar display / this is the function that determines the looks of the text that were gonna display
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())

    SetTextScale(0.50, 0.50) -- mudar esse numero mudará o tamanho do texto 3d
    SetTextFont(7) -- mudar esse numero e restartar o script mudará a fonte que está no display do texto 3d
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215) -- não é necessário alterar a cor você pode mudar a cor simplesmente mudando o color code para cada palavra / no need to change, you can change the color text just by adding color code for each word
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    DrawText(_x, _y)
    --local factor = (string.len(text)) / 370 -- descomentar a linha 19 e 20 caso queira um retangulo em volta do texto / uncomment line 19 and 20 if you want a rectangle to be displayed around your text
    --DrawRect(_x, _y + 0.0125, 0.015 + factor, 0, 0, 0, 0.0)
end

Citizen.CreateThread(function()
        while true do
            Wait(0)
            local coords = GetEntityCoords(GetPlayerPed(-1))
            for k, v in pairs(Config.Coordenadas) do -- determina as localidades do texto 3d / determines the locations where the text is gonna be displayed
                for i = 1, #v.Pos, 1 do
					if(GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < 5) then
					-- mudar o numero após o "<"" acima fará com que a distancia em que o texto 3d será carregado aumente ou mude dependendo de sua preferencia
					-- changing the number after the "<" above will cause the distance the 3d text will be loaded to increase or change depending on your preference
					texto3d(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z + 1.2,  Config.Strings.um)
					texto3d(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z + 1.0, Config.Strings.dois)
					-- aqui estou definindo a distancia de altura para cada linha de texto, alterar o numero após o "+" fará com que a altura mude baseado nas coordenadas que você colocou no config.lua
					-- here I am defining the height distance for each line of text, changing the number after the "+" will cause the height to change based on the coordinates you put in config.lua
					texto3d(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z + 0.8, Config.Strings.tres)
					texto3d(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z + 0.6, Config.Strings.quatro)
					texto3d(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z + 0.4, Config.Strings.cinco)
					texto3d(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z,       Config.Strings.seis)
					texto3d(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z - 0.2, Config.Strings.sete)
					texto3d(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z - 0.1, Config.Strings.oito)
                end
            end
        end
    end
end)