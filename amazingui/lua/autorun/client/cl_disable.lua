local hide = {

	CHudHealth = true,
	CHudBattery = true,
	CHudAmmo = true,
	
	["DarkRP_HUD"] = true,
	["DarkRP_EntityDisplay"] = true,
	["DarkRP_LocalPlayerHUD"] = true,
	["DarkRP_Hungermod"] = true,
	["DarkRP_Agenda"] = true,
	["DarkRP_LockdownHUD"] = true,
	["DarkRP_ArrestedHUD"] = true,

}

hook.Add( "HUDShouldDraw", "HideHUD", function( name )

	if hide[ name ] then return false end

end )