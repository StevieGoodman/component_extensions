local Waiter = require(script.Parent.Parent.Waiter)

return function(name: string, candidates: {Instance}, predicate: (Instance) -> boolean)
	return {
        ShouldConstruct = function(component)
			local instances = Waiter.get(candidates, predicate)
			component._instances = component._instances or {}
			component._instances[name] = instances
			return true
        end,
    }
end