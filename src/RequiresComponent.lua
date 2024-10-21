local Waiter = require(script.Parent.Parent.Waiter)

return function(requiredComponent, getCandidatesFn: ((Instance) -> {Instance})?)
    return {
        ShouldConstruct = function(component)
            local instance =
                if getCandidatesFn ~= nil
                then Waiter.getFirst(getCandidatesFn(component.Instance), Waiter.matchTag(requiredComponent.Tag))
                else component.Instance
            assert(instance ~= nil, `Failed to find required instance with tag "{requiredComponent.Tag}". ({component.Instance:GetFullName()})`)
            instance:AddTag(requiredComponent.Tag)
            local success, _ = requiredComponent:WaitForInstance(instance)
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