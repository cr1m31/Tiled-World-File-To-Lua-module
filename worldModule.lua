-- read and change world files
local worldTable = {}

-- check if directory exists and create an empty worldTextData.lua
local worldDirectory = "tiledFiles/"
local worldFileName = "world_1"

function checkIfWorldFileAndCreateScript()
  if love.filesystem.getInfo(worldDirectory .. worldFileName .. ".world") then
    print(worldDirectory .. worldFileName .. ".world" .. " file exists")
    local worldToLuaScript = io.open("worldTextData.lua","w")
    worldToLuaScript:close()
  end
end
checkIfWorldFileAndCreateScript()

-- read the world json file of tiled and return his content as a string
function readAllWorldFile(file)
  local f = assert(io.open(file, "rb"))
  local content = f:read("*all")
  f:close()
  return content
end
-- read world json (.world) in the good directory
local TextContent = readAllWorldFile(worldDirectory .. worldFileName .. ".world")

local stringsToReplaceT = {"%:", "%[", "%]", "tmx"} -- json strings to replace in good order
local replaceStringsWith = {"=", "{", "}", "lua"} -- lua strings replacements in good order
function compareAndSubstituteStrings()
  for k, v in ipairs(stringsToReplaceT) do
    for i, j in ipairs(replaceStringsWith) do
      if k == i then -- if stringsToReplaceT index = replaceStringsWith index then
        --reuse TextContent and alter it each time k = i
        TextContent = string.gsub(TextContent, v, j)
      end
    end
  end
end  

compareAndSubstituteStrings()

local removeVarQuotes = {"maps", "onlyShowAdjacentMaps", "type", "fileName", "height", "width", "x", "y"}
local removePatternVarQuotes = {"patterns", "regexp", "multiplierX", "multiplierY", "offsetX", "offsetY"} -- lua is not compatible with POSIX regexp !!

for k, v in ipairs(removeVarQuotes) do
  match = '"' ..v .. '"'
  i, j = string.find(TextContent, match)
  TextContent = string.gsub(TextContent, match, v .. " ")
end

for k, v in ipairs(removePatternVarQuotes) do
  match = '"' ..v .. '"'
  i, j = string.find(TextContent, match)
  TextContent = string.gsub(TextContent, match, v .. " ")
end


function addReturnString()
  local intitiateData = io.open("worldTextData.lua","w")
  intitiateData:write("return ")
  intitiateData:close()
end
addReturnString()

--remove empty space to avoid having a bad lua table
--TextContent = TextContent:gsub("%s+", "")
--TextContent = string.gsub(TextContent, "%s+", "")

local finishedToParse = false
local worldJsonToLua = nil
function writeToWorldTextData() -- write the lua code in the worldTextData.lua
  worldJsonToLua = io.open("worldTextData.lua","a") -- append textContent to return
  worldJsonToLua:write(TextContent)
  worldJsonToLua:close() --dont forget to close or accessing the worldTextData module will make a boolean error
end
  
writeToWorldTextData()



  local requireWorldData = require("worldTextData")

  for k, v in pairs(requireWorldData.maps) do -- making a boolean  error when requiring if the worldTextData.lua file is not closed
    print(requireWorldData.maps[k].fileName)
  end




return worldTable
