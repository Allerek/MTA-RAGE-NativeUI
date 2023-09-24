addEvent("onClientNativeCheckBoxChange", true)

function addNativeCheckbox(menuElement, text, color, selected)
    assert(isElement(menuElement), "Bad argument @ addNativeButton [expected native-menu at argument 1,  got "..type(menuElement).." '"..tostring(menuElement).."'']")
    assert(getElementType(menuElement) == "native-menu", "Bad argument @ addNativeButton [expected native-menu at argument 1,  got "..type(menuElement).." '"..tostring(menuElement).."'']")
    local text = text or "" -- Spacer
    local color = color or tocolor(255, 255, 255)

    local checkbox = createElement("native-checkbox")
    
    menus[menuElement].items[#menus[menuElement].items+1] = {
        element = checkbox,
        type = "checkbox",
        text = text,
        selected = selected or false,
        color = color,
    }
    return checkbox
end

function setNativeCheckboxSelection(menuElement, checkboxElement, newState)
    assert(isElement(menuElement), "Bad argument @ setNativeCheckboxSelection [expected native-menu at argument 1,  got "..type(menuElement).." '"..tostring(menuElement).."'']")
    assert(getElementType(menuElement) == "native-menu", "Bad argument @ setNativeCheckboxSelection [expected native-menu at argument 1,  got "..type(menuElement).." '"..tostring(menuElement).."'']")    

    assert(isElement(checkboxElement), "Bad argument @ setNativeCheckboxSelection [expected native-checkbox at argument 2,  got "..type(checkboxElement).." '"..tostring(checkboxElement).."'']")
    assert(getElementType(checkboxElement) == "native-checkbox", "Bad argument @ setNativeCheckboxSelection [expected native-checkbox at argument 2,  got "..type(checkboxElement).." '"..tostring(checkboxElement).."'']")
    
    for i,v in pairs(menus[menuElement].items) do
        if v.element == checkboxElement then
            v.selected = newState
            return true
        end
    end
    return false
end

function getNativeCheckboxSelection(menuElement, checkboxElement)
    assert(isElement(menuElement), "Bad argument @ getNativeCheckboxSelection [expected native-menu at argument 1,  got "..type(menuElement).." '"..tostring(menuElement).."'']")
    assert(getElementType(menuElement) == "native-menu", "Bad argument @ nativeGetCheckBoxSelection [expected native-menu at argument 1,  got "..type(menuElement).." '"..tostring(menuElement).."'']")    

    assert(isElement(checkboxElement), "Bad argument @ getNativeCheckboxSelection [expected native-checkbox at argument 2,  got "..type(checkboxElement).." '"..tostring(checkboxElement).."'']")
    assert(getElementType(checkboxElement) == "native-checkbox", "Bad argument @ getNativeCheckboxSelection [expected native-checkbox at argument 2,  got "..type(checkboxElement).." '"..tostring(checkboxElement).."'']")
    
    for i,v in pairs(menus[menuElement].items) do
        if v.element == checkboxElement then
            return v.selected
        end
    end
    return false
end

