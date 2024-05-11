boolList = {}
send_question = {}
active_button = {}
function OpenMenuPollSystem()

    local Dframe = vgui.Create("DFrame")
    Dframe:SetPos(10,ScrH() - 240) 
    Dframe:SetSize(300, 200)
    Dframe:SetTitle("")
    Dframe:ShowCloseButton(true)
    Dframe:MakePopup()
    Dframe.Paint = function(self,w,h)
        draw.RoundedBox(0, 0, 0, w, h, ER.ColorMainMenu)
    end

    local DScrollPanel = vgui.Create( "DScrollPanel", Dframe )
    DScrollPanel:Dock( FILL )
    local posy = 1
    for k, v in pairs(ER.PollQuestion) do
        local Dpanel = DScrollPanel:Add("DPanel")
        Dpanel:SetPos(2,posy)
        Dpanel:SetSize(Dframe:GetWide() - 4, 45 )
        Dpanel.Paint = function(self,w,h)
            draw.RoundedBox(0, 0, 0, w, h, ER.ColorSecondPanel)    
            draw.SimpleText(v.name, ER.TextFont, 7,5,Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        end

        if v.textenry then
            textEnry = vgui.Create("DTextEntry", Dpanel)
            --textEnry:SetMultiline(true)
            textEnry:SetPos(0,Dpanel:GetTall() - 20)
            textEnry:SetSize(Dpanel:GetWide(),20)
            textEnry:SetFont(ER.TextFont)
            textEnry:SetText(ER.Recommendation)
            textEnry.Paint = function(self)
                surface.SetDrawColor(ER.ColorTextEnryPanel)
                surface.DrawRect(0, 0, self:GetWide(), self:GetTall())
                self:DrawTextEntryText(Color(255, 255, 255), Color(30, 130, 255), Color(255, 255, 255))
            end
            textEnry.OnEnter = function( self )
                send_question[k] = self:GetValue()
                all_send_question = {}
                table.insert(all_send_question,send_question)
            end
            local sbar = DScrollPanel:GetVBar()
            function sbar:Paint(w, h)
                draw.RoundedBox(0, 0 + 5, 0, w/2, h, Color(0, 0, 0, 0))
            end
            function sbar.btnUp:Paint(w, h)
                draw.RoundedBox(0, 0, 0, w/2, h, Color(200, 100, 0,0))
            end
            function sbar.btnDown:Paint(w, h)
                draw.RoundedBox(0, 0, 0, w/2, h, Color(200, 100, 0,0))
            end
            function sbar.btnGrip:Paint(w, h)
                draw.RoundedBox(5, 0 + 5, 0, w/2, h, ER.ColorPanelDScroll)
            end
        else
            local Dbutton = vgui.Create("DButton", Dpanel)
            Dbutton:SetPos(0,Dpanel:GetTall() - 20)
            Dbutton:SetSize(Dpanel:GetWide()/2 - 2,20)
            Dbutton:SetText("")
            Dbutton.Paint = function(self,w,h)
                if Dbutton.IsHover || active_button[k] then
                    draw.RoundedBox(0, 0, 0, w, h, ER.ColorButtonHover)
                    draw.SimpleTextOutlined(ER.TextYes, ER.TextFont, Dbutton:GetWide()/2-15, 3, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color( 0, 0, 0, 255 ))
                else
                    draw.RoundedBox(0, 0, 0, w, h, ER.ColorButtonNoHover)
                    draw.SimpleText(ER.TextYes, ER.TextFont, Dbutton:GetWide()/2-15, 3, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                end
            end
            Dbutton.OnCursorEntered = function()
                Dbutton.IsHover = true
            end
            Dbutton.OnCursorExited = function()
                Dbutton.IsHover = false
            end

            Dbutton.DoClick = function()				
                boolList[k] = true
                active_button[k] = true
                all_boolList = {}
                table.insert(all_boolList,boolList)
            end

            local Dbutton1 = vgui.Create("DButton", Dpanel)
            Dbutton1:SetPos(Dpanel:GetWide() - Dpanel:GetWide()/2 + 2,Dpanel:GetTall() - 20)
            Dbutton1:SetSize(Dpanel:GetWide()/2,20)
            Dbutton1:SetText("")
            Dbutton1.Paint = function(self,w,h)
                if Dbutton1.IsHover || !active_button[k] then
                    draw.RoundedBox(0, 0, 0, w, h, ER.ColorButtonHover)
                    draw.SimpleTextOutlined(ER.TextNot, ER.TextFont, Dbutton1:GetWide()/2-15, 3, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color( 0, 0, 0, 255 ))
                else
                    draw.RoundedBox(0, 0, 0, w, h, ER.ColorButtonNoHover)
                    draw.SimpleText(ER.TextNot, ER.TextFont, Dbutton1:GetWide()/2-15, 3, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                end
            end
            Dbutton1.OnCursorEntered = function()
                Dbutton1.IsHover = true
            end
            Dbutton1.OnCursorExited = function()
                Dbutton1.IsHover = false
            end

            Dbutton1.DoClick = function()				
                boolList[k] = false
                active_button[k] = false
            end
        end
        posy = posy + 50
    end
    local DbuttonHabelLove = DScrollPanel:Add("DButton")
    DbuttonHabelLove:SetPos(2,posy)
    DbuttonHabelLove:SetSize(Dframe:GetWide() - 4, 25)
    DbuttonHabelLove:SetText("")
    DbuttonHabelLove.Paint = function(self,w,h)
        if DbuttonHabelLove.IsHover then
            draw.RoundedBox(0, 0, 0, w, h, ER.ColorButtonHover)
            draw.SimpleTextOutlined(ER.Accept, ER.TextFont, DbuttonHabelLove:GetWide()/2-15, 3, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color( 0, 0, 0, 255 ))
        else
            draw.RoundedBox(0, 0, 0, w, h, ER.ColorButtonNoHover)
            draw.SimpleText(ER.Accept, ER.TextFont, DbuttonHabelLove:GetWide()/2-15, 3, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        end
    end
    DbuttonHabelLove.OnCursorEntered = function()
        DbuttonHabelLove.IsHover = true
    end
    DbuttonHabelLove.OnCursorExited = function()
        DbuttonHabelLove.IsHover = false
    end
    DbuttonHabelLove.DoClick = function()

        Dframe:Close()
    end
end

net.Receive("open_poll_menu", OpenMenuPollSystem)
concommand.Add("menu", OpenMenuPollSystem)
concommand.Add("menu_test", function()
  --print(textEnry:GetValue())
    PrintTable(all_send_question)
    --PrintTable(boolList)
end)