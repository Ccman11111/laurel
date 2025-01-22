local module = {}
	
	function module.GetWidgetInfo() --Set the widget info
	local widgetInfo = DockWidgetPluginGuiInfo.new(
		Enum.InitialDockState.Float, -- Widget will be initialized in floating panel
		true,   -- Widget will be initially enabled
		false,  -- Don't override the previous enabled state
		500,    -- Default width of the floating window
		500,    -- Default height of the floating window
		500,    -- Minimum width of the floating window
		300 -- Minimum height of the floating window
	)
	return widgetInfo
	end
	
	
	
	
	function module.AddAssetsToMainWidget(widget) --Adds the assests to the UI when opened
		widget.Title = "Laurel Icon Pack"
		local frame = script.Parent.Assets.Frame:Clone()
		frame.Parent = widget
		local Sframe = frame.ScrollingFrame
		Sframe.BackgroundTransparency = 1
		frame.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainBackground, Enum.StudioStyleGuideModifier.Disabled)
		frame.InstanceConfig.Grid.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainBackground, Enum.StudioStyleGuideModifier.Disabled)
		frame.InstanceConfig.Grid.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Disabled)
		local count = 0
		local folder = script.Parent.Assets.fullIconLib.outline
			for _, child in pairs(folder:GetDescendants()) do
				if child:IsA("Decal") then
					local iconButton = script.Parent.Assets.ImageIcon:Clone()
					iconButton.Parent = Sframe
					iconButton.Image = child.Texture
					count = count + 1
				end
			end
			--print(count) Used to print number of icons
	end
	
		function module.FilterIconsFromSearch(text, mainWid, run) --Filters icons from search term when called, also contains button handlers & adding
			if run == true and mainWid:GetChildren()[1] then
				for _, child in pairs(mainWid.Frame.ScrollingFrame:GetDescendants()) do
					if child:IsA("ImageButton") then
						child:Destroy()
					end
				end
		
				local folder = script.Parent.Assets.fullIconLib.outline
				for _, child in pairs(folder:GetDescendants()) do
					if child:IsA("Decal") and child.Name:lower():find(text) then
					local iconButton = script.Parent.Assets.ImageIcon:Clone()
					iconButton.Parent = mainWid.Frame.ScrollingFrame
					iconButton.Image = child.Texture
					iconButton.Name = string.sub(tostring(child.Name), 8)
				iconButton.MouseEnter:Connect(function() iconButton.Parent.Parent.Sel.Text = "Selection: ".. iconButton.Name end)
				iconButton.MouseLeave:Connect(function() iconButton.Parent.Parent.Sel.Text = "Selection: None" end)
				iconButton.MouseButton1Click:Connect(function()
					local SelService = game:GetService("Selection")
					local ChangeHistoryService = game:GetService("ChangeHistoryService")
					local selectedObjects = SelService:Get()
					local parent = game:GetService("ServerScriptService")
					if #selectedObjects > 0 then
						parent = selectedObjects[1]
					end
					
					local insToAdd
					if mainWid.Frame.InstanceConfig.Grid.DecalIns.BackgroundColor3 == Color3.new(0.545098, 1, 0.611765) then
						insToAdd = "Decal"
					elseif mainWid.Frame.InstanceConfig.Grid.ImgButton.BackgroundColor3 == Color3.new(0.545098, 1, 0.611765) then
						insToAdd = "ImageButton"
					elseif 	mainWid.Frame.InstanceConfig.Grid.ImgLabel.BackgroundColor3 == Color3.new(0.545098, 1, 0.611765) then
						insToAdd = "ImageLabel"
					end
					
					if insToAdd == nil then warn("Please select an instance type using the buttons.") warn("-Laurel Icon Pack")
					else	
					local newIcon = Instance.new(insToAdd)
					newIcon.Parent = parent
					newIcon.Name = iconButton.Name
					if newIcon:IsA("Decal") then
						newIcon.Texture = iconButton.Image
					else
						newIcon.Image = iconButton.Image
					end
					iconButton.Parent.Parent.Sel.Text = "Added icon '" .. newIcon.Name.. "' to selection"
					ChangeHistoryService:SetWaypoint("Added new icon")
					end
				end)
					end
				end
			end		
	end
	
return module
