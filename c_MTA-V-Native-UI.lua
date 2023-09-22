menus = {}

local isNativeShown = false
local activeMenu = false
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
        assert(align == "left" or align == "right", "Invalid align type @ createNativeUI [expected 'left'/'right' at argument 7,  got"..type(align).." '"..tostring(align).."'']")
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
    
    menu.name = name
    menu.title = title
    menu.bgImagePos = Vector2(10*scale, 10*scale)
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

    menus[menuElement] = menu
    menus[menuElement].items = items

    isNativeShown = true

    activeMenu = menuElement
    activeItem = 1

    bindKeys()
    return menuElement
end

addEventHandler("onClientRender", getRootElement(), function()
    for k,window in pairs(menus) do
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
            dxDrawText(activeItem.."/"..#window.items, window.counterTextPosition, nil, nil, window.titleColor, 1, window.titleFont, "right", "center")
        end

        for i,v in ipairs(window.items) do

            itemsPage = math.ceil(i/window.scroll_Items)
            dxDrawText(getCurrentNativePage(), 0, 0, 0, 0)

            if i > window.scroll_Items*(getCurrentNativePage()-1) and i <= window.scroll_Items*getCurrentNativePage() then   

                i=i-window.scroll_Items*(getCurrentNativePage()-1)
                if activeItem-window.scroll_Items*(getCurrentNativePage()-1) == i then
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
                    if i == activeItem then
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
                    if i == activeItem then
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
                    if activeItem == 1 then
                        text = "⮟"
                    elseif activeItem == #menus[activeMenu].items+1 then
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

function bindKeys()
    bindKey("arrow_d", "up", function()
        if not isNativeShown then return end
        if #menus[activeMenu].items+1 == 1 then return end
        if activeItem+1 > #menus[activeMenu].items then
            activeItem = 1
        else
            activeItem = activeItem+1
        end
        playNativeSound()
    end)
    bindKey("arrow_u", "up", function()
        if not isNativeShown then return end
        if #menus[activeMenu].items+1 == 0 then return end
        if activeItem-1 < 1 then
            activeItem = #menus[activeMenu].items
        else
            activeItem = activeItem-1
        end
        playNativeSound()
    end)
    bindKey("arrow_r", "up", function()
        if not isNativeShown then return end
        if #menus[activeMenu].items == 0 then return end
        
        if menus[activeMenu].items[activeItem].type == "switch" then
            local activeSwitch = menus[activeMenu].items[activeItem]

            activeSwitch.currentPosition = activeSwitch.currentPosition+1
            if activeSwitch.currentPosition > #activeSwitch.values then 
                activeSwitch.currentPosition = 1 
            end

            playNativeSound()

            local actualSwitchIndex = activeSwitch.currentPosition
            local actualSwitchValue = activeSwitch.values[tonumber(actualSwitchIndex)]

            triggerEvent("onClientChangeNativeSwitch", activeSwitch.element, actualSwitchValue)
        end
    end)

    bindKey("arrow_l", "up", function()
        if not isNativeShown then return end
        if #menus[activeMenu].items == 0 then return end
        
        if menus[activeMenu].items[activeItem].type == "switch" then
            local activeSwitch = menus[activeMenu].items[activeItem]

            activeSwitch.currentPosition = activeSwitch.currentPosition-1
            if activeSwitch.currentPosition < 1 then 
                activeSwitch.currentPosition = #activeSwitch.values 
            end

            playNativeSound()

            local actualSwitchIndex = activeSwitch.currentPosition
            local actualSwitchValue = activeSwitch.values[tonumber(actualSwitchIndex)]

            triggerEvent("onClientChangeNativeSwitch", activeSwitch.element, actualSwitchValue)
        end
    end)

    bindKey("enter", "up", function()
        if not isNativeShown then return end
        if #menus[activeMenu].items == 0 then return end

        if menus[activeMenu].items[activeItem].type == "switch" then
            local activeItem = menus[activeMenu].items[activeItem]
            local actualSwitchIndex = activeItem.currentPosition
            local actualSwitchValue = activeItem.values[tonumber(actualSwitchIndex)]
            triggerEvent("onClientAcceptNativeSwitch", activeItem.element, actualSwitchValue)
        elseif menus[activeMenu].items[activeItem].type == "checkbox" then
            menus[activeMenu].items[activeItem].selected = not menus[activeMenu].items[activeItem].selected
            playNativeSound()
            triggerEvent("onClientNativeCheckBoxChange", menus[activeMenu].items[activeItem].element, menus[activeMenu].items[activeItem].selected)
        end
    end)
end

function getCurrentNativePage()
    local currentPage = math.ceil(activeItem/menus[activeMenu].scroll_Items)
    return currentPage
end
