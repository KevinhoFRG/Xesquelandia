local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

inMenu                      = true

local emotePiss = false
local emoteCoffee = false
local emoteSmoke = false
local Menu = true
local emotePlaying = IsPedActiveInScenario(PlayerPedId())
local player = (PlayerPedId())
-- Core Threading           

if Menu then
	Citizen.CreateThread(function()
  while true do
    Wait(0)
	
		if IsControlJustPressed(1, 170) then
			inMenu = true
			SetNuiFocus(true, true)
			SendNUIMessage({type = 'openGeneral'})
		
		end
	end
        
    if IsControlJustPressed(1, 3) then
	  inMenu = false
      SetNuiFocus(false)
      SendNUIMessage({type = 'close'})
     
    
	end
  end)
end


-- Cancel emote

function cancelEmote()
  ClearPedTasks(PlayerPedId())
  emotePlaying = false
end
-- Cancel piss emote and start a outro

function cancelPiss()
  RequestAnimDict( "misscarsteal2peeing" )

  TaskPlayAnim(PlayerPedId(), "misscarsteal2peeing" ,"peeing_outro" ,8.0, -8.0, -1, 0, 0, false, false, false )
     
  emotePiss = false
end


-- Cancel Coffee

function cancelCoffee()

  ClearPedTasks(PlayerPedId())
     
  emoteCoffee = false
end


--Cancel smoke

function cancelSmoke()

  ClearPedTasks(PlayerPedId())
     
  emoteSmoke = false
end


-- Send event back aka return button

RegisterNetEvent('sex:back')
AddEventHandler('sex:back', function(sex)

	SendNUIMessage({type = 'sexReturn', se = sex})

end)

RegisterNetEvent('misc:back')
AddEventHandler('misc:back', function(misc)

	SendNUIMessage({type = 'miscReturn', mis = misc})

end)

RegisterNetEvent('festive:back')
AddEventHandler('festive:back', function(festive)

	SendNUIMessage({type = 'festiveReturn', fest = festive})

end)

RegisterNetEvent('jobb:back')
AddEventHandler('jobb:back', function(jobb)

	SendNUIMessage({type = 'jobbReturn', job = jobb})

end)

RegisterNetEvent('humor:back')
AddEventHandler('humor:back', function(humor)

	SendNUIMessage({type = 'humorReturn', hum = humor})

end)


-- NUIFocusoff

RegisterNUICallback('NUIFocusOff', function()
  inMenu = false
  SetNuiFocus(false)
  SendNUIMessage({type = 'closeAll'})
end)


-- EMOTES Example
-- create Animation with Anim --
RegisterNUICallback('knappensNamn', function()

	TaskStartScenarioInPlace(PlayerPedId(), "anim", 0, true)
  ResetScenarioTypesEnabled()
  emotePlaying = true -- Cancel emote

end)


-- create animation with Lib + Anim --
RegisterNUICallback('knappensNamn', function()
  vRP.playAnim(true,{{"anim@animr","Lib",1}},false)
  --RequestAnimDict("anim@animr")
  --
  --while not HasAnimDictLoaded("anim@anim") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "anim@anim" ,"Lib" ,8.0, -8.0, -1, 0, 0, false, false, false )
  emotePlaying = true -- Cancel emote

end)


-- EMOTES - Greetings - //Left side

RegisterNUICallback('gesture_hello', function()
  vRP.playAnim(true,{{"gestures@m@standing@casual","gesture_hello",1}},false)
  --RequestAnimDict("gestures@m@standing@casual")
  --
  --while not HasAnimDictLoaded("gestures@m@standing@casual") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "gestures@m@standing@casual" ,"gesture_hello" ,8.0, -8.0, -1, 0, 0, false, false, false )
  emotePlaying = true
 
end)

RegisterNUICallback('givetake1_a', function()
  vRP.playAnim(true,{{"mp_common","givetake1_a",1}},false)
  --RequestAnimDict("mp_common")
  --
  --while not HasAnimDictLoaded("mp_common") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "mp_common" ,"givetake1_a" ,8.0, -8.0, -1, 0, 0, false, false, false )
  emotePlaying = true
end)

RegisterNUICallback('handshake_guy_a', function()

  vRP.playAnim(true,{{"mp_ped_interaction","handshake_guy_a",1}},false)
  --RequestAnimDict("mp_ped_interaction")
  --
  --while not HasAnimDictLoaded("mp_ped_interaction") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "mp_ped_interaction" ,"handshake_guy_a" ,8.0, -8.0, -1, 0, 0, false, false, false )
  emotePlaying = true

end)

RegisterNUICallback('hugs_guy_a', function()
  vRP.playAnim(true,{{"mp_ped_interaction","hugs_guy_a",1}},false)
  --RequestAnimDict("mp_ped_interaction")
  --
  --while not HasAnimDictLoaded("mp_ped_interaction") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "mp_ped_interaction" ,"hugs_guy_a" ,8.0, -8.0, -1, 0, 0, false, false, false )
  emotePlaying = true

end)

RegisterNUICallback('mp_player_int_salute', function()
  vRP.playAnim(true,{{"mp_player_int_uppersalute","mp_player_int_salute",1}},false)
  --RequestAnimDict("mp_player_int_uppersalute")
  --
  --while not HasAnimDictLoaded("mp_player_int_uppersalute") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "mp_player_int_uppersalute" ,"mp_player_int_salute" ,8.0, -8.0, -1, 0, 0, false, false, false )
  emotePlaying = true
 
end)

RegisterNUICallback('kisses_guy_b', function()
  vRP.playAnim(true,{{"mp_ped_interaction","kisses_guy_b",1}},false)
  --RequestAnimDict("mp_ped_interaction")
  --
  --while not HasAnimDictLoaded("mp_ped_interaction") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "mp_ped_interaction" ,"kisses_guy_b" ,8.0, -8.0, -1, 0, 0, false, false, false )
  emotePlaying = true

end)

RegisterNUICallback('fuck_off', function()
  vRP.playAnim(true,{{"mp_player_int_upperfinger","mp_player_int_finger_01_enter",1}},false)
  --RequestAnimDict("mp_player_int_upperfinger")
  --
  --while not HasAnimDictLoaded("mp_player_int_upperfinger") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "mp_player_int_upperfinger" ,"mp_player_int_finger_01_enter" ,8.0, -8.0, -1, 0, 0, false, false, false )
  emotePlaying = true

end)


-- EMOTES - Sex //Sexställningar

RegisterNUICallback('mp_player_int_grab_crotch', function()
  vRP.playAnim(true,{{"mp_player_int_uppergrab_crotch","mp_player_int_grab_crotch",1}},false)
  --RequestAnimDict("mp_player_int_uppergrab_crotch")
  --
  --while not HasAnimDictLoaded("mp_player_int_uppergrab_crotch") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "mp_player_int_uppergrab_crotch" ,"mp_player_int_grab_crotch" ,8.0, -8.0, -1, 9, 0, false, false, false )
  emotePlaying = true
end)

RegisterNUICallback('stripper_idle_02', function()
  vRP.playAnim(true,{{"mini@strip_club@idles@stripper","stripper_idle_02",1}},false)
  --RequestAnimDict("mini@strip_club@idles@stripper")
  --
  --while not HasAnimDictLoaded("mini@strip_club@idles@stripper") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "mini@strip_club@idles@stripper" ,"stripper_idle_02" ,8.0, -8.0, -1, 9, 0, false, false, false )
  emotePlaying = true

end)

RegisterNUICallback('WORLD_HUMAN_PROSTITUTE_HIGH_CLASS', function()

	TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS", 0, true)
  ResetScenarioTypesEnabled()
  emotePlaying = true
end)

RegisterNUICallback('stripper_b_backroom_idle_b', function()
  vRP.playAnim(true,{{"mini@strip_club@backroom@","stripper_b_backroom_idle_b",1}},false)
  --RequestAnimDict("mini@strip_club@backroom@")
  --
  --while not HasAnimDictLoaded("mini@strip_club@backroom@") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "mini@strip_club@backroom@" ,"stripper_b_backroom_idle_b" ,8.0, -8.0, -1, 9, 0, false, false, false )
  emotePlaying = true

end)

RegisterNUICallback('ld_girl_a_song_a_p1_f', function()
  vRP.playAnim(false,{{"mini@strip_club@lap_dance@ld_girl_a_song_a_p1","ld_girl_a_song_a_p1_f",1}},false)
  --RequestAnimDict("mini@strip_club@lap_dance@ld_girl_a_song_a_p1")
  --
  --while not HasAnimDictLoaded("mini@strip_club@lap_dance@ld_girl_a_song_a_p1") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "mini@strip_club@lap_dance@ld_girl_a_song_a_p1" ,"ld_girl_a_song_a_p1_f" ,8.0, -8.0, -1, 0, 0, false, false, false )
  emotePlaying = true
end)

RegisterNUICallback('priv_dance_p2', function()
  vRP.playAnim(false,{{"mini@strip_club@private_dance@part2","priv_dance_p2",1}},false)
  --RequestAnimDict("mini@strip_club@private_dance@part2")
  --
  --while not HasAnimDictLoaded("mini@strip_club@private_dance@part2") do
  --  Citizen.Wait(0)
  --  emotePlaying = true
  --end
  --TaskPlayAnim(PlayerPedId(), "mini@strip_club@private_dance@part2" ,"priv_dance_p2" ,8.0, -8.0, -1, 9, 0, false, false, false )
  emotePlaying = true

end)

RegisterNUICallback('priv_dance_p3', function()
  vRP.playAnim(false,{{"mini@strip_club@private_dance@part3","priv_dance_p3",1}},false)
  --RequestAnimDict("mini@strip_club@private_dance@part3")
  --
  --while not HasAnimDictLoaded("mini@strip_club@private_dance@part3") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "mini@strip_club@private_dance@part3" ,"priv_dance_p3" ,8.0, -8.0, -1, 9, 0, false, false, false )
  emotePlaying = true

end)


-- For coffee emote. Prop + walk with coffee
-- To use, add following:
--RegisterNUICallback('buttonsNameHere', function()
--coffeeDrink() --starts the coffee emote
--emoteCoffee = true --cancels the coffe emote.
--end)
--
function coffeeDrink()

  
  local coords     = GetEntityCoords(PlayerPedId())
  local bone       = GetPedBoneIndex(PlayerPedId(), 28422)
  local coffeeModel = GetHashKey('p_amb_coffeecup_01')

  Citizen.CreateThread(function()

    --RequestAnimDict('amb@world_human_aa_coffee@idle_a')
    --
    --while not HasAnimDictLoaded('amb@world_human_aa_coffee@idle_a') do
    --  Citizen.Wait(0)
    --end
    --
    --
    --
	--TaskPlayAnim(PlayerPedId(), 'amb@world_human_aa_coffee@idle_a', 'idle_c',1.0, -1, -1, 50, 0, false, false, false)
 
	vRP.playAnim(true,{{"amb@world_human_aa_coffee@idle_a","idle_c",1}},false)
    RequestModel(coffeeModel)
    
    while not HasModelLoaded(coffeeModel) do
      Citizen.Wait(10)
    end

    CoffeeObject = CreateObject(coffeeModel, coords.x, coords.y, coords.z, 1, 1, 0)

    AttachEntityToEntity(CoffeeObject, PlayerPedId(), bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
    
    
  end)
end

RegisterNUICallback('CoffeeTest', function()
 
  
  coffeeDrink()
  emoteCoffee = true
end)

RegisterNUICallback('coffee', function()
 
  coffeeDrink()
  emoteCoffee = true
  --TaskStartScenarioInPlace(PlayerPedId(), "world_human_aa_coffee", 0, true)
  --ResetScenarioTypesEnabled()
  emotePlaying = true
 
end)
 

-- EMOTES - Misc //Olika  //other

RegisterNUICallback('sitt1', function()
  RequestAnimDict("anim@heists@prison_heistunfinished_biztarget_idle")

  while not HasAnimDictLoaded("anim@heists@prison_heistunfinished_biztarget_idle") do
    Citizen.Wait(0)

  end
  TaskPlayAnim(PlayerPedId(), "anim@heists@prison_heistunfinished_biztarget_idle" ,"target_idle" ,8.0, -8.0, -1, 9, 0, false, false, false )
  emotePlaying = true

end)

RegisterNUICallback('world_human_leaning', function()

  --TaskStartScenarioInPlace(PlayerPedId(), "world_human_leaning", 0, true)
  vRP.playAnim(false,{{"amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base",1}},true)
			
  emotePlaying = true

end)

RegisterNUICallback('WORLD_HUMAN_SUNBATHE_BACK', function()

	TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_SUNBATHE_BACK", 0, true)
  ResetScenarioTypesEnabled()
  emotePlaying = true

end)

RegisterNUICallback('WORLD_HUMAN_SUNBATHE', function()

	TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_SUNBATHE", 0, true)
  ResetScenarioTypesEnabled()
  emotePlaying = true

end)

RegisterNUICallback('WORLD_HUMAN_TOURIST_MAP', function()

	TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_TOURIST_MAP", 0, true)
  ResetScenarioTypesEnabled()
  emotePlaying = true

end)

RegisterNUICallback('WORLD_HUMAN_CONST_DRILL', function()

	TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CONST_DRILL", 0, true)
  ResetScenarioTypesEnabled()
  emotePlaying = true

end)

RegisterNUICallback('wanker', function()
  RequestAnimDict("mp_player_intwank")

  while not HasAnimDictLoaded("mp_player_intwank") do
    Citizen.Wait(0)

  end
  TaskPlayAnim(PlayerPedId(), "mp_player_intwank" ,"mp_player_int_wank" ,8.0, -8.0, -1, 0, 0, false, false, false )
  emotePlaying = true

end)

RegisterNUICallback('world_human_tourist_mobile', function()

	TaskStartScenarioInPlace(PlayerPedId(), "world_human_tourist_mobile", 0, true)
  ResetScenarioTypesEnabled()
  emotePlaying = true

end)


RegisterNUICallback('WORLD_HUMAN_HUMAN_STATUE', function()

	TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_HUMAN_STATUE", 0, true)
  ResetScenarioTypesEnabled()
  emotePlaying = true

end)

RegisterNUICallback('Piss', function()
  RequestAnimDict("misscarsteal2peeing")
  while not HasAnimDictLoaded("misscarsteal2peeing") do
    Citizen.Wait(0)
  end
  TaskPlayAnim(PlayerPedId(), "misscarsteal2peeing" ,"peeing_loop" ,8.0, -8.0, -1, 9, 0, false, false, false )
          emotePiss = true

end)

RegisterNUICallback('BUSTED', function()
    RequestAnimDict("random@arrests")
    RequestAnimDict("random@arrests@busted")
    while not HasAnimDictLoaded("random@arrests") do
      Citizen.Wait(0)
    end
	TaskPlayAnim(PlayerPedId(), "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )       
	Wait (4000)
	TaskPlayAnim(PlayerPedId(), "random@arrests", "kneeling_arrest_idle", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
	Wait (500)
	TaskPlayAnim(PlayerPedId(), "random@arrests@busted", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
	Wait (1000)
	TaskPlayAnim(PlayerPedId(), "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 9, 0, 0, 0, 0 )
	emotePlaying = true
end)

  
 



-- For smoke emote. Prop + walk and smoke
-- To use, add following:
--RegisterNUICallback('buttonsNameHere', function()
--smoke() --starts the smoke emote
--emoteSmoke = true = true --cancels the smoke emote.
--end)
--

function smoke()
  local coords     = GetEntityCoords(PlayerPedId())
  local bone       = GetPedBoneIndex(PlayerPedId(), 28422)
  local smokeModel = GetHashKey('prop_sh_joint_01')
  Citizen.CreateThread(function()
    --RequestAnimDict('amb@world_human_aa_smoke@male@idle_a')
    --while not HasAnimDictLoaded('amb@world_human_aa_smoke@male@idle_a') do
    --  Citizen.Wait(0)
    --end
	--TaskPlayAnim(PlayerPedId(), 'amb@world_human_aa_smoke@male@idle_a', 'idle_a',1.0, -1, -1, 50, 0, false, false, false)
	vRP.playAnim(true,{{"amb@world_human_aa_smoke@male@idle_a","idle_a",1}},false)
    RequestModel(smokeModel)
    while not HasModelLoaded(smokeModel) do
      Citizen.Wait(10)
    end
    SmokeObject = CreateObject(smokeModel, coords.x, coords.y, coords.z, 1, 1, 0)
    AttachEntityToEntity(SmokeObject, PlayerPedId(), bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
  end)
end


-- EMOTES - Festive //festliga

RegisterNUICallback('WORLD_HUMAN_SMOKING', function()
  --TaskStartScenarioInPlace(PlayerPedId(), "world_human_aa_smoke", 0, true)
  --ResetScenarioTypesEnabled()
  emotePlaying = true
  smoke()
  emoteSmoke = true

end)

RegisterNUICallback('WORLD_HUMAN_MUSICIAN', function()

	TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_MUSICIAN", 0, true)
  ResetScenarioTypesEnabled()
  emotePlaying = true

end)

RegisterNUICallback('djj', function()
  vRP.playAnim(true,{{"anim@mp_player_intcelebrationmale@dj","dj",1}},false)
  --RequestAnimDict("anim@mp_player_intcelebrationmale@dj")
  --
  --while not HasAnimDictLoaded("anim@mp_player_intcelebrationmale@dj") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "anim@mp_player_intcelebrationmale@dj" ,"dj" ,8.0, -8.0, -1, 9, 0, false, false, false )
  emotePlaying = true

end)

RegisterNUICallback('WORLD_HUMAN_DRINKING', function()

	TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_DRINKING", 0, true)
  ResetScenarioTypesEnabled()
  emotePlaying = true

end)

RegisterNUICallback('air_guitar', function()
  vRP.playAnim(true,{{"anim@mp_player_intcelebrationmale@air_guitar","air_guitar",1}},false)
  --RequestAnimDict("anim@mp_player_intcelebrationmale@air_guitar")
  --
  --while not HasAnimDictLoaded("anim@mp_player_intcelebrationmale@air_guitar") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "anim@mp_player_intcelebrationmale@air_guitar" ,"air_guitar" ,8.0, -8.0, -1, 0, 0, false, false, false )
  emotePlaying = true

end)

RegisterNUICallback('air_shagging', function()
  vRP.playAnim(true,{{"anim@mp_player_intcelebrationfemale@air_shagging","air_shagging",1}},false)
  --RequestAnimDict("anim@mp_player_intcelebrationfemale@air_shagging")
  --
  --while not HasAnimDictLoaded("anim@mp_player_intcelebrationfemale@air_shagging") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "anim@mp_player_intcelebrationfemale@air_shagging" ,"air_shagging" ,8.0, -8.0, -1, 0, 0, false, false, false )
  emotePlaying = true

end)

RegisterNUICallback('mp_player_int_rock', function()
  vRP.playAnim(true,{{"mp_player_int_upperrock","mp_player_int_rock",1}},false)
  --RequestAnimDict("mp_player_int_upperrock")
  --
  --while not HasAnimDictLoaded("mp_player_int_upperrock") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "mp_player_int_upperrock" ,"mp_player_int_rock" ,8.0, -8.0, -1, 0, 0, false, false, false )
  emotePlaying = true

end)

RegisterNUICallback('bumdrunk', function()
  vRP.playAnim(true,{{"amb@world_human_bum_standing@drunk@idle_a","idle_a",1}},false)
  --RequestAnimDict("amb@world_human_bum_standing@drunk@idle_a")
  --
  --while not HasAnimDictLoaded("amb@world_human_bum_standing@drunk@idle_a") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "amb@world_human_bum_standing@drunk@idle_a" ,"idle_a" ,8.0, -8.0, -1, 0, 0, false, false, false )
  emotePlaying = true
end)



RegisterNUICallback('randomOne', function()
  vRP.playAnim(true,{{"amb@world_human_cheering@male_a","base",1}},false)
  --RequestAnimDict("amb@world_human_cheering@male_a")
  --
  --while not HasAnimDictLoaded("amb@world_human_cheering@male_a") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "amb@world_human_cheering@male_a" ,"base" ,8.0, -8.0, -1, 0, 0, false, false, false )
  emotePlaying = true

end)

RegisterNUICallback('weirdDance', function()
  vRP.playAnim(true,{{"special_ped@mountain_dancer@monologue_1@monologue_1a","mtn_dnc_if_you_want_to_get_to_heaven",1}},false)
  --RequestAnimDict("special_ped@mountain_dancer@monologue_1@monologue_1a")
  --
  --while not HasAnimDictLoaded("special_ped@mountain_dancer@monologue_1@monologue_1a") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "special_ped@mountain_dancer@monologue_1@monologue_1a" ,"mtn_dnc_if_you_want_to_get_to_heaven" ,8.0, -8.0, -1, 0, 0, false, false, false )
  emotePlaying = true

end)

RegisterNUICallback('weirdDance2', function()
  vRP.playAnim(true,{{"misschinese2_crystalmazemcs1_ig","dance_loop_tao",1}},false)
  --RequestAnimDict("misschinese2_crystalmazemcs1_ig")
  --
  --while not HasAnimDictLoaded("misschinese2_crystalmazemcs1_ig") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "misschinese2_crystalmazemcs1_ig" ,"dance_loop_tao" ,8.0, -8.0, -1, 0, 0, false, false, false )
  emotePlaying = true

end)


RegisterNUICallback('fulDans', function()
  vRP.playAnim(true,{{"move_clown@p_m_two_idles@","fidget_short_dance",1}},false)
  --RequestAnimDict("move_clown@p_m_two_idles@")
  --
  --while not HasAnimDictLoaded("move_clown@p_m_two_idles@") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "move_clown@p_m_two_idles@" ,"fidget_short_dance" ,8.0, -8.0, -1, 0, 0, false, false, false )
  emotePlaying = true

end)


-- EMOTES - Jobb //jobb

RegisterNUICallback('code_human_police_investigate', function()
  vRP.playAnim(true,{{"amb@code_human_police_investigate@idle_b","idle_f",1}},false)
  --RequestAnimDict("amb@code_human_police_investigate@idle_b")
  --
  --while not HasAnimDictLoaded("amb@code_human_police_investigate@idle_b") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "amb@code_human_police_investigate@idle_b" ,"idle_f" ,8.0, -8.0, -1, 0, 0, false, false, false )
  emotePlaying = true

end)

RegisterNUICallback('randomarrests', function()
  vRP.playAnim(true,{{"random@arrests","generic_radio_chatter",1}},false)
  --RequestAnimDict("random@arrests")
  --
  --while not HasAnimDictLoaded("random@arrests") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "random@arrests" ,"generic_radio_chatter" ,8.0, -8.0, -1, 9, 0, false, false, false )
  emotePlaying = true

end)

RegisterNUICallback('WORLD_HUMAN_CAR_PARK_ATTENDANT', function()

	TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CAR_PARK_ATTENDANT", 0, true)
  ResetScenarioTypesEnabled()
  emotePlaying = true
end)

RegisterNUICallback('world_human_gardener_plant', function()

	TaskStartScenarioInPlace(PlayerPedId(), "world_human_gardener_plant", 0, true)
  ResetScenarioTypesEnabled()
  emotePlaying = true
end)
RegisterNUICallback('WORLD_HUMAN_GUARD_STAND', function()

	TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_COP_IDLES", 0, true)
  ResetScenarioTypesEnabled()
  emotePlaying = true
end)

RegisterNUICallback('minirepair', function()
  vRP.playAnim(true,{{"mini@repair","fixing_a_ped",1}},false)
  --RequestAnimDict("mini@repair")
  --
  --while not HasAnimDictLoaded("mini@repair") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "mini@repair" ,"fixing_a_ped" ,8.0, -8.0, -1, 0, 0, false, false, false )
  emotePlaying = true
end)


RegisterNUICallback('CODE_HUMAN_MEDIC_KNEEL', function()

	TaskStartScenarioInPlace(PlayerPedId(), "CODE_HUMAN_MEDIC_KNEEL", 0, true)
  emotePlaying = true

end)

RegisterNUICallback('sittpamarken', function()
  vRP.playAnim(true,{{"rcm_barry3","barry_3_sit_loop",1}},false)

  --RequestAnimDict("rcm_barry3")
  --
  --while not HasAnimDictLoaded("rcm_barry3") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "rcm_barry3" ,"barry_3_sit_loop" ,8.0, -8.0, -1, 9, 0, false, false, false )
  emotePlaying = true
 
end)

RegisterNUICallback('WORLD_HUMAN_MAID_CLEAN', function()

    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_MAID_CLEAN", 0, true)
    emotePlaying = true

end)

RegisterNUICallback('idle_b_timeofdeath', function()

	TaskStartScenarioInPlace(PlayerPedId(), "CODE_HUMAN_MEDIC_TIME_OF_DEATH", 0, true)
	emotePlaying = true

end)


RegisterNUICallback('WORLD_HUMAN_PAPARAZZI', function()

	TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_PAPARAZZI", 0, true)
  emotePlaying = true

end)

RegisterNUICallback('WORLD_HUMAN_CLIPBOARD', function()

	TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CLIPBOARD", 0, true)
  emotePlaying = true

end)

RegisterNUICallback('WORLD_HUMAN_HAMMERING', function()

	TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_HAMMERING", 0, true)
  emotePlaying = true

end)

RegisterNUICallback('medicpumpar', function()
  vRP.playAnim(false,{{"missheistfbi3b_ig8_2","cpr_loop_paramedic",1}},false)

  --RequestAnimDict("missheistfbi3b_ig8_2")
  --
  --while not HasAnimDictLoaded("missheistfbi3b_ig8_2") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "missheistfbi3b_ig8_2" ,"cpr_loop_paramedic" ,8.0, -8.0, -1, 9, 0, false, false, false )
  emotePlaying = true
 
end)

RegisterNUICallback('listendoor', function()
  vRP.playAnim(false,{{"mini@safe_cracking","idle_base",1}},false)
  --RequestAnimDict("mini@safe_cracking")
  --
  --while not HasAnimDictLoaded("mini@safe_cracking") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "mini@safe_cracking" ,"idle_base" ,8.0, -8.0, -1, 9, 0, false, false, false )
  emotePlaying = true
end)


-- EMOTES - Humor //humor

RegisterNUICallback('thanks_male_06', function()
  vRP.playAnim(false,{{"mp_action","thanks_male_06",1}},false)
  --RequestAnimDict("mp_action")
  --
  --while not HasAnimDictLoaded("mp_action") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "mp_action" ,"thanks_male_06" ,8.0, -8.0, -1, 0, 0, false, false, false )
  emotePlaying = true

end)

RegisterNUICallback('gesture_come_here_soft', function()
  vRP.playAnim(false,{{"gestures@m@standing@casual","gesture_come_here_soft",1}},false)
  --RequestAnimDict("gestures@m@standing@casual")
  --
  --while not HasAnimDictLoaded("gestures@m@standing@casual") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "gestures@m@standing@casual" ,"gesture_come_here_soft" ,8.0, -8.0, -1, 0, 0, false, false, false )
  emotePlaying = true

end)

RegisterNUICallback('gesture_bring_it_on', function()
  vRP.playAnim(false,{{"gestures@m@standing@casual","gesture_bring_it_on",1}},false)
  --RequestAnimDict("gestures@m@standing@casual")
  --
  --while not HasAnimDictLoaded("gestures@m@standing@casual") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "gestures@m@standing@casual" ,"gesture_bring_it_on" ,8.0, -8.0, -1, 0, 0, false, false, false )
  emotePlaying = true

end)

RegisterNUICallback('gesture_me', function()
  vRP.playAnim(false,{{"gestures@m@standing@casual","gesture_me",1}},false)
  --RequestAnimDict("gestures@m@standing@casual")
  --
  --while not HasAnimDictLoaded("gestures@m@standing@casual") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "gestures@m@standing@casual" ,"gesture_me" ,8.0, -8.0, -1, 0, 0, false, false, false )
  emotePlaying = true

end)

RegisterNUICallback('shoplift_high', function()
  vRP.playAnim(false,{{"anim@am_hold_up@male","shoplift_high",1}},false)
  --RequestAnimDict("anim@am_hold_up@male")
  --
  --while not HasAnimDictLoaded("anim@am_hold_up@male") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "anim@am_hold_up@male" ,"shoplift_high" ,8.0, -8.0, -1, 0, 0, false, false, false )
  emotePlaying = true

end)

RegisterNUICallback('world_human_jog', function()
  vRP.playAnim(false,{{"amb@world_human_jog_standing@male@idle_b","idle_d",1}},false)
  --RequestAnimDict("amb@world_human_jog_standing@male@idle_b")
  --
  --while not HasAnimDictLoaded("amb@world_human_jog_standing@male@idle_b") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "amb@world_human_jog_standing@male@idle_b" ,"idle_d" ,8.0, -8.0, -1, 0, 0, false, false, false )
  emotePlaying = true

end)

RegisterNUICallback('world_human_bum_standing', function()
  vRP.playAnim(false,{{"world_human_bum_standing","idle_a",1}},false)
 --RequestAnimDict("amb@world_human_bum_standing@depressed@idle_a")
 --
 --while not HasAnimDictLoaded("amb@world_human_bum_standing@depressed@idle_a") do
 --  Citizen.Wait(0)
 --
 --end
 --TaskPlayAnim(PlayerPedId(), "amb@world_human_bum_standing@depressed@idle_a" ,"idle_a" ,8.0, -8.0, -1, 0, 0, false, false, false )
  emotePlaying = true

end)

RegisterNUICallback('face_palm', function()
  vRP.playAnim(true,{{"anim@mp_player_intcelebrationmale@face_palm","face_palm",1}},false)
  --RequestAnimDict("anim@mp_player_intcelebrationmale@face_palm")
  --
  --while not HasAnimDictLoaded("anim@mp_player_intcelebrationmale@face_palm") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "anim@mp_player_intcelebrationmale@face_palm" ,"face_palm" ,8.0, -8.0, -1, 0, 0, false, false, false )
  emotePlaying = true

end)

RegisterNUICallback('gesture_easy_now', function()
  vRP.playAnim(true,{{"gestures@m@standing@casual","gesture_easy_now",1}},false)
  --RequestAnimDict("gestures@m@standing@casual")
  --
  --while not HasAnimDictLoaded("gestures@m@standing@casual") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "gestures@m@standing@casual" ,"gesture_easy_now" ,8.0, -8.0, -1, 0, 0, false, false, false )
  emotePlaying = true

end)

RegisterNUICallback('react_big_variations_a', function()
  vRP.playAnim(true,{{"oddjobs@assassinate@multi@","react_big_variations_a",1}},false)
  --RequestAnimDict("oddjobs@assassinate@multi@")
  --
  --while not HasAnimDictLoaded("oddjobs@assassinate@multi@") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "oddjobs@assassinate@multi@" ,"react_big_variations_a" ,8.0, -8.0, -1, 0, 0, false, false, false )
  emotePlaying = true

end)

RegisterNUICallback('base_right', function()
  vRP.playAnim(true,{{"amb@code_human_cower_stand@male@react_cowering","base_right",1}},false)
  --RequestAnimDict("amb@code_human_cower_stand@male@react_cowering")
  --
  --while not HasAnimDictLoaded("amb@code_human_cower_stand@male@react_cowering") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "amb@code_human_cower_stand@male@react_cowering" ,"base_right" ,8.0, -8.0, -1, 0, 0, false, false, false )
  emotePlaying = true

end)

RegisterNUICallback('intro_male_unarmed_e', function()
  vRP.playAnim(false,{{"anim@deathmatch_intros@unarmed","intro_male_unarmed_e",1}},false)
  --RequestAnimDict("anim@deathmatch_intros@unarmed")
  --
  --while not HasAnimDictLoaded("anim@deathmatch_intros@unarmed") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "anim@deathmatch_intros@unarmed" ,"intro_male_unarmed_e" ,8.0, -8.0, -1, 0, 0, false, false, false )
  emotePlaying = true

end)

RegisterNUICallback('gesture_damn', function()
  vRP.playAnim(true,{{"gestures@m@standing@casual","gesture_damn",1}},false)
  --RequestAnimDict("gestures@m@standing@casual")
  --
  --while not HasAnimDictLoaded("gestures@m@standing@casual") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "gestures@m@standing@casual" ,"gesture_damn" ,8.0, -8.0, -1, 0, 0, false, false, false )
  emotePlaying = true

end)

RegisterNUICallback('pistolsuicide', function()
  --RequestAnimDict("mp_suicide")
  --
  --while not HasAnimDictLoaded("mp_suicide") do
  --  Citizen.Wait(0)
  --
  --end
  --TaskPlayAnim(PlayerPedId(), "mp_suicide" ,"pistol" ,8.0, -8.0, -1, 0, 0, false, false, false )
  emotePlaying = true

end)


-- EMOTES - Sport //sport

RegisterNUICallback('world_human_muscle_flex', function()
  RequestAnimDict("amb@world_human_muscle_flex@arms_at_side@base")

  while not HasAnimDictLoaded("amb@world_human_muscle_flex@arms_at_side@base") do
    Citizen.Wait(0)

  end
  TaskPlayAnim(PlayerPedId(), "amb@world_human_muscle_flex@arms_at_side@base" ,"base" ,8.0, -8.0, -1, 0, 0, false, false, false )
  emotePlaying = true

end)

RegisterNUICallback('world_human_muscle_free_weights', function()
 

    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_MUSCLE_FREE_WEIGHTS", 0, true)
    emotePlaying = true

  end)

RegisterNUICallback('world_human_push_ups', function()
  RequestAnimDict("amb@world_human_push_ups@male@base")

  while not HasAnimDictLoaded("amb@world_human_push_ups@male@base") do
    Citizen.Wait(0)

  end
  TaskPlayAnim(PlayerPedId(), "amb@world_human_push_ups@male@base" ,"base" ,8.0, -8.0, -1, 9, 0, false, false, false )
  emotePlaying = true

end)

RegisterNUICallback('world_human_sit_ups', function()
  RequestAnimDict("amb@world_human_sit_ups@male@base")

  while not HasAnimDictLoaded("amb@world_human_sit_ups@male@base") do
    Citizen.Wait(0)

  end
  TaskPlayAnim(PlayerPedId(), "amb@world_human_sit_ups@male@base" ,"base" ,8.0, -8.0, -1, 9, 0, false, false, false )
  emotePlaying = true

end)

RegisterNUICallback('world_human_yoga', function()
  RequestAnimDict("amb@world_human_yoga@male@base")

  while not HasAnimDictLoaded("amb@world_human_yoga@male@base") do
    Citizen.Wait(0)

  end
  TaskPlayAnim(PlayerPedId(), "amb@world_human_yoga@male@base" ,"base_a" ,8.0, -8.0, -1, 9, 0, false, false, false )
  emotePlaying = true

end)

RegisterNUICallback('WORLD_HUMAN_JOG_STANDING', function()
 

  TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_JOG_STANDING", 0, true)
  emotePlaying = true
 
end)


-- Cancel emotes


Citizen.CreateThread(function()
  while true do

      if emotePlaying then
          --if (IsControlPressed(0, 32) or IsControlPressed(0, 33) or IsControlPressed(0, 34) or IsControlPressed(0, 35)) then
          --    cancelEmote()
          --end
      end

      Citizen.Wait(0)
  end
end)


--Text for smoke/coffee
function DisplayHelpText(Text)
	BeginTextCommandDisplayHelp('STRING')
	AddTextComponentSubstringPlayerName(Text)
	EndTextCommandDisplayHelp(0, 0, 1, -1)
end


--Calls when coffee is pressed and active. 
Citizen.CreateThread(function()
  while true do
   
      if emoteCoffee then
      DisableControlAction(0, 24,   true) -- Input Attack
      DisableControlAction(0, 140,  true) -- Melee Attack Alternate
      DisableControlAction(0, 141,  true) -- Melee Attack Alternate
      DisableControlAction(0, 142,  true) -- Melee Attack Alternate
      DisableControlAction(0, 257,  true) -- Input Attack 2
      DisableControlAction(0, 263,  true) -- Input Melee Attack
      DisableControlAction(0, 264,  true) -- Input Melee Attack 2
      DisableControlAction(0, 12,   true) -- Weapon Wheel Up Down
      DisableControlAction(0, 14,   true) -- Weapon Wheel Next
      DisableControlAction(0, 15,   true) -- Weapon Wheel Prev
      DisableControlAction(0, 16,   true) -- Select Next Weapon
      DisableControlAction(0, 17,   true) -- Select Prev Weapon
	    DisableControlAction(0, 21,   true) -- Sprint
      DisableControlAction(0, 22,   true) -- Jump
      DisableControlAction(0, 288,   true) -- F1
      DisableControlAction(0, 289,   true) -- F2
       
      DisplayHelpText('~INPUT_CONTEXT~ para tomar o café.  ~INPUT_SELECT_CHARACTER_FRANKLIN~ para jogar fora')

        if (IsControlPressed(0, 170) or IsControlPressed(0, 167) or IsControlPressed(0, 322) or IsControlPressed(0, 177)  or IsControlPressed(0, 73)) then
              cancelCoffee()
              DeleteObject(CoffeeObject)
              Citizen.Wait(0)
              inMenu = false
              SetNuiFocus(false)
              SendNUIMessage({type = 'closeAll'})
     
        elseif (IsControlPressed(0, 38))then    
          TaskPlayAnim(PlayerPedId(), 'amb@world_human_aa_coffee@idle_a', 'idle_a', 9.0, 9.0, -1, 50, 1, false, false, 50 )

          Citizen.Wait(10)

          TaskPlayAnim(PlayerPedId(), 'amb@world_human_aa_coffee@idle_a', 'idle_a', 9.0, 9.0, -1, 50, 1, false, false, false )
              
        end
      end
    
      Citizen.Wait(0)
  end
end)


--Calls when smoke is pressed and active. 
Citizen.CreateThread(function()
  while true do
   
      if emoteSmoke then
      DisableControlAction(0, 24,   true) -- Input Attack
      DisableControlAction(0, 140,  true) -- Melee Attack Alternate
      DisableControlAction(0, 141,  true) -- Melee Attack Alternate
      DisableControlAction(0, 142,  true) -- Melee Attack Alternate
      DisableControlAction(0, 257,  true) -- Input Attack 2
      DisableControlAction(0, 263,  true) -- Input Melee Attack
      DisableControlAction(0, 264,  true) -- Input Melee Attack 2
      DisableControlAction(0, 12,   true) -- Weapon Wheel Up Down
      DisableControlAction(0, 14,   true) -- Weapon Wheel Next
      DisableControlAction(0, 15,   true) -- Weapon Wheel Prev
      DisableControlAction(0, 16,   true) -- Select Next Weapon
      DisableControlAction(0, 17,   true) -- Select Prev Weapon
	    DisableControlAction(0, 21,   true) -- Sprint
      DisableControlAction(0, 22,   true) -- Jump
      DisableControlAction(0, 288,   true) -- F1
      DisableControlAction(0, 289,   true) -- F2
       
      DisplayHelpText('~INPUT_CONTEXT~ para fumar.  ~INPUT_SELECT_CHARACTER_FRANKLIN~ para apagar')

        if (IsControlPressed(0, 170) or IsControlPressed(0, 167) or IsControlPressed(0, 322) or IsControlPressed(0, 177)  or IsControlPressed(0, 73)) then
              cancelSmoke()
              DeleteObject(SmokeObject)
              Citizen.Wait(0)
              inMenu = false
              SetNuiFocus(false)
              SendNUIMessage({type = 'closeAll'})
     
        elseif (IsControlPressed(0, 38))then    
         
          TaskPlayAnim(PlayerPedId(), 'amb@world_human_aa_smoke@male@idle_a', 'idle_c', 9.0, 9.0, -1, 50, 1, false, false, 50 )
         
          Citizen.Wait(10)

          TaskPlayAnim(PlayerPedId(), 'amb@world_human_aa_smoke@male@idle_a', 'idle_c', 9.0, 9.0, -1, 50, 1, false, false, false )
          smoke2()
        end
      end
    
      Citizen.Wait(0)
  end
end)


-- Calls when Piss is active, cancels the piss and start a animation.  cancelPiss()
Citizen.CreateThread(function()
  while true do

      if emotePiss then
          if (IsControlPressed(0, 32) or IsControlPressed(0, 33) or IsControlPressed(0, 34) or IsControlPressed(0, 35)) then
              cancelPiss()
          end
      end

      Citizen.Wait(0)
  end
end)

Citizen.CreateThread(function()
  while true do

      if emotewalks then
          if (IsControlPressed(0, 157)) then
              cancelPiss()
          end
      end

      Citizen.Wait(0)
  end
end)







--- Inte tillagda


RegisterNUICallback('WORLD_HUMAN_JANITOR', function()

  TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_JANITOR", 0, true)
  emotePlaying = true

end)

RegisterNUICallback('WORLD_HUMAN_BUM_FREEWAY', function()

	TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_BUM_FREEWAY", 0, true)
  emotePlaying = true

end)







