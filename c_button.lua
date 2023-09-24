addEvent("onClientAcceptButton", true)
function addNativeButton(menuElement, text, color, icon)
    assert(isElement(menuElement), "Bad argument @ addNativeButton [expected native-menu at argument 1,  got "..type(menuElement).." '"..tostring(menuElement).."'']")
    assert(getElementType(menuElement) == "native-menu", "Bad argument @ addNativeButton [expected native-menu at argument 1,  got "..type(menuElement).." '"..tostring(menuElement).."'']")
    if icon then
        assert(icon ~= "box","Invalid icon type @ addNativeButton [got"..type(icon).." '"..tostring(icon).."'']")
        assert(fileExists("assets/icons/"..icon.."1.png"),"Could not find icon texture @ addNativeButton [got "..type(icon).." '"..tostring(icon).."'']")
    end
    local text = text or "" -- Spacer
    local color = color or tocolor(255, 255, 255)

    local button = createElement("native-button")
    
    menus[menuElement].items[#menus[menuElement].items+1] = {
        element = button,
        type = "button",
        text = text,
        icon = icon or false,
        color = color,
    }
    return button
end

function setNativeButtonIcon(menuElement, buttonElement, icon)
    assert(isElement(menuElement), "Bad argument @ removeNativeButton [expected native-menu at argument 1,  got "..type(menuElement).." '"..tostring(menuElement).."'']")
    assert(getElementType(menuElement) == "native-menu", "Bad argument @ removeNativeButton [expected native-menu at argument 1,  got "..type(menuElement).." '"..tostring(menuElement).."'']")    

    assert(isElement(buttonElement), "Bad argument @ removeNativeButton [expected native-menu at argument 2,  got "..type(buttonElement).." '"..tostring(buttonElement).."'']")
    assert(getElementType(buttonElement) == "native-button", "Bad argument @ removeNativeButton [expected native-menu at argument 2,  got "..type(buttonElement).." '"..tostring(buttonElement).."'']")
    assert(icon ~= "box","Invalid icon type @ addNativeButton [got"..type(icon).." '"..tostring(icon).."'']")
    assert(fileExists("assets/icons/"..icon.."1.png"),"Could not find icon texture @ addNativeButton [got "..type(icon).." '"..tostring(icon).."'']")

    for i,v in pairs(menus[menuElement].items) do
        if v.element == buttonElement then
            v.icon = icon
            break
        end
    end
end


function removeNativeButton(menuElement, buttonElement)
    assert(isElement(menuElement), "Bad argument @ removeNativeButton [expected native-menu at argument 1,  got "..type(menuElement).." '"..tostring(menuElement).."'']")
    assert(getElementType(menuElement) == "native-menu", "Bad argument @ removeNativeButton [expected native-menu at argument 1,  got "..type(menuElement).." '"..tostring(menuElement).."'']")    

    assert(isElement(buttonElement), "Bad argument @ removeNativeButton [expected native-menu at argument 2,  got "..type(buttonElement).." '"..tostring(buttonElement).."'']")
    assert(getElementType(buttonElement) == "native-button", "Bad argument @ removeNativeButton [expected native-menu at argument 2,  got "..type(buttonElement).." '"..tostring(buttonElement).."'']")

    for i,v in pairs(menus[menuElement].items) do
        if v.element == buttonElement then
            table.remove(menus[menuElement].items, i)
            break
        end
    end
    return true
end