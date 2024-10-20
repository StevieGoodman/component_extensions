local Waiter = require(script.Parent.Parent.Waiter)

return function(requiredComponent)
    return {
        ShouldConstruct = function(component, candidates: {Instance}?, predicate: ((Instance) -> boolean)?)
            local instance =
                if candidates ~= nil and predicate ~= nil
                then Waiter.getFirst(candidates, predicate)
                else component.Instance
            instance:AddTag(requiredComponent.Tag)
            local success, _ = requiredComponent:WaitForInstance(requiredComponent, instance)
                :andThen(function(requiredComponentInstance)
                    component._components = component._components or {}
                    component._components[requiredComponent.Tag] = requiredComponentInstance
                end)
                :catch(function(err)
                    error(`Failed to give component {component.Tag} the required component {requiredComponent.Tag} ({component.Instance:GetFullName()}): {err}`)
                end)
            :await()
            return success
        end,
    }
end