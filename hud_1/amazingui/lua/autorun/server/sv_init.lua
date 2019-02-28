local function LawsMenu( ply )

    umsg.Start( "LawsMenu", ply )

    umsg.End()
    
end

hook.Add("ShowHelp", "MyHook", LawsMenu)