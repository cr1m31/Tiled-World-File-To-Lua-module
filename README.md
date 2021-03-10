# Tiled-World-File-To-Lua-module
This is a lua module to convert Tiled world files into lua module.

You can require the worldModule.lua in your lua project.
(in my case, a Love2d project)

On top of the module script, you need to specify the .world file directory 
(where Tiled saved the world file)
local worldDirectory = "tiledFiles/"

and here , specify the world file name without the .world extention
local worldFileName = "world_1" 
(not "world_1.world").

Now, once you require this worldModule, it will convert and save a "worldTextData.lua" file
in the same directory of your lua project. 

Then, you can require this new module with lua code...

You can also run this script from the windows cmd console,
just need to have a tiledFiles folder with the world file in it.
Then run the worldModule.lua from cmd.
