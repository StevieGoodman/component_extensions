local Waiter = require(script.Parent.Parent.Waiter)

return function(otherComponent, getCandidatesFn: (Instance) -> {Instance})
	return {
        ShouldConstruct = function(component)
			local instances = Waiter.get(getCandidatesFn(component.Instance), Waiter.matchTag(otherComponent.Tag))
			component._components = component._instances or {}
            component._components[otherComponent.Tag] =  component._components[otherComponent.Tag] or {}
			for _, instance in instances do
                local success, result = otherComponent:WaitForInstance(instance):await()
                assert(success, `Failed to get {otherComponent.Tag} component from {instance:GetFullName()} ({component.Instance:GetFullName()}): {result}`)
                table.insert(component._components[otherComponent.Tag], result)
            end
			return true
        end,
    }
end