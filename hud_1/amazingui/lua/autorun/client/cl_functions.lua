/*
Coded by Jewson
Copyright Jewson© 2016-2019
Free for commercial/private use.
*/
local blur = Material("pp/blurscreen")

function DrawBlurRect(x, y, w, h, hardness, c)
	local X, Y = 0,0

	surface.SetDrawColor( 255, 255, 255 )
	surface.SetMaterial( blur )

	for i = 1, 5 do
		blur:SetFloat("$blur", (i / 3) * (hardness))
		blur:Recompute()

		render.UpdateScreenEffectTexture()

		render.SetScissorRect(x, y, x+w, y+h, true)
			surface.DrawTexturedRect(X * -1, Y * -1, ScrW(), ScrH())
		render.SetScissorRect(0, 0, 0, 0, false)
	end
   
   draw.RoundedBox( 0, x, y, w, h, c )
   surface.SetDrawColor( 0, 0, 0 )
   
end

function DrawTextRectangle( x, y, w, h, c, m )

	surface.SetDrawColor( c )
	surface.SetMaterial( m )
	surface.DrawTexturedRect( x, y, w, h )

end

function timeToStr( time )
	local tmp = time
	local s = tmp % 60
	tmp = math.floor( tmp / 60 )
	local m = tmp % 60
	tmp = math.floor( tmp / 60 )
	local h = tmp % 24
	tmp = math.floor( tmp / 24 )
	local d = tmp % 7
	local w = math.floor( tmp / 7 )

	return string.format( "%02iw %id %02ih %02im %02is", w, d, h, m, s )
end

function DrawOutlinedRectangle( x, y, w, h, c, t )

	surface.SetDrawColor( c )

	for I = 0, t - 1 do

		surface.DrawOutlinedRect( x + I, y + I, w - I * 2, h - I * 2 / 2 )

	end

end