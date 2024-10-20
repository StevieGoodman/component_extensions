local Waiter = require(script.Parent.Parent.Waiter)

return function(name: string, getCandidatesFn: (Instance) -> {Instance}, predicate: (Instance) -> boolean)
	return {
        ShouldConstruct = function(component)
			local instance = Waiter.getFirst(getCandidatesFn(component.Instance), predicate)
			assert(instance ~= nil, `Failed to find required instance. ({component.Instance:GetFullName()})`)
			component._instances = component._instances or {}
			component._instances[name] = instance
			return true
        end,
    }
end