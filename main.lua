local fastThreads = {}
local runService = game:GetService("RunService")

local loops = {runService.Stepped, runService.Heartbeat}
local loopIndex = 1

local value = Instance.new("IntValue")

if runService:IsClient() then
	loops = {runService.RenderStepped, runService.Stepped, runService.Heartbeat}
end

function fastThreads:Hook(func: () -> nil)
	value.Changed:Connect(func)
end

task.spawn(function()
	
	while true do
		loops[loopIndex]:Wait()
		loopIndex += 1
		value.Value += 1
		
		if loopIndex > #loops then
			loopIndex = 1
		end
	end
	
end)

return fastThreads
