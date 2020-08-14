local cfg = {}

cfg.groups = {
	["admin"] = {
		"admin.permissao",
		"fix.permissao",
		"dv.permissao",
		"god.permissao",
		"wl.permissao",
		"kick.permissao",
		"ban.permissao",
		"unban.permissao",
		"money.permissao",
		"noclip.permissao",
		"ticket.permissao",
		"tp.permissao",
		"spawncar.permissao",
		"msg.permissao"
	},
	["mod"] = {
		"admin.permissao",
		"fix.permissao",
		"dv.permissao",
		"god.permissao",
		"ticket.permissao",
		"wl.permissao",
		"kick.permissao",
		"ban.permissao",
		"unban.permissao",
		"noclip.permissao",
		"tp.permissao",
		"spawncar.permissao",
		"msg.permissao"
	},
	["sup"] = {
		"admin.permissao",
		"ticket.permissao",
		"fix.permissao",
		"dv.permissao",
		"wl.permissao",
		"kick.permissao"
	},
	["aprovadorwl"] = {
		"wl.permissao"
	},
	---------------------------------------------------
	["COMANDANTE"] = {
		_config = {
			title = "Comandante Geral",
			gtype = "job"
		},
		"policia.permissao",
		"cmdgeral.permissao",
		"policiaheli.permissao",
		"polpar.permissao"
	},
	["PaisanaCMD"] = {
		_config = {
			title = "À Paisana CMD Geral",
			gtype = "job"
		},
		"paisanacmdgeral.permissao"
	},
	["PF"] = {
		_config = {
			title = "Policia Federal",
			gtype = "job"
		},
		"policia.permissao",
		"pfederal.permissao",
		"salariopfederal.permissao",
		"polpar.permissao"
	},
	["PaisanaPoliciaPF"] = {
		_config = {
			title = "À Paisana PF",
			gtype = "job"
		},
		"paisanapoliciapf.permissao"
	},
	---------------------------------------------------
	---------------------------------------------------
	["PMERJ"] = {
		_config = {
			title = "PMERJ",
			gtype = "job"
		},
		"policia.permissao",
		"pmerj.permissao",
		"salariopmerj.permissao",
		"policiaheli.permissao",
		"polpar.permissao"
	},
	["PaisanaPolicia"] = {
		_config = {
			title = "À Paisana PMERJ",
			gtype = "job"
		},
		"paisanapolicia.permissao"
	},
	---------------------------------------------------
	---------------------------------------------------
	["PC"] = {
		_config = {
			title = "Policia Civil",
			gtype = "job"
		},
		"policia.permissao",
		"pcivil.permissao",
		"salariopcivil.permissao",
		"polpar.permissao"
	},
	["PaisanaPoliciaPC"] = {
		_config = {
			title = "À Paisana PC",
			gtype = "job"
		},
		"paisanapoliciapc.permissao"
	},
	---------------------------------------------------
	---------------------------------------------------
	["PRF"] = {
		_config = {
			title = "Policia Rodoviária Federal",
			gtype = "job"
		},
		"policia.permissao",
		"prf.permissao",
		"salarioprf.permissao",
		"policiaheli.permissao",
		"polpar.permissao"
	},
	["PaisanaPRF"] = {
		_config = {
			title = "À Paisana PRF",
			gtype = "job"
		},
		"paisanaprf.permissao"
	},
	---------------------------------------------------
	["RECOM"] = {
		_config = {
			title = "RECOM",
			gtype = "job"
		},
		"policia.permissao",
		"recom.permissao",
		"salariorecom.permissao",
		"polpar.permissao"
	},
	["PaisanaRECOM"] = {
		_config = {
			title = "À Paisana RECOM",
			gtype = "job"
		},
		"paisanapoliciarecom.permissao"
	},
	---------------------------------------------------	
	["BOPE"] = {
		_config = {
			title = "BOPE",
			gtype = "job"
		},
		"policia.permissao",
		"bope.permissao",
		"salariobope.permissao",
		"polpar.permissao"
	},
	["PaisanaBOPE"] = {
		_config = {
			title = "À Paisana BOPE",
			gtype = "job"
		},
		"paisanapoliciabope.permissao"
	},
	---------------------------------------------------
	["Weazel"] = {
		_config = {
			title = "Weazel News",
			gtype = "job"
		},
		"weazel.permissao"
	},
	---------------------------------------------------
	["Milicia"] = {
		_config = {
			title = "Miliciano",
			gtype = "job"
		},
		"milicia.permissao"
	},
	---------------------------------------------------
	["BPCHQ"] = {
		_config = {
			title = "BPChq",
			gtype = "job"
		},
		"policia.permissao",
		"bpchq.permissao",
		"salariobpchq.permissao",
		"polpar.permissao"
	},
	["PaisanaBPCHQ"] = {
		_config = {
			title = "À Paisana BPChq",
			gtype = "job"
		},
		"paisanapoliciabpchq.permissao"
	},
	---------------------------------------------------
    ["GAM"] = {
		_config = {
			title = "GAM",
			gtype = "job"
		},
		"policia.permissao",
		"gam.permissao",
		"salariogam.permissao",
		"policiaheli.permissao",
		"polpar.permissao"
	},
	["PaisanaGAM"] = {
		_config = {
			title = "À Paisana GAM",
			gtype = "job"
		},
		"paisanapoliciagam.permissao"
	},
	---------------------------------------------------
	["Enfermeiro"] = {
		_config = {
			title = "Enfermeiro SAMU",
			gtype = "job"
		},
		"paramedico.permissao",
		"reviver.permissao",
		"enfermeiro.permissao",
		"polpar.permissao"
	},
	["PaisanaEnfermeiro"] = {
		_config = {
			title = "À Paisana Enfermeiro",
			gtype = "job"
		},
		"paisanaenfermeiro.permissao"
	},
	---------------------------------------------------
	["Paramedico"] = {
		_config = {
			title = "Paramédico SAMU",
			gtype = "job"
		},
		"paramedico.permissao",
		"reviver.permissao",
		"paramedicosamu.permissao",
		"polpar.permissao"
	},
	["PaisanaParamedico"] = {
		_config = {
			title = "À Paisana Paramédico",
			gtype = "job"
		},
		"paisanaparamedico.permissao"
	},
	---------------------------------------------------
	["Diretor"] = {
		_config = {
			title = "Diretor Geral SAMU",
			gtype = "job"
		},
		"paramedico.permissao",
		"reviver.permissao",
		"diretorgeral.permissao",
		"polpar.permissao"
	},
	["PaisanaDiretorGeral"] = {
		_config = {
			title = "À Paisana Diretor Geral",
			gtype = "job"
		},
		"paisanadiretorgeral.permissao"
	},
	---------------------------------------------------
	["Lider Mecanico"] = {
		_config = {
			title = "Chefe Mecanico",
			gtype = "job"
		},
		"mecanico.permissao",
		"lidermecanico.permissao",
		"lsc.use"
	},
	["Mecanico"] = {
		_config = {
			title = "Mecanico",
			gtype = "job"
		},
		"mecanico.permissao",
		"lsc.use"
	},
	["Advogado"] = {
		_config = {
			title = "Advogado",
			gtype = "job"
		},
		"advogado.permissao"
	},
	["Juiz"] = {
		_config = {
			title = "Juiz",
			gtype = "job"
		},
		"juiz.permissao"
	},
	["PaisanaMecanico"] = {
		_config = {
			title = "PaisanaMecanico",
			gtype = "job"
		},
		"paisanamecanico.permissao"
	},
	["Civil"] = {
		_config = {
			title = "Civil",
			gtype = "job"
		},
	},
	["Lider Taxista"] = {
		_config = {
			title = "Líder Taxista",
			gtype = "job"
		},
		"taxista.permissao",
		"lidertaxista.permissao"
	},
	["Taxista"] = {
		_config = {
			title = "Taxista",
			gtype = "job"
		},
		"taxista.permissao"
	},
	["PaisanaTaxista"] = {
		_config = {
			title = "PaisanaTaxista",
			gtype = "job",
		},
		"paisanataxista.permissao"
	},
	["Bronze"] = {
		_config = {
			title = "Bronze"
		},
		"bronze.permissao",
		"carrosvip.permissao"
	},
	["Prata"] = {
		_config = {
			title = "Prata"
		},
		"prata.permissao",
		"carrosvip.permissao"
	},
	["Ouro"] = {
		_config = {
			title = "Ouro"
		},
		"ouro.permissao",
		"mochila.permissao",
		"carrosvip.permissao"
	},
	["Platina"] = {
		_config = {
			title = "Platina"
		},
		"platina.permissao",
		"mochila.permissao",
		"carrosvip.permissao"
	},
	["Mochila"] = {
		_config = {
			title = "Mochila"
		},
		"mochila.permissao"
	},
	["LIDER MOTOCLUB"] = {
		_config = {
			title = "Líder Motoclub",
			gtype = "job"
		},
		"motoclub.permissao",
		"lidermc.permissao",
		"entrada.permissao"
	},
	["MOTOCLUB"] = {
		_config = {
			title = "Motoclub",
			gtype = "job"
		},
		"motoclub.permissao",
		"entrada.permissao"
	},
	["LIDER TCP"] = {
		_config = {
			title = "Chefe T.C.P",
			gtype = "job"
		},
		"amarelos.permissao",
		"tcp.permissao",
		"lidertcp.permissao",
		"entrada.permissao"
	},
	["TCP"] = {
		_config = {
			title = "Chefe T.C.P",
			gtype = "job"
		},
		"amarelos.permissao",
		"tcp.permissao",
		"entrada.permissao"
	},
	["LIDER CV"] = {
		_config = {
			title = "Chefe C.V",
			gtype = "job"
		},
		"verdes.permissao",
		"cv.permissao",
		"lidercv.permissao",
		"entrada.permissao"
	},
	["CV"] = {
		_config = {
			title = "C.V",
			gtype = "job"
		},
		"verdes.permissao",
		"cv.permissao",
		"entrada.permissao"
	},
	["LIDER ADA"] = {
		_config = {
			title = "A.D.A",
			gtype = "job"
		},
		"roxos.permissao",
		"ada.permissao",
		"liderada.permissao",
		"entrada.permissao"
	},
	["ADA"] = {
		_config = {
			title = "A.D.A",
			gtype = "job"
		},
		"roxos.permissao",
		"ada.permissao",
		"entrada.permissao"
	},
	["LIDER MAFIA"] = {
		_config = {
			title = "Líder Mafia",
			gtype = "job"
		},
		"mafia.permissao",
		"lidermafia.permissao",
		"entrada.permissao"
	},
	["MAFIA"] = {
		_config = {
			title = "Mafia",
			gtype = "job"
		},
		"mafia.permissao",
		"entrada.permissao"
	},
	["LIDER YAKUZA"] = {
		_config = {
			title = "Líder Yakuza",
			gtype = "job"
		},
		"lavar.dinheiro",
		"yakuza.permissao",
		"lideryakuza.permissao",
		"entrada.permissao"
	},
	["YAKUZA"] = {
		_config = {
			title = "Yakuza",
			gtype = "job"
		},
		"lavar.dinheiro",
		"yakuza.permissao",
		"entrada.permissao"
	},
}

cfg.users = {
	[1] = { "admin" },
}

cfg.selectors = {}

return cfg