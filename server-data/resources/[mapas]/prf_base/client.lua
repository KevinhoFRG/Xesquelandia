
local blips = {
  {title="PRF_BASE", colour=46, id=60, x = -2495.90500000, y = 3592.15100000, z = 12.48370000}, 
}

local coefflouze = 0.1 --Coeficient multiplicateur qui en fonction de la distance definit la paie

--INIT--

local isInJobMec = false
local livr = 0
local plateab = "POPJOBS"
local isToHouse = false
local isToMcdonalds = false
local paie = 0

local pourboire = 0
local posibilidad = 0
local px = 0
local py = 0
local pz = 0