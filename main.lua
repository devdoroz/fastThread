local fastThreads = {}
local runService = game:GetService("RunService")

local loops = {runService.Stepped, runService.Heartbeat}
local loopIndex = 1

local value = Instance.new("IntValue")

if runService:IsClient() then
	loops = {runService.RenderStepped, runService.Stepped, runService.Heartbeat}
end

function fastThreads:Hook(func: () -> nil)
	return value.Changed:Connect(func)
end

task.spawn(function()
	
	while true do
		task.wait(0.1)
		loopIndex += 1
		value.Value += 1
		
		if loopIndex > #loops then
			loopIndex = 1
		end
	end
	
end)

return fastThreads
