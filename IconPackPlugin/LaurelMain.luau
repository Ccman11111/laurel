local toolBarModule = require(script.Parent.ToolbarModule)
local widgetModule = require(script.Parent.WidgetModule)

local Selection = game:GetService("Selection")

local toolbar = plugin:CreateToolbar("Laurel Icon Pack")
local theme = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainBackground, Enum.StudioStyleGuideModifier.Disabled)
mainButton = toolbar:CreateButton("Open Icon Menu", "Opens the icon pack menu", toolBarModule.GetImagePerStudioTheme(theme))
mainButton.ClickableWhenViewportHidden = true
local mainWidget
local searchBarActive = false
local barInstance
local selText
local function onOpenUIButtonClicked()
	if mainWidget then  mainWidget:Destroy() searchBarActive = false end --Closes widget if already open
	local widgetInfo1 = widgetModule.GetWidgetInfo()
	mainWidget = plugin:CreateDockWidgetPluginGui(math.random(0, 999), widgetInfo1)
	mainWidget.Title = "Module is to be called"
	widgetModule.AddAssetsToMainWidget(mainWidget)
	searchBarActive = true
	barInstance = mainWidget.Frame:WaitForChild("TextBox")
	selText = mainWidget.Frame:WaitForChild("Sel")
	
	barInstance.Changed:Connect(function() local searchText = barInstance.Text widgetModule.FilterIconsFromSearch(searchText, mainWidget, searchBarActive) end) --Changes colors for buttons
	mainWidget.Frame.InstanceConfig.Grid.DecalIns.MouseButton1Click:Connect(function() 
		mainWidget.Frame.InstanceConfig.Grid.DecalIns.BackgroundColor3 = Color3.new(0.545098, 1, 0.611765) 
		mainWidget.Frame.InstanceConfig.Grid.ImgButton.BackgroundColor3 = Color3.new(1, 0.207843, 0.207843) 
		mainWidget.Frame.InstanceConfig.Grid.ImgLabel.BackgroundColor3 = Color3.new(1, 0.207843, 0.207843) 
	end)
	mainWidget.Frame.InstanceConfig.Grid.ImgButton.MouseButton1Click:Connect(function() 
		mainWidget.Frame.InstanceConfig.Grid.DecalIns.BackgroundColor3 = Color3.new(1, 0.207843, 0.207843) 
		mainWidget.Frame.InstanceConfig.Grid.ImgButton.BackgroundColor3 = Color3.new(0.545098, 1, 0.611765) 
		mainWidget.Frame.InstanceConfig.Grid.ImgLabel.BackgroundColor3 = Color3.new(1, 0.207843, 0.207843) 
	end)
	mainWidget.Frame.InstanceConfig.Grid.ImgLabel.MouseButton1Click:Connect(function() 
		mainWidget.Frame.InstanceConfig.Grid.DecalIns.BackgroundColor3 = Color3.new(1, 0.207843, 0.207843) 
		mainWidget.Frame.InstanceConfig.Grid.ImgButton.BackgroundColor3 = Color3.new(1, 0.207843, 0.207843) 
		mainWidget.Frame.InstanceConfig.Grid.ImgLabel.BackgroundColor3 = Color3.new(0.545098, 1, 0.611765) 
	end)	
end

mainButton.Click:Connect(onOpenUIButtonClicked)
