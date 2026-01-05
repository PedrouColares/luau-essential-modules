--!strict
local module = {}

local FIELD_OF_VIEW = 30
local CAMERA_DIRECTION = Vector3.new(0, 0.1, -1).Unit
local MARGIN = 1.1

function module.setup(viewportFrame: ViewportFrame, model: Model)
	viewportFrame:ClearAllChildren()
	viewportFrame.Ambient = Color3.new(1, 1, 1) 
	viewportFrame.LightColor = Color3.new(1, 1, 1)
	viewportFrame.LightDirection = -CAMERA_DIRECTION 
	viewportFrame.BackgroundTransparency = 1 

	local worldModel = Instance.new("WorldModel")
	worldModel.Parent = viewportFrame
	model.Parent = worldModel

	local camera = Instance.new("Camera")
	camera.FieldOfView = FIELD_OF_VIEW
	camera.Parent = viewportFrame
	viewportFrame.CurrentCamera = camera

	model:PivotTo(CFrame.new(Vector3.zero))

	local _, newSize = model:GetBoundingBox()
	local radius = newSize.Magnitude / 2
	local halfFovRad = math.rad(FIELD_OF_VIEW / 2)
	local requiredDistance = radius / math.sin(halfFovRad)
	requiredDistance = requiredDistance * MARGIN

	local cameraPos = CAMERA_DIRECTION * requiredDistance
	camera.CFrame = CFrame.new(cameraPos, Vector3.zero)

	local light = Instance.new("PointLight")
	light.Brightness = 1
	light.Range = requiredDistance * 3
	light.Parent = worldModel
end

return module
