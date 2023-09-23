--
-- ----------------------------------------------------------------------------
-- "THE BEER-WARE LICENSE" (Revision 42):
-- <allerek22@icloud.com> wrote this file.  As long as you retain this notice you
-- can do whatever you want with this stuff. If we meet some day, and you think
-- this stuff is worth it, you can buy me a beer in return.  Mateusz Bartłomiej Domińczak
-- ----------------------------------------------------------------------------
--

menus = {}

local isNativeShown = false
activeMenu = false
local activeItem =  1

local sW,sH = guiGetScreenSize()
local scale = 1920/sW
local testTXT = dxCreateTexture("assets/defaultbg.png")

local GUI = {}
GUI.scale = {
    ["bgImageScale"] = Vector2(431*scale, 107*scale),
    ["itemScale"] = Vector2(431*scale, 37*scale),
    ["iconScale"] = Vector2(48*scale, 48*scale),
}

function createNativeUI(name, title, image, color, nameColor, titleColor, align, counter, scroll_Items, nameAlign)
    if name == "" then
        assert(type(name) == string, "Bad argument @ createNativeUI [expected string at argument 1,  got "..type(name).." '"..name.."'']")
    end
    if title then
        assert(title and tostring(title), "Bad argument @ createNativeUI [expected string at argument 2,  got "..type(title).." '"..title.."'']")
    end
    if not image then
        assert(color, "[Native UI]No specified image and not specified color")
    end
    if image then
        assert(fileExists(image) or getElementType(image) == "texture", "Bad argument @ createNativeUI [expected file/texture at argument 3,  got "..type(color).." '"..tostring(color).."'']")
    end
    if color then
        assert(tonumber(color), "Bad argument @ createNativeUI [expected color at argument 4,  got "..type(color).." '"..color.."'']")
    end
    if align then
        assert(align == "left" or align == "right" or align == "center", "Invalid align type @ createNativeUI [expected 'left'/'right' at argument 7,  got"..type(align).." '"..tostring(align).."'']")
    end
    if nameAlign then
        assert(nameAlign == "left" or nameAlign == "center" or nameAlign == "right","Invalid menu-align type @ createNativeUI [expected 'left'/'center'/'right' at argument 10,  got"..type(align).." '"..align.."'']")
    end
    if not nameAlign then
        nameAlign = "center"
    end

    local menuElement = createElement("native-menu")

    menus[menuElement] = {}
    menus[menuElement].items = {}

    local items = menus[menuElement].items
    local menu = menus[menuElement]
    if align == "left" then
        windowPosition = Vector2(10*scale, 10*scale)
    elseif align == "center" then
        windowPosition = Vector2(sW/2-GUI.scale.bgImageScale.x/2, 10*scale)
    elseif align == "right" then
        windowPosition = Vector2(sW-GUI.scale.bgImageScale.x-10*scale, 10*scale)
    end


    menu.name = name
    menu.title = title
    menu.bgImagePos = windowPosition
    menu.color = color or false
    menu.image = image or false

    menu.nameFont = dxCreateFont("assets/fonts/SingPainter.ttf", 55*scale)
    menu.titleFont = dxCreateFont("assets/fonts/ChaletLondon.ttf", 18*scale, false)

    menu.nameColor = nameColor or tocolor(255, 255, 255)
    menu.titleColor = titleColor or tocolor(255, 255, 255)

    menu.titlePosition = Vector2(menu.bgImagePos.x, menu.bgImagePos.y+GUI.scale.bgImageScale.y)
    menu.titleTextPosition = Vector2(menu.titlePosition.x+15*scale, menu.titlePosition.y+GUI.scale.itemScale.y/2)
    menu.counterTextPosition = Vector2(menu.titlePosition.x+GUI.scale.itemScale.x-15*scale, menu.titlePosition.y+GUI.scale.itemScale.y/2)

    if nameAlign == "left" then
        windowNamePosition = menu.bgImagePos.x+(15*scale)
    elseif nameAlign == "center" then
        windowNamePosition = menu.bgImagePos.x+(GUI.scale.bgImageScale.x/2)
    elseif nameAlign == "right" then
        windowNamePosition = menu.bgImagePos.x+(GUI.scale.bgImageScale.x-(15*scale))
    end
    menu.nameAlign = nameAlign
    menu.nameTextPosition = Vector2(windowNamePosition, menu.bgImagePos.y+GUI.scale.bgImageScale.y/2)

    menu.actual = 0
    menu.itemCount = 0
    menu.counter = counter or false
    if not scroll_Items or scroll_Items > 10 or scroll_Items <= 1 then
        scroll_Items = 10
    end
    menu.scroll_Items = scroll_Items

    menu.visible = true
    menu.activeItem = 1

    menus[menuElement] = menu
    menus[menuElement].items = items

    isNativeShown = true

    activeMenu = menuElement
    
    bindKeys()
    return menuElement
end

function setNativeMenuVisible(menuElement, visible)
    assert(isElement(menuElement), "Bad argument @ removeNativeButton [expected native-menu at argument 1,  got "..type(menuElement).." '"..tostring(menuElement).."'']")
    assert(getElementType(menuElement) == "native-menu", "Bad argument @ removeNativeButton [expected native-menu at argument 1,  got "..type(menuElement).." '"..tostring(menuElement).."'']")    
    for i,v in pairs(menus) do
        if i == menuElement then
            v.visible = visible
        end
    end
end

function getNativeMenuVisible(menuElement)
   assert(isElement(menuElement), "Bad argument @ getNativeMenuVisible [expected native-menu at argument 1, got "..type(menuElement).." '"..tostring(menuElement).."'']")
   assert(getElementType(menuElement) == "native-menu", "Bad argument @ removeNativeButton [expected native-menu at argument 1, got "..type(menuElement).." '"..tostring(menuElement).."'']")
   for i, v in pairs(menus) do
       if i == menuElement then
	      return v.visible
	   end
   end
end

function setNativeMenuActive(menuElement)
    assert(isElement(menuElement), "Bad argument @ removeNativeButton [expected native-menu at argument 1,  got "..type(menuElement).." '"..tostring(menuElement).."'']")
    assert(getElementType(menuElement) == "native-menu", "Bad argument @ removeNativeButton [expected native-menu at argument 1,  got "..type(menuElement).." '"..tostring(menuElement).."'']")    
    for i,v in pairs(menus) do
        if i == menuElement then
            activeMenu = i
            bindKeys()
        end
    end
end

function destroyNativeMenu(menuElement)
    assert(isElement(menuElement), "Bad argument @ removeNativeButton [expected native-menu at argument 1,  got "..type(menuElement).." '"..tostring(menuElement).."'']")
    assert(getElementType(menuElement) == "native-menu", "Bad argument @ removeNativeButton [expected native-menu at argument 1,  got "..type(menuElement).." '"..tostring(menuElement).."'']")    
    for i,v in pairs(menus) do
        if i == menuElement then
            menus[i] = nil
            destroyElement(i)
            unbindKeys()
            return true
        end
    end
    return false
end

addEventHandler("onClientRender", getRootElement(), function()
    for k,window in pairs(menus) do
        if not window.visible then break end
        if not window.image then
            dxDrawRectangle(window.bgImagePos, GUI.scale.bgImageScale, window.color)
        else
            dxDrawImage(window.bgImagePos, GUI.scale.bgImageScale, window.image)
        end

        if window.name then
            dxDrawText(window.name, window.nameTextPosition, nil, nil, window.nameColor, 1, window.nameFont, window.nameAlign, "center")
        end

        dxDrawRectangle(window.titlePosition, GUI.scale.itemScale, tocolor(0, 0, 0))
        dxDrawText(window.title, window.titleTextPosition, nil, nil, window.titleColor, 1, window.titleFont, "left", "center")
        if window.counter then
            dxDrawText(window.activeItem.."/"..#window.items, window.counterTextPosition, nil, nil, window.titleColor, 1, window.titleFont, "right", "center")
        end

        for i,v in ipairs(window.items) do

            itemsPage = math.ceil(i/window.scroll_Items)
            dxDrawText(getCurrentNativePage(), 0, 0, 0, 0)

            if i > window.scroll_Items*(getCurrentNativePage()-1) and i <= window.scroll_Items*getCurrentNativePage() then   

                i=i-window.scroll_Items*(getCurrentNativePage()-1)
                if window.activeItem-window.scroll_Items*(getCurrentNativePage()-1) == i then
                    color = tocolor(255, 255, 255, 255*0.6)
                    textcolor = tocolor(0, 0, 0, 255)
                else
                    color = tocolor(0, 0, 0, 255-((2*i)*255/100))
                    textcolor = v.color
                end
                local itemPosition = Vector2(window.bgImagePos.x, window.titlePosition.y+GUI.scale.itemScale.y*i)
                dxDrawRectangle(itemPosition, GUI.scale.itemScale, color)

                local itemTextPosition = Vector2(window.titlePosition.x+15*scale, itemPosition.y+GUI.scale.itemScale.y/2)
                dxDrawText(v.text, itemTextPosition, nil, nil, textcolor, 1, window.titleFont, "left", "center")

                if v.type == "button" and v.icon then
                    if i == window.activeItem then
                        imgType = 2
                    else
                        imgType = 1
                    end
                    local itemIconPosition = Vector2(window.titlePosition.x+GUI.scale.itemScale.x-15*scale-GUI.scale.iconScale.x, itemPosition.y+GUI.scale.itemScale.y/2-GUI.scale.iconScale.y/2)
                    dxDrawImage(itemIconPosition, GUI.scale.iconScale, "assets/icons/"..v.icon..""..imgType..".png")
                elseif v.type == "switch" then
                    local itemSwitchTextPosition = Vector2(window.titlePosition.x+GUI.scale.itemScale.x-15, itemPosition.y+GUI.scale.itemScale.y/2)
                    dxDrawText("⮜ "..v.values[tonumber(v.currentPosition)].." ⮞", itemSwitchTextPosition, nil, nil, textColor, 1, window.titleFont, "right", "center")
                elseif v.type == "checkbox" then
                    if i == window.activeItem then
                        imgType = 2
                    else
                        imgType = 1
                    end
                    local itemIconPosition = Vector2(window.titlePosition.x+GUI.scale.itemScale.x-15*scale-GUI.scale.iconScale.x, itemPosition.y+GUI.scale.itemScale.y/2-GUI.scale.iconScale.y/2)
                    dxDrawImage(itemIconPosition, GUI.scale.iconScale, "assets/icons/box"..imgType..".png")
                    if v.selected then
                        dxDrawImage(itemIconPosition, GUI.scale.iconScale, "assets/icons/accept"..imgType..".png")
                    end
                end
                
                if #menus[activeMenu].items+1 > window.scroll_Items  then
                    
                    if getCurrentNativePage() == math.ceil(#window.items/window.scroll_Items) then
                        itemsOnPage = #menus[activeMenu].items-window.scroll_Items*(getCurrentNativePage()-1)
                    else
                        itemsOnPage = window.scroll_Items
                    end
                    local arrowsBgPosition = Vector2(window.bgImagePos.x, window.titlePosition.y+GUI.scale.itemScale.y*(itemsOnPage+1))
                    dxDrawRectangle(arrowsBgPosition, GUI.scale.itemScale, tocolor(0, 0, 0, 255*0.4))
                    local arrowsPosition = Vector2(window.bgImagePos.x+GUI.scale.itemScale.x/2, arrowsBgPosition.y+GUI.scale.itemScale.y/2)
                    if window.activeItem == 1 then
                        text = "⮟"
                    elseif window.activeItem == #menus[activeMenu].items+1 then
                        text = "⮝"
                    else
                        text = "⮝ \ ⮟"
                    end
                    dxDrawText(text, arrowsPosition, nil, nil, tocolor(255, 255, 255), 1, window.titleFont, "center", "center")
                end
            end
        end
    end
end)


addEventHandler("onClientKey", getRootElement(), function(btn, state)
    if not isNativeShown then return end
    if btn == "arrow_d" and state == true then
        cancelEvent()
    end
    if btn == "arrow_u" and state == true then
        cancelEvent()
    end
    if btn == "arrow_r" and state == true then
        cancelEvent()
    end
    if btn == "arrow_l" and state == true then
        cancelEvent()
    end
    if btn == "enter" and state == true then
        cancelEvent()
    end
end)

function playNativeSound()
    sound = playSound("assets/change.wav", false)
end


function nativeArrowUp()
    if not isNativeShown then return end
    if #menus[activeMenu].items+1 == 1 then return end
    if menus[activeMenu].activeItem+1 > #menus[activeMenu].items then
        menus[activeMenu].activeItem = 1
    else
        menus[activeMenu].activeItem = menus[activeMenu].activeItem+1
    end
    playNativeSound()
end

function nativeArrowDown()
    if not isNativeShown then return end
    if #menus[activeMenu].items+1 == 0 then return end
    if menus[activeMenu].activeItem-1 < 1 then
        menus[activeMenu].activeItem = #menus[activeMenu].items
    else
        menus[activeMenu].activeItem = menus[activeMenu].activeItem-1
    end
    playNativeSound()
end

function nativeArrowRight()
    if not isNativeShown then return end
    if #menus[activeMenu].items == 0 then return end
    
    if menus[activeMenu].items[menus[activeMenu].activeItem].type == "switch" then
        local activeSwitch = menus[activeMenu].items[menus[activeMenu].activeItem]

        activeSwitch.currentPosition = activeSwitch.currentPosition+1
        if activeSwitch.currentPosition > #activeSwitch.values then 
            activeSwitch.currentPosition = 1 
        end

        playNativeSound()

        local actualSwitchIndex = activeSwitch.currentPosition
        local actualSwitchValue = activeSwitch.values[tonumber(actualSwitchIndex)]

        triggerEvent("onClientChangeNativeSwitch", activeSwitch.element, actualSwitchValue)
    end
end

function nativeArrowLeft()
    if not isNativeShown then return end
    if #menus[activeMenu].items == 0 then return end
    
    if menus[activeMenu].items[menus[activeMenu].activeItem].type == "switch" then
        local activeSwitch = menus[activeMenu].items[menus[activeMenu].activeItem]

        activeSwitch.currentPosition = activeSwitch.currentPosition-1
        if activeSwitch.currentPosition < 1 then 
            activeSwitch.currentPosition = #activeSwitch.values 
        end

        playNativeSound()

        local actualSwitchIndex = activeSwitch.currentPosition
        local actualSwitchValue = activeSwitch.values[tonumber(actualSwitchIndex)]

        triggerEvent("onClientChangeNativeSwitch", activeSwitch.element, actualSwitchValue)
    end
end

function nativeEnter()
    if not isNativeShown then return end
    if #menus[activeMenu].items == 0 then return end

    if menus[activeMenu].items[menus[activeMenu].activeItem].type == "switch" then
        local activeItem = menus[activeMenu].items[menus[activeMenu].activeItem]
        local actualSwitchIndex = activeItem.currentPosition
        local actualSwitchValue = activeItem.values[tonumber(actualSwitchIndex)]
        triggerEvent("onClientAcceptNativeSwitch", activeItem.element, actualSwitchValue)
    elseif menus[activeMenu].items[menus[activeMenu].activeItem].type == "checkbox" then
        menus[activeMenu].items[menus[activeMenu].activeItem].selected = not menus[activeMenu].items[menus[activeMenu].activeItem].selected
        playNativeSound()
        triggerEvent("onClientNativeCheckBoxChange", menus[activeMenu].items[menus[activeMenu].activeItem].element, menus[activeMenu].items[menus[activeMenu].activeItem].selected)
    end
end

function unbindKeys()
    unbindKey("arrow_d", "up", nativeArrowUp)
    unbindKey("arrow_u", "up", nativeArrowDown)

    unbindKey("arrow_r", "up", nativeArrowRight)
    unbindKey("arrow_l", "up", nativeArrowLeft)

    unbindKey("enter", "up", nativeEnter)
end

function bindKeys()
    unbindKeys()
    bindKey("arrow_d", "up", nativeArrowUp)
    bindKey("arrow_u", "up", nativeArrowDown)

    bindKey("arrow_r", "up", nativeArrowRight)
    bindKey("arrow_l", "up", nativeArrowLeft)

    bindKey("enter", "up", nativeEnter)
end

function getCurrentNativePage()
    local currentPage = math.ceil(menus[activeMenu].activeItem/menus[activeMenu].scroll_Items)
    return currentPage
end
