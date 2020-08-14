resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

dependency 'vrp'
dependency 'vrp_adv_garages'

client_scripts {
  '@vrp/lib/utils.lua',
  'client/main.lua',
  'config.lua'
}

server_scripts {
  '@vrp/lib/utils.lua',
  'server/main.lua',
  'config.lua'
}

ui_page 'nui/ui.html'

files {
  'nui/ui.html',
	'nui/css.css',
  'nui/jquery.js'
}