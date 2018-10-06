-- Enable virtual mouse scroll wheel with trackball while pressing small mouse button
local oldmousepos = {}
-- positive multiplier = natural scrolling, negative makes mouse work like traditional scroll wheel
local scrollmult = -4 

-- There were all events logged, when using `{"all"}`
mousetap = hs.eventtap.new({0,3,5,14,25,26,27}, function(e)
	oldmousepos = hs.mouse.getAbsolutePosition()
	local mods = hs.eventtap.checkKeyboardModifiers()
	local pressedMouseButton = e:getProperty(hs.eventtap.event.properties['mouseEventButtonNumber'])

	-- If small mouse button is pressed, allow scrolling with trackball
	-- 3 = left small button, 4 = right small button
	local shouldScroll = 3 == pressedMouseButton
	if shouldScroll then
		local dx = e:getProperty(hs.eventtap.event.properties['mouseEventDeltaX'])
		local dy = e:getProperty(hs.eventtap.event.properties['mouseEventDeltaY'])
		local scroll = hs.eventtap.event.newScrollEvent({dx * scrollmult, dy * scrollmult},{},'pixel')
		scroll:post()
	
		-- put the mouse back
		hs.mouse.setAbsolutePosition(oldmousepos)
	
		return true, {scroll}
	else
		return false, {}
	end
end)
mousetap:start()
