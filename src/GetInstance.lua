local Waiter = require(script.Parent.Parent.Waiter)

return function(name: string, getCandidatesFn: (Instance) -> {Instance}, predicate: (Instance) -> boolean)
	return {
        ShouldConstruct = function(component)
			local instances = Waiter.get(getCandidatesFn(component.Instance), predicate)
			component._instances = component._instances or {}
			component._instances[name] = instances
			return true
        end,
    }
end