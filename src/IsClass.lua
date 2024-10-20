return function(className)
    return {
        ShouldConstruct = function(component)
            local isValidType = component.Instance:IsA(className)
            assert(isValidType, `{component.Instance:GetFullName()} ({component.Instance.ClassName}) must be a {className}`)
            return isValidType
        end,
    }
end