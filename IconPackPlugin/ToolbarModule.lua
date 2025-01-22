local module = {}

	function module.GetImagePerStudioTheme(theme)
		local whiteImageAsset = "rbxassetid://121939422514709"
		local blackImageAsset = "rbxassetid://98597928179133" 
		local imageAsset
		local splitValues = tostring(theme):split(", ") 
		for i, value in ipairs(splitValues) do
			if i == 3 and math.round(value) == 0 then
				imageAsset = whiteImageAsset
			elseif i == 3 and math.round(value) == 1 then
				imageAsset = blackImageAsset
			end
		end
	return imageAsset
	end


return module
