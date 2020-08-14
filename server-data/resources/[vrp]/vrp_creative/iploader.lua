Citizen.CreateThread(function()
	for _,ipl in pairs(allIpls) do
		loadInt(ipl.coords,ipl.interiorsProps)
	end
end)

function loadInt(coordsTable,table)
	for _,coords in pairs(coordsTable) do
		local interiorID = GetInteriorAtCoords(coords[1],coords[2],coords[3])
		LoadInterior(interiorID)
		for _,propName in pairs(table) do
			Citizen.Wait(25)
			EnableInteriorProp(interiorID,propName)
		end
		RefreshInterior(interiorID)
	end
end

allIpls = {
	{
		interiorsProps = {
			"swap_clean_apt",
			"layer_debra_pic",
			"layer_whiskey",
			"swap_sofa_A"
		},
		coords = {{ -1150.7,-1520.7,10.6 }}
	},
	{
		interiorsProps = {
			"csr_beforeMission",
			"csr_inMission"
		},
		coords = {{ -47.1,-1115.3,26.5 }}
	},
	-- 			WEED LAB

	{
		interiorsProps = {
			"weed_drying",
			"weed_production",
			--"weed_set_up",
			--"weed_standard_equip",
			"weed_upgrade_equip",
			--"weed_growtha_stage1",
			--"weed_growtha_stage2",
			"weed_growtha_stage3",
			--"weed_growthb_stage1",
			--"weed_growthb_stage2",
			--"weed_growthb_stage3",
			"weed_growthc_stage1",
			--"weed_growthc_stage2",
			--"weed_growthc_stage3",
			"weed_growthd_stage1",
			--"weed_growthd_stage2",
			--"weed_growthd_stage3",
			--"weed_growthe_stage1",
			"weed_growthe_stage2",
			--"weed_growthe_stage3",
			--"weed_growthf_stage1",
			"weed_growthf_stage2",
			--"weed_growthf_stage3",
			"weed_growthg_stage1",
			--"weed_growthg_stage2",
			--"weed_growthg_stage3",
			--"weed_growthh_stage1",
			--"weed_growthh_stage2",
			"weed_growthh_stage3",
			--"weed_growthi_stage1",
			"weed_growthi_stage2",
			--"weed_growthi_stage3",
			"weed_hosea",
			"weed_hoseb",
			"weed_hosec",
			"weed_hosed",
			"weed_hosee",
			"weed_hosef",
			"weed_hoseg",
			"weed_hoseh",
			"weed_hosei",
			--"light_growtha_stage23_standard",
			--"light_growthb_stage23_standard",
			--"light_growthc_stage23_standard",
			--"light_growthd_stage23_standard",
			--"light_growthe_stage23_standard",
			--"light_growthf_stage23_standard",
			--"light_growthg_stage23_standard",
			--"light_growthh_stage23_standard",
			--"light_growthi_stage23_standard",
			"light_growtha_stage23_upgrade",
			"light_growthb_stage23_upgrade",
			"light_growthc_stage23_upgrade",
			"light_growthc_stage23_upgrade",
			"light_growthd_stage23_upgrade",
			"light_growthe_stage23_upgrade",
			"light_growthf_stage23_upgrade",
			"light_growthg_stage23_upgrade",
			"light_growthh_stage23_upgrade",
			"light_growthi_stage23_upgrade",
			--"weed_low_security",
			"weed_security_upgrade",
			"weed_chairs"
		},
		coords={{1051.491, -3196.536, -39.14842}}
	},
	{
		interiorsProps = {
			"V_Michael_bed_tidy",
			"V_Michael_M_items",
			"V_Michael_D_items",
			"V_Michael_S_items",
			"V_Michael_L_Items"
		},
		coords = {{ -802.3,175.0,72.8 }}
	},
	{
		interiorsProps = {
			"meth_lab_basic",
			"meth_lab_production",
			"meth_lab_setup"
		},
		coords = {{ 1497.75100000, 6393.09000000, 21.78359000 }} -- Metanfetamina
	},
	{
		interiorsProps = {
			"security_high",
			"equipment_basic",
			"equipment_upgrade",
			"production_upgrade",
			"table_equipment_upgrade",
			"coke_press_upgrade",
			"security_low",
			"set_up"
		},
		coords = {{ -1108.0826416016,4945.5268554688,218.64976501465 }} -- Cocaina
	},
	{
		interiorsProps = {
			"counterfeit_cashpile100a",
			"counterfeit_cashpile100b",
			"counterfeit_cashpile100c",
			"counterfeit_cashpile100d",
			"counterfeit_security",
			"counterfeit_setup",
			"counterfeit_standard_equip",
			"money_cutter",
			"special_chairs",
			"dryera_on",
			"dryerb_on",
			"dryerc_on",
			"dryerd_on"
		},
		coords = {{ 1121.0,-3196.0,-40.4 }} -- Lavagem
	},
	{
		interiorsProps = {
			"coke_stash1",
			"coke_stash2",
			"coke_stash3",
			"decorative_02",
			"furnishings_02",
			"walls_01",
			"mural_02",
			"gun_locker",
			"mod_booth"
		},
		coords = {{ 1107.0,-3157.3,-37.5 }} -- Motoclub
	},
	{
		interiorsProps = {
			"coke_large",
			"decorative_01",
			"furnishings_01",
			"walls_01",
			"lower_walls_default",
			"gun_locker",
			"mod_booth"
		},
		coords = {{ 998.4,-3164.7,-38.9 }} -- Motoclub2
	},
	{
		interiorsProps = {
			"chair01",
			"equipment_basic",
			"interior_upgrade",
			"security_low",
			"set_up"
		},
		coords = {{ 1163.8,-3195.7,-39.0 }} -- Escritório
	},
	{
		interiorsProps = {
			"garage_decor_01",
			"garage_decor_02",
			"garage_decor_03",
			"garage_decor_04",
			"lighting_option01",
			"lighting_option02",
			"lighting_option03",
			"lighting_option04",
			"lighting_option05",
			"lighting_option06",
			"lighting_option07",
			"lighting_option08",
			"lighting_option09",
			"numbering_style01_n3",
			"numbering_style02_n3",
			"numbering_style03_n3",
			"numbering_style04_n3",
			"numbering_style05_n3",
			"numbering_style06_n3",
			"numbering_style07_n3",
			"numbering_style08_n3",
			"numbering_style09_n3",
			"urban_style_set",
			"car_floor_hatch",
			"door_blocker"
		},
		coords = {{ 994.59,-3002.59,-39.64 }} -- Mecanica
	},
	{
		interiorsProps = {
			"bunker_style_a",
			"upgrade_bunker_set",
			"security_upgrade",
			"office_upgrade_set",
			"gun_wall_blocker",
			"gun_range_lights",
			"gun_locker_upgrade",
			"Gun_schematic_set"
		},
		coords = {{ 899.55,-3246.03,-98.04 }} -- Bunker
	}
}