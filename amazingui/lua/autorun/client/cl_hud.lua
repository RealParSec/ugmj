include( "cl_fonts.lua" )
include( "cl_functions.lua" )

// Scaling acording to resolution
local scalescreen = ( ( ScrW() / 1920 ) + ( ScrH() / 1080 ) ) / 2

// Laws variables
local LawsIcon = Material( "amazingui/laws.png", "noclamp smooth" )
local Laws = {
	"Do not attack other citizens except in self-defence.",
	"Do not steal or break in to peoples homes.",
	"Money printers/drugs are illegal.",
}
local LawsHON = false
local SmoothLaws = 0
local LawsPos = 0

// ID variables
local IDIcon = Material( "amazingui/id.png", "noclamp smooth" ) // ID icon

// Health variables
local HealthIcon = Material( "amazingui/health.png", "noclamp smooth" ) // Health icon
local MaxHealth = 0 // Max health so it wont print weird stuff

// Armor variables
local ArmorIcon = Material( "amazingui/armor.png", "noclamp smooth" ) // Armor icon
local MaxArmor = 100 // Max armor so it wont print weird stuff

//Job variables
local JobIcon = Material( "amazingui/job.png", "noclamp smooth" ) // Job Icon

// Wallet variables
local WalletIcon = Material( "amazingui/wallet.png", "noclamp smooth" ) // Wallet icon

// License variables
local LicenseIcon = Material( "amazingui/license.png", "noclamp smooth" )
local LicenseText = ""

// Play Time variables
local PlayTimeIcon = Material ( "amazingui/playtime.png", "noclamp smooth" )

local function HUDBackground()

	DrawBlurRect( 0, 0, ScrW(), 40 * scalescreen, 3, Color(0,0,0,200))
	draw.RoundedBox( 0, 0, 40 * scalescreen, ScrW(), amazinguitable.config.bbarheight * scalescreen, amazinguitable.config.uicolor )

end

local function HUDIDText()

	DrawTextRectangle( 5 * scalescreen, 10 * scalescreen, 20 * scalescreen, 20 * scalescreen, Color( 220, 220, 220 ), IDIcon )
	draw.SimpleText( LocalPlayer():Name(), "AUI_HUD_Font", 30 * scalescreen, 20 * scalescreen, Color( 220, 220, 220 ), 0, 1 )

end

local function HUDHealthText()

	local PlayerHealth = LocalPlayer():Health()

	if LocalPlayer():Alive() then

		if PlayerHealth > MaxHealth then

			MaxHealth = PlayerHealth

		end

	else

		MaxHealth = 100

	end

	if PlayerHealth < 0 then

		PlayerHealth = 0

	end

	surface.SetFont( "AUI_HUD_Font" )
	local width, height = surface.GetTextSize( LocalPlayer():Name() )

	DrawTextRectangle( 50 * scalescreen + width, 10 * scalescreen, 20 * scalescreen, 20 * scalescreen, Color( 220, 220, 220 ), HealthIcon )
	draw.SimpleText( math.floor( (PlayerHealth / MaxHealth * 100) ).."%", "AUI_HUD_Font", 75 * scalescreen + width, 20 * scalescreen, Color( 239, 81, 81 ), 0, 1 )

end

local function HUDArmorText()

	local width, height = surface.GetTextSize( LocalPlayer():Name()..math.floor( LocalPlayer():Health() / MaxHealth * 100 ).."%")
	local PlayerArmor = LocalPlayer():Armor()

	if LocalPlayer():Alive() then

		if PlayerArmor > MaxArmor then

			MaxArmor = PlayerArmor

		end

	else

		MaxArmor = 100

	end

	DrawTextRectangle( 95 * scalescreen + width, 10 * scalescreen, 20 * scalescreen, 20 * scalescreen, Color( 220, 220, 220 ), ArmorIcon )
	draw.SimpleText( math.floor( (PlayerArmor / MaxArmor * 100) ).."%", "AUI_HUD_Font", 120 * scalescreen + width, 20 * scalescreen, Color( 81, 117, 239 ), 0, 1 )

end

function HUDJobText()

	local PlayerJob = LocalPlayer().DarkRPVars.job
	local width, height = surface.GetTextSize( LocalPlayer():Name()..math.floor( LocalPlayer():Health() / MaxHealth * 100 ).."%"..math.floor( (LocalPlayer():Armor() / MaxArmor * 100) ).."%" )

	DrawTextRectangle( 140 * scalescreen + width, 10 * scalescreen, 20 * scalescreen, 20 * scalescreen, Color( 220, 220, 220 ), JobIcon )
	draw.SimpleText( PlayerJob, "AUI_HUD_Font", 165 * scalescreen + width, 20 * scalescreen, team.GetColor( LocalPlayer():Team() ), 0, 1 )

end

local function HUDWalletText()

	local PlayerWallet 	= LocalPlayer().DarkRPVars.money
	local width, height = surface.GetTextSize( LocalPlayer():Name()..math.floor( LocalPlayer():Health() / MaxHealth * 100 ).."%"..math.floor( (LocalPlayer():Armor() / MaxArmor * 100) ).."%"..LocalPlayer().DarkRPVars.job )

	DrawTextRectangle( width + 175 * scalescreen, 10 * scalescreen, 20 * scalescreen, 20 * scalescreen, Color( 220, 220, 220 ), WalletIcon )
	draw.SimpleText( string.Comma( PlayerWallet ), "AUI_HUD_Font", 195 * scalescreen + width, 20 * scalescreen, Color( 63, 219, 66 ), 0, 1 )

end

local function HUDSalaryText()

	local PlayerSalary = LocalPlayer().DarkRPVars.salary
	local width, height = surface.GetTextSize( LocalPlayer():Name()..math.floor( LocalPlayer():Health() / MaxHealth * 100 ).."%"..math.floor( (LocalPlayer():Armor() / MaxArmor * 100) ).."%"..LocalPlayer().DarkRPVars.job..string.Comma( LocalPlayer().DarkRPVars.money ) )

	DrawTextRectangle( width + 210 * scalescreen, 15 * scalescreen, 10 * scalescreen, 10 * scalescreen, Color( 220, 220, 220 ), HealthIcon )
	DrawTextRectangle( width + 215 * scalescreen, 10 * scalescreen, 20 * scalescreen, 20 * scalescreen, Color( 220, 220, 220 ), WalletIcon )
	draw.SimpleText( PlayerSalary.."/Hour", "AUI_HUD_Font", 235 * scalescreen + width, 20 * scalescreen, Color( 63, 219, 66 ), 0, 1 )

end

local function HUDLicenseText()

	local PlayerLicense = LocalPlayer().DarkRPVars.HasGunlicense
	local width, height = surface.GetTextSize( LocalPlayer():Name()..math.floor( LocalPlayer():Health() / MaxHealth * 100 ).."%"..math.floor( (LocalPlayer():Armor() / MaxArmor * 100) ).."%"..LocalPlayer().DarkRPVars.job..LocalPlayer().DarkRPVars.money..LocalPlayer().DarkRPVars.salary.."/Hour" )

	if PlayerLicense != true then

		LicenseText = "Not Licensed"

	else

		LicenseText = "Licensed"

	end

	DrawTextRectangle( width + 255 * scalescreen, 10 * scalescreen, 20 * scalescreen, 20 * scalescreen, Color( 220, 220, 220 ), LicenseIcon )
	draw.SimpleText( LicenseText, "AUI_HUD_Font", 280 * scalescreen + width, 20 * scalescreen, Color( 220, 220, 220 ), 0, 1 )

end

local function HUDNameText()

	local width, height = surface.GetTextSize( "Servers" )

	struc = {
		["pos"] = { ScrW() - 10 * scalescreen, 20 * scalescreen },
		["color"] = Color( 0, 0, 0, 240 ),
		["text"] = "ApexServers",
		["font"] = "AUI_HUD_Font",
		["xalign"] = 2,
		["yalign"] = 1,
	}

	draw.TextShadow( struc, 2, 200 )

	draw.SimpleText( "Apex" , "AUI_HUD_Font", ScrW() - 10 * scalescreen - width , 20 * scalescreen, amazinguitable.config.uicolor, 2, 1 )
	draw.SimpleText( "Servers" , "AUI_HUD_Font", ScrW() - 10 * scalescreen , 20 * scalescreen, Color( 220, 220, 220 ), 2, 1 )

end

local function HUDPlayTime()

	local width, height = surface.GetTextSize( LocalPlayer():Name()..math.floor( LocalPlayer():Health() / MaxHealth * 100 ).."%"..math.floor( (LocalPlayer():Armor() / MaxArmor * 100) ).."%"..LocalPlayer().DarkRPVars.job..LocalPlayer().DarkRPVars.money..LocalPlayer().DarkRPVars.salary.."/Hour"..LicenseText )

	DrawBlurRect( ScrW() - 198 * scalescreen, ( 70 + amazinguitable.config.bbarheight - 2 ) * scalescreen, 200 * scalescreen, 42 * scalescreen, 3, Color( 0, 0, 0, 200 ) )
	draw.RoundedBox( 0, ScrW() - 198 * scalescreen, ( 40 + amazinguitable.config.bbarheight - 1 ) * scalescreen, 200 * scalescreen, 30 * scalescreen, amazinguitable.config.uicolor )
	DrawTextRectangle( ScrW() - 193 * scalescreen, ( 45 + amazinguitable.config.bbarheight - 1 ) * scalescreen, 20 * scalescreen, 20 * scalescreen, Color( 220, 220, 220 ), PlayTimeIcon )
	draw.SimpleText( "Play Time" , "AUI_HUD_Font", ScrW() - 168 * scalescreen , ( 55 + amazinguitable.config.bbarheight - 1 ) * scalescreen, Color( 220, 220, 220 ), 0, 1 )
	draw.SimpleText( timeToStr( LocalPlayer():GetUTimeTotalTime(), "%02i:%02i:%02i" ) , "AUI_HUD_Font", ScrW() - 99 * scalescreen , ( 80 + amazinguitable.config.bbarheight - 1 ) * scalescreen, Color( 220, 220, 220 ), 1, 0 )
end

local function HUDLawsText()

	local LawsCount = table.Count( Laws )

	struc = {
		["pos"] = { 10 * scalescreen, ( 55 + amazinguitable.config.bbarheight - 1 ) * scalescreen },
		["color"] = Color( 0, 0, 0, 255 ),
		["text"] = "Press F1 to toggle laws",
		["font"] = "AUI_HUD_Font",
		["xalign"] = 0,
		["yalign"] = 1,
	}

	draw.TextShadow( struc, 2, 200 )

	draw.SimpleText( "Press F1 to toggle laws" , "AUI_HUD_Font", 10 * scalescreen , ( 55 + amazinguitable.config.bbarheight - 1 ) * scalescreen, Color( 220, 220, 220 ), 0, 1 )


	SmoothLaws = Lerp( 5 * FrameTime(), SmoothLaws, LawsPos )

	DrawBlurRect( SmoothLaws, ( 70 + amazinguitable.config.bbarheight - 2 ) * scalescreen, 500 * scalescreen, ( LawsCount * 18 + 9 ) * scalescreen, 3, Color( 0, 0, 0, 200 ) )
	draw.RoundedBox( 0, SmoothLaws, ( 40 + amazinguitable.config.bbarheight - 1 ) * scalescreen, 500 * scalescreen, 30 * scalescreen, amazinguitable.config.uicolor )
	DrawTextRectangle( SmoothLaws + 5 * scalescreen, ( 45 + amazinguitable.config.bbarheight - 1 ) * scalescreen, 20 * scalescreen, 20 * scalescreen, Color( 220, 220, 220 ), LawsIcon )
	draw.SimpleText( "Laws of the Land" , "AUI_HUD_Font", SmoothLaws + 30 * scalescreen , ( 55 + amazinguitable.config.bbarheight - 1 ) * scalescreen, Color( 220, 220, 220 ), 0, 1 )

	for k, v in pairs( Laws ) do

		draw.SimpleText( k..". "..v, "AUI_LAWS_Font", SmoothLaws + 5 * scalescreen , ( 72 + amazinguitable.config.bbarheight - 1 + ( k * 18 - 18 ) ) * scalescreen, Color( 220, 220, 220 ), 0, 0 )

	end

end

local function HUDPPCounterText()

	DrawBlurRect( 0, ScrH() - 72 * scalescreen, 300 * scalescreen, 74 * scalescreen, 3, Color( 0, 0, 0, 200 ) )
	DrawOutlinedRectangle( ( -amazinguitable.config.bbarheight - 3 ) * scalescreen, ScrH() - ( 72 + amazinguitable.config.bbarheight ) * scalescreen, ( 300 + amazinguitable.config.bbarheight * 2 ) * scalescreen, ( 74 + amazinguitable.config.bbarheight * 3 ) * scalescreen, amazinguitable.config.uicolor, amazinguitable.config.bbarheight  * scalescreen )

	draw.SimpleText( "Ping: "..LocalPlayer():Ping() , "AUI_BLC_Font", 20 * scalescreen, ScrH() - 21 * scalescreen, Color( 220, 220, 220 ), 0, 1 )
	draw.SimpleText( "Props: 0/"..amazinguitable.config.serverproplimit , "AUI_BLC_Font", 20 * scalescreen, ScrH() - 52 * scalescreen, Color( 220, 220, 220 ), 0, 1 )
end

local function HUDAmmoText()

	DrawBlurRect( ScrW() - 198 * scalescreen, ScrH() - 58 * scalescreen, 200 * scalescreen, 60 * scalescreen, 3, Color( 0, 0, 0, 200 ) )
	

end

local function HUDAssembler()

	HUDBackground()
	HUDIDText()
	HUDHealthText()
	HUDArmorText()
	HUDJobText()
	HUDWalletText()
	HUDSalaryText()
	HUDLicenseText()
	HUDNameText()
	HUDPlayTime()
	HUDLawsText()
	HUDPPCounterText()
	HUDAmmoText()

end

hook.Add( "HUDPaint", "AmazingUI", HUDAssembler)

local function AddLaw( um )

	table.insert( Laws, um:ReadString() )

end
usermessage.Hook("DRP_AddLaw", AddLaw )

local function RemoveLaw( um )

	table.remove( Laws, um:ReadChar() )
	
end
usermessage.Hook("DRP_RemoveLaw", RemoveLaw )

------

local function LawsMenu()

	if LawsHON then

		LawsHON = false
		LawsPos = 0

	else

		LawsHON = true
		LawsPos = -550 * scalescreen

	end

end

usermessage.Hook("LawsMenu", LawsMenu)