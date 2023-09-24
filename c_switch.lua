addEvent("onClientAcceptNativeSwitch", true)
addEvent("onClientChangeNativeSwitch", true)

function addNativeSwitch(menuElement, text, color, values)
    assert(isElement(menuElement), "Bad argument @ addNativeSwitch [expected native-menu at argument 1,  got "..type(menuElement).." '"..tostring(menuElement).."'']")
    assert(getElementType(menuElement) == "native-menu", "Bad argument @ addNativeSwitch [expected native-menu at argument 1,  got "..type(menuElement).." '"..tostring(menuElement).."'']")
    assert(type(values) == "table", "Bad argument @ addNativeSwitch [expected table at argument 2,  got "..type(menuElement).." '"..tostring(menuElement).."'']")
   
    local text = text or "" -- Spacer
    local color = color or tocolor(255, 255, 255)

    local switch = createElement("native-switch")
    
    menus[menuElement].items[#menus[menuElement].items+1] = {
        element = switch,
        type = "switch",
        text = text,
        color = color,
        values = values,
        currentPosition = 1
    }
    return switch
end


function getSwitchText(menuElement, switchElement)
    assert(isElement(menuElement), "Bad argument @ getSwitchText [expected native-menu at argument 1,  got "..type(menuElement).." '"..tostring(menuElement).."'']")
    assert(getElementType(menuElement) == "native-menu", "Bad argument @ getSwitchText [expected native-menu at argument 1,  got "..type(menuElement).." '"..tostring(menuElement).."'']")    

    assert(isElement(switchElement), "Bad argument @ getSwitchText [expected native-switch at argument 2,  got "..type(switchElement).." '"..tostring(switchElement).."'']")
    assert(getElementType(switchElement) == "native-switch", "Bad argument @ getSwitchText [expected native-switch at argument 2,  got "..type(switchElement).." '"..tostring(switchElement).."'']")

    for i,v in pairs(menus[menuElement].items) do
        if v.element == switchElement then
            actualSwitchIndex = v.currentPosition
            actualSwitchValue = v.values[tonumber(actualSwitchIndex)]  
            return actualSwitchValue
        end
    end
    return false
end

function setNativeSwitchSelection(menuElement, switchElement, newPosition)
    assert(isElement(menuElement), "Bad argument @ setNativeSwitchSelection [expected native-menu at argument 1,  got "..type(menuElement).." '"..tostring(menuElement).."'']")
    assert(getElementType(menuElement) == "native-menu", "Bad argument @ setNativeSwitchSelection [expected native-menu at argument 1,  got "..type(menuElement).." '"..tostring(menuElement).."'']")    

    assert(isElement(switchElement), "Bad argument @ setNativeSwitchSelection [expected native-switch at argument 2,  got "..type(switchElement).." '"..tostring(switchElement).."'']")
    assert(getElementType(switchElement) == "native-switch", "Bad argument @ setNativeSwitchSelection [expected native-switch at argument 2,  got "..type(switchElement).." '"..tostring(switchElement).."'']")
    
    assert(newPosition, "Bad argument @ setNativeSwitchSelection [expected number/string at argument 3,  got "..type(newPosition).." '"..tostring(newPosition).."'']")
    

    for i,v in pairs(menus[menuElement].items) do
        if v.element == switchElement then
            if type(newPosition) == "number" then
                assert(newPosition <= #v.values, "New switch selection out of range")
                v.currentPosition = newPosition
                return true
            else
                for k,value in pairs(v.values) do
                    if value == newPosition then
                        v.currentPosition = k
                        return true
                    end
                end
            end
        end
    end
    return false
end