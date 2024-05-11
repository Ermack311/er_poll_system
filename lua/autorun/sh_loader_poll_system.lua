include("poll_system/sh_poll_config.lua")
AddCSLuaFile("poll_system/sh_poll_config.lua")

if SERVER then
    AddCSLuaFile("poll_system/client/cl_menu_poll.lua")
    
    include("poll_system/server/sv_poll_net.lua")
    include("poll_system/server/sv_mysql_module.lua")
elseif CLIENT then
    include("poll_system/client/cl_menu_poll.lua")
end
