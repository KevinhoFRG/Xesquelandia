local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local cfg = module("vrp_concessionaria", "cfg/config")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRP._prepare("sRP/concessionaria",[[
    CREATE TABLE IF NOT EXISTS vrp_concessionaria(
        id INTEGER AUTO_INCREMENT,
        modelo VARCHAR(255),
        nome VARCHAR(255),
        preco INTEGER,
        quantidade INTEGER,
        descricao text(255),
        img text(255),
        CONSTRAINT pk_concessionaria PRIMARY KEY(id)
    )
]])

vRP._prepare("sRP/inserir_veh","INSERT INTO vrp_concessionaria(modelo, nome, preco, quantidade, descricao, img) VALUES(@modelo, @nome, @preco, @quantidade, @descricao, @img)")
vRP._prepare("sRP/set_quantidade","UPDATE vrp_concessionaria SET quantidade = @quantidade WHERE id = @id")
vRP._prepare("sRP/selecionar_veh","SELECT * FROM vrp_concessionaria")
vRP._prepare("sRP/get_veh_by_id","SELECT * FROM vrp_concessionaria WHERE id = @id")

async(function()
    vRP.execute("sRP/concessionaria")
end)

local conce = cfg.concessionaria

function criarCarros()
    local rows = vRP.query("sRP/selecionar_veh")
    for k,v in pairs(conce) do
        if #rows == 0 then
            vRP.execute("sRP/inserir_veh", {
                modelo = conce[k].modelo,
                nome = conce[k].nome,
                preco = conce[k].preco,
                quantidade = conce[k].quantidade,
                descricao = conce[k].descricao,
                img = conce[k].img
            })
        end
    end
    return false
end

RegisterServerEvent('get:carros')
AddEventHandler('get:carros', function()
    local veiculos = {}
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local veh = vRP.query("sRP/selecionar_veh")
    for i=1, #veh, 1 do
        table.insert(veiculos, {
            id = veh[i].id,
            modelo = veh[i].modelo,
            nome = veh[i].nome,
            valor = veh[i].preco,
            quantidade = veh[i].quantidade,
            descricao = veh[i].descricao,
            img = veh[i].img
        })
    end
    TriggerClientEvent('send:carros', source, veiculos, identity.name.." "..identity.firstname)
end)


RegisterServerEvent('comprar:carro')
AddEventHandler('comprar:carro', function(veh)
	local source = source
    local user_id = vRP.getUserId(source)
    local rows = vRP.query("sRP/get_veh_by_id", {id = veh})
    if #rows > 0 then
        local veiculo = rows[1]
        local modelo = veiculo.modelo
        local valor = veiculo.preco
        local nome = veiculo.nome
        local quantidade = veiculo.quantidade
        local get_veh = vRP.query("vRP/get_vehicle", {user_id = user_id, vehicle = modelo})
        if #get_veh <= 0 then
            if quantidade > 0 then
                if vRP.tryFullPayment(user_id, valor) then
                    quantidade = quantidade - 1	
                    TriggerClientEvent("Notify",source,"sucesso","Parabéns, você comprou  um(a) <b>"..nome.."</b> por  <b>$"..valor.." dólares</b> .")
                    vRP.execute("sRP/set_quantidade", {id = veh, quantidade = quantidade})
                    vRP.execute("vRP/add_vehicle", {user_id = user_id, vehicle = modelo})
                else
                    TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
                end
            else
                TriggerClientEvent("Notify",source,"aviso","Sem estoque deste veiculo!.")
            end
        else
            TriggerClientEvent("Notify",source,"negado","Você <b>já possui</b> um(a) <b>"..nome.."</b>!")
        end
	end
end)

Citizen.CreateThread(function()
    criarCarros()
end)