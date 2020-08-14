local cfg = {}

cfg.items = {
	["ferramenta"] = { "Ferramenta",3 },
	["encomenda"] = { "Encomenda",1.5 },
	["sacodelixo"] = { "Saco de Lixo",2 },
	["garrafavazia"] = { "Garrafa Vazia",0.2 },
	["garrafadeleite"] = { "Garrafa de Leite",0.5 },
	["tora"] = { "Tora de Madeira",0.6 },
	["alianca"] = { "Aliança",0 },
	["bandagem"] = { "Bandagem",0.7 },
	["cerveja"] = { "Cerveja",0.7 },
	["tequila"] = { "Tequila",0.7 },
	["roupas"] = { "Roupas",1.0 },
	["vodka"] = { "Vodka",0.7 },
	["Furadeira"] = { "Furadeira",3.0 },
	["bombaadesiva"] = { "Bomba Adesiva",0.5 },
	["whisky"] = { "Whisky",0.7 },
	["rpprotecao"] = { "Colete Médico",1.0 },
	["colete"] = { "Colete Balístico",1.0 },
	["conhaque"] = { "Conhaque",0.7 },
	["absinto"] = { "Absinto",0.7 },
	["dinheirosujo"] = { "Dinheiro Sujo",0 },
	["repairkit"] = { "Kit de Reparos",1 },
	["algemas"] = { "Algemas",1 },
	["capuz"] = { "Capuz",0.5 },
	["lockpick"] = { "Lockpick",10 },
	["masterpick"] = { "Masterpick",10 },
	["militec"] = { "Militec-1",0.8 },
	["carnedecormorao"] = { "Carne de Cormorão",0.7 },
	["carnedecorvo"] = { "Carne de Corvo",0.7 },
	["rastreador"] = { "Rastreador",0.5 },
	["croquettes"] = { "Ração",0.05 },
	["cannabis"] = { "Cannabis",0.5 },
	["pseudoefedrina"] = { "Pseudoefedrina",0.5 },
	["anfetamina"] = { "Anfetamina",0.5 },
	["ritalina"] = { "Ritalina",0.5 },
	["metasuja"] = { "Metanfetamina Suja",0.5 },
	["nitro"] = { "nitro",0.5 },
	
	["acetofenetidina"] = { "Acetofenetidina",0.5 },
	["benzoilecgonina"] = { "Benzoilecgonina",0.5 },
	["cloridratoecgonina"] = { "Cloridratoecgonina",0.5 },
	["cloridratococa"] = { "Cloridratococa",0.5 },
	["pastadecoca"] = { "Pasta de Cocaina",0.5 },	
	
	["mouro"] = { "Ouro",0.8 },	
	["mferro"] = { "Ferro",0.5 },	
	["mbronze"] = { "Bronze",0.3 },	
	["mesmeralda"] = { "Esmeralda",0.6 },	
	["mrubi"] = { "Rubi",0.6 },	
	["diamante"] = { "Diamante",0.5 },	

---------------------------------
    ["agua"] = { "Água",0.5 },	
    ["limonada"] = { "Limonada",0.4 },	
    ["refrigerante"] = { "Refrigerante",0.4 },	
    ["cafe"] = { "Café",0.4 },	
    ["pao"] = { "Pão",0.1 },	
    ["sanduiche"] = { "Sanduiche",0.1 },
    ["chocolate"] = { "chocolate",0.1 },
    ["salgadinho"] = { "salgadinho",0.1 },
    ["rosquinha"] = { "rosquinha",0.1 },
    ["pizza"] = { "pizza",0.2 },	



	["carnedeaguia"] = { "Carne de Águia",0.8 },
	["carnedecervo"] = { "Carne de Cervo",0.9 },
	["carnedecoelho"] = { "Carne de Coelho",0.7 },
	["carnedecoyote"] = { "Carne de Coyote",1 },
	["carnedelobo"] = { "Carne de Lobo",1 },
	["carnedepuma"] = { "Carne de Puma",1.3 },
	["carnedejavali"] = { "Carne de Javali",1.4 },
	["isca"] = { "Isca",0.6 },
	["dourado"] = { "Dourado",0.6 },
	["corvina"] = { "Corvina",0.6 },
	["salmao"] = { "Salmão",0.6 },
	["pacu"] = { "Pacu",0.6 },
	["pintado"] = { "Pintado",0.6 },
	["pirarucu"] = { "Pirarucu",0.6 },
	["tilapia"] = { "Tilápia",0.6 },
	["tucunare"] = { "Tucunaré",0.6 },
	["lambari"] = { "Lambari",0.6 },
	["energetico"] = { "Energético",0.3 },
	["mochila"] = { "Mochila",1 },
	["adubo"] = { "Adubo",0.8 },
	["fertilizante"] = { "Fertilizante",0.8 },
	["maconha"] = { "Maconha",0.8 },
	["placa"] = { "Placa",0.8 },
	["rebite"] = { "Rebite",0.8 },
	["capsula"] = { "Cápsula",0.03 },
	["polvora"] = { "Pólvora",0.03 },
	["carbono"] = { "Carbono",0.0038 },
	["ferro"] = { "Ferro",0.0038 },
	["aco"] = { "Aço",0.0038 },
	["orgao"] = { "Órgão",1.2 },
	["etiqueta"] = { "Etiqueta",0 },
	["pendrive"] = { "Pendrive",0.1 },
	["relogioroubado"] = { "Relógio Roubado",0.3 },
	["pulseiraroubada"] = { "Pulseira Roubada",0.2 },
	["anelroubado"] = { "Anel Roubado",0.2 },
	["colarroubado"] = { "Colar Roubado",0.2 },
	["brincoroubado"] = { "Brinco Roubado",0.2 },
	["carteiraroubada"] = { "Carteira Roubada",0.2 },
	["carregadorroubado"] = { "Carregador Roubado",0.2 },
	["tabletroubado"] = { "Tablet Roubado",0.2 },
	["sapatosroubado"] = { "Sapatos Roubado",0.2 },
	["vibradorroubado"] = { "Vibrador Roubado",0.2 },
	["perfumeroubado"] = { "Perfume Roubado",0.2 },
	["maquiagemroubada"] = { "Maquiagem Roubada",0.2 },
	
	-- Farm de Metanfetamina
	["acucar"] = { "Açucar",0.8 },
	["xarope"] = { "Xarope",0.8 },
	["metanfetamina"] = { "Metanfetamina",0.8 },
	
	-- Farm de Cocaína
	["farinha"] = { "Farinha",0.8 },
	["po"] = { "Pó",0.8 },
	["cocaina"] = { "Cocaína",0.8 }
}

local function load_item_pack(name)
	local items = module("cfg/item/"..name)
	if items then
		for k,v in pairs(items) do
			cfg.items[k] = v
		end
	end
end

load_item_pack("armamentos")

return cfg