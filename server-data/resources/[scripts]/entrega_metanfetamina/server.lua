local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emp = {}
Tunnel.bindInterface("entrega_metafetamina",emp) 
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('entrega_metafetamina:permissao')
AddEventHandler('entrega_metafetamina:permissao',function()
	local source = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if vRP.hasGroup(user_id,"Amarelos") then
	    TriggerClientEvent('entrega_metafetamina:permissao', player)
	end
end)

RegisterServerEvent('entrega_metafetamina:itensReceber')
AddEventHandler('entrega_metafetamina:itensReceber', function(quantidade)
	local src = source
	local user_id = vRP.getUserId(src)
    local pagamento = math.random(900,950)
    if user_id then
        local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight("dinheirosujo")*pagamento*quantidade
        if new_weight <= vRP.getInventoryMaxWeight(user_id) then
            if vRP.tryGetInventoryItem(user_id,"metanfetamina",quantidade,true) then
                vRPclient._playAnim(src,true,{{"mp_common","givetake1_a",1}},false)
				vRP.giveInventoryItem(user_id,"dinheirosujo",pagamento*quantidade,false)
                local typemessage = "sucesso"
                local mensagem = "Você recebeu $"..pagamento*quantidade.."."
                vRPclient.setDiv(src, "Alerta","body {font-family: 'Source Sans Pro', 'Helvetica Neue', Arial, sans-serif;color: #34495e;-webkit-font-smoothing: antialiased;line-height: 1.6em;}p {margin: 0;}.notice {margin: 1em;background: #F9F9F9;padding: 1em 1em 1em 2em;border-left: 4px solid #DDD;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.125);bottom: 7%;right: 1%;line-height: 22px;position: absolute;max-width: 500px;-webkit-border-radius: 5px; -webkit-animation: fadein 2s; -moz-animation: fadein 2s; -ms-animation: fadein 2s; -o-animation: fadein 2s; animation: fadein 2s;}.notice:before {position: absolute;top: 50%;margin-top: -17px;left: -17px;background-color: #DDD;color: #FFF;width: 30px;height: 30px;text-align: center;line-height: 30px;font-weight: bold;font-family: Georgia;text-shadow: 1px 1px rgba(0, 0, 0, 0.5);}.info {border-color: #0074D9;}.info:before {content: \"i\";background-color: #0074D9;}.sucesso {border-color: #2ECC40;}.sucesso:before {content: \"√\";background-color: #2ECC40;}.aviso {border-color: #FFDC00;}.aviso:before {content: \"!\";background-color: #FFDC00;}.error {border-color: #FF4136;}.error:before {content: \"X\";background-color: #FF4136;}@keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-moz-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-webkit-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-ms-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}@-o-keyframes fadein {from { opacity: 0; }to   { opacity: 1; }}","<div class=\"notice "..typemessage.."\"><p>"..mensagem..".</p></div>")
                SetTimeout(5000,function()
                    vRPclient.removeDiv(src, "Alerta")
                end)
                quantidade = nil
            end
        end
	end
end)