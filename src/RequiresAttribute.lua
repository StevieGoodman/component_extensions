return function(attributeName: string)
	return {
        ShouldConstruct = function(component)
			local attributeValue = component.Instance:GetAttribute(attributeName)
            assert(attributeValue ~= nil, `Failed to find required attribute {attributeName} for {component.Tag} component ({component.Instance:GetFullName()})`)
            if component._attributes == nil then
                component._attributes = {}
            end
            component._attributes[attributeName] = attributeValue
            return attributeValue ~= nil
        end,
    }
end