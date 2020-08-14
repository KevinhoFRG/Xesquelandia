local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_salar")

salarii = {
  {"salariopmerj.permissao", 3000}, 
  {"salariogam.permissao", 3200},
  {"salariorecom.permissao", 2350},
  {"salariobope.permissao", 4000},
  {"salariopfederal.permissao", 4250},
  {"salariobpchq.permissao", 3000},
  {"cmdgeral.permissao", 6000},
  {"prf.permissao", 4500},
  {"pcivil.permissao", 3500},
  {"juiz.permissao", 8000},
  {"advogado.permissao", 4000}, 
  {"mecanico.permissao", 2000},
  {"enfermeiro.permissao", 4000},
  {"paramedicosamu.permissao", 4500},   
  {"diretorgeral.permissao", 5000}, 
  {"weazel.permissao", 3500}, 
  
  {"bronze.permissao", 4000},
  {"prata.permissao", 6000},
  {"ouro.permissao", 8000},
  {"platina.permissao", 12000},
}

RegisterServerEvent('offred:salar')
AddEventHandler('offred:salar', function(salar)
	local user_id = vRP.getUserId(source)
	for i,v in pairs(salarii) do
		permisiune = v[1]
		if vRP.hasPermission(user_id, permisiune)then
			salar = v[2]
			vRP.giveBankMoney(user_id,salar)
			TriggerClientEvent('chatMessage',source,"GOVERNO",{255,70,50},"Seu salário de ^1$"..salar.." ^0 foi depositado em sua conta bancária.")
		end
	end
end)
