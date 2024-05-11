util.AddNetworkString("open_poll_menu")

hook.Add("PlayerSpawn", "Spawn_open_poll_menu", function(ply)
    if ply:GetPData('DataPoll', 0) == 0 then
        timer.Simple(ER.TimerOpenMenu, function()
            net.Start("open_poll_menu")
            net.Send(ply)
            ply:SetPData('DataPoll', 1)
        end)
    end
end)