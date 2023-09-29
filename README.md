# MTA RAGE NativeUI
Recreation of GTA V's Native UI for MTA:SA

Screen:

![image](https://github.com/Allerek/MTA-RAGE-NativeUI/assets/12304071/94ec3115-5fe7-415d-8158-70d638778429)

## Client Functions
## Menu

**createNativeUI**


Description:

*This function will create a menu*

Parameters:

 - string Menu Title
 - string Menu Caption or bool false
 - string Image Path **Standard Picture Paths "assets/defaultbg.png" and "assets/24.png"** / Texture element
 -  color Menu color(if image passed **false**)
 -  color Title color
 -  string Position that the menu will be **Possible positions right, center, left**
 - bool Show counter
 - int Quantity of items per page **Recommended 10, Maximum 10**
 - string Position that the menu title will be **Possible positions right, left, center**

returns native-menu element

Example:
```lua
local NativeUI = exports.MTA-RAGE-NativeUI
local menu = NativeUI:createNativeUI("NativeUI", "Menu Example:", "assets/defaultbg.png", false, tocolor(255,255,255), tocolor(255,255,255), "left", true)
```

**destroyNativeMenu**

Description:
*This function will destroy given Native Menu*

Parameters:

- native-menu Native Menu element

Example:
```lua
local NativeUI = exports.MTA-RAGE-NativeUI
local menu = NativeUI:createNativeUI("NativeUI", "Menu Example:", "assets/defaultbg.png", false, tocolor(255,255,255), tocolor(255,255,255), "left", true)

addCommandHandler("destroymenu", function()
    NativeUI:destroyNativeMenu(menu)
end)
```

**setNativeMenuVisible**

Description:
*This function will set given Native Menu visible/unvisible*

Parameters:

- native-menu Native Menu element
- bool true/false(Visible/Invisibile)

Example:
```lua
local NativeUI = exports.MTA-RAGE-NativeUI
local menu = NativeUI:createNativeUI("NativeUI", "Menu Example:", "assets/defaultbg.png", false, tocolor(255,255,255), tocolor(255,255,255), "left", true)
NativeUI:setNativeMenuVisible(menu, false)

addCommandHandler("showmenu", function()
    if not state then
       state = true
       NativeUI:setNativeMenuVisible(menu, state)
    else
       state = false
       NativeUI:setNativeMenuVisible(menu, state)
    end
end)
```
  
**setNativeMenuActive**

Description:
*This function will set given Native Menu active*

Parameters:

- native-menu Native Menu element

Example:
```lua
local NativeUI = exports.MTA-RAGE-NativeUI
local menu = NativeUI:createNativeUI("NativeUI", "Menu Example:", "assets/defaultbg.png", false, tocolor(255,255,255), tocolor(255,255,255), "left", true)
local menu2 = NativeUI:createNativeUI("NativeUI #2", "Menu Example:", "assets/defaultbg.png", false, tocolor(255,255,255), tocolor(255,255,255), "right", true)
NativeUI:setNativeMenuActive(menu)

addCommandHandler("menuactivity", function()
    if not state then
       state = true
       NativeUI:setNativeMenuActive(menu2)
    else
       state = false
       NativeUI:setNativeMenuActive(menu)
    end
end)
```

## Button
**addNativeButton**

Description:
*This function will create a Native Button*

Parameters:

- native-menu Native Menu element
- string Text to be displayed
- color Text color
- string Icon(all possible in assets/icons/), do not include a number on the end of the name(f.e "clothing", check test.lua)

returns native-button element

Example:
```lua
local NativeUI = exports.MTA-RAGE-NativeUI
local menu = NativeUI:createNativeUI("NativeUI", "Menu Example:", "assets/defaultbg.png", false, tocolor(255,255,255), tocolor(255,255,255), "left", true)
local button = NativeUI:addNativeButton(menu, "Ketchup", tocolor(255,255,255), false)
```

**setNativeButtonIcon**

Description:
*This function will change Native Button icon*

Parameters:

- native-menu Native Menu element
- native-button Native Button element
- string Icon(all possible in assets/icons/), do not include a number on the end of the name(f.e "clothing", check test.lua)

Example:
```lua
local NativeUI = exports.MTA-RAGE-NativeUI
local menu = NativeUI:createNativeUI("NativeUI", "Menu Example:", "assets/defaultbg.png", false, tocolor(255,255,255), tocolor(255,255,255), "left", true)
local button = NativeUI:addNativeButton(menu, "Ketchup", tocolor(255,255,255), false)
NativeUI:setNativeButtonIcon(menu, button, "clothing")
```

**removeNativeButton**

Description:
*This function will destroy Native Button*

Parameters:

- native-menu Native Menu element
- native-button Native Button element

Example:
```lua
local NativeUI = exports.MTA-RAGE-NativeUI
local menu = NativeUI:createNativeUI("NativeUI", "Menu Example:", "assets/defaultbg.png", false, tocolor(255,255,255), tocolor(255,255,255), "left", true)
local button = NativeUI:addNativeButton(menu, "Ketchup", tocolor(255,255,255), false)

addCommandHandler("removebutton", function()
    NativeUI:removeNativeButton(menu, button)
end)
```

## Switch
**addNativeSwitch**

Description:
*This function will create a Native Switch*

Parameters:

- native-menu Native Menu element
- string Text to be displayed
- color Text color
- table Values to be displayed

returns native-switch element

Example:
```lua
#Version 1
local NativeUI = exports.MTA-RAGE-NativeUI
local menu = NativeUI:createNativeUI("NativeUI", "Menu Example:", "assets/defaultbg.png", false, tocolor(255,255,255), tocolor(255,255,255), "left", true)
local switch = NativeUI:addNaitveSwitch(menu, "Inventory", tocolor(255,255,255), {"Ketchup", "Mustard", "Apple"})

#Version 2
local inventory = {"Ketchup", "Mustard", "Apple"}

local NativeUI = exports.MTA-RAGE-NativeUI
local menu = NativeUI:createNativeUI("NativeUI", "Menu Example:", "assets/defaultbg.png", false, tocolor(255,255,255), tocolor(255,255,255), "left", true)
local switch = NativeUI:addNaitveSwitch(menu, "Inventory", tocolor(255,255,255), inventory)
```

**getSwitchText**

Description:
*This function will get current text from Native Switch*

Parameters:

- native-menu Native Menu element
- native-switch Native Switch Element

returns native-switch current text

Example:
```lua
local NativeUI = exports.MTA-RAGE-NativeUI
local menu = NativeUI:createNativeUI("NativeUI", "Menu Example:", "assets/defaultbg.png", false, tocolor(255,255,255), tocolor(255,255,255), "left", true)
local switch = NativeUI:addNaitveSwitch(menu, "Inventory", tocolor(255,255,255), {"Ketchup", "Mustard"})

addCommandHandler("checktext", function()
    if NativeUI:getSwitchText(menu, switch) == "Ketchup" then
       iprint("Indeed you have ketchup on your hot dog")
    elseif NativeUI:getSwitchText(menu, switch) == "Mustard" then
       iprint("Now you have mustard too")
    end
end)
```

**setNativeSwitchSelection**

Description:
*This function will set new text for Native Switch Element

Parameters:

- native-menu Native Menu element
- native-switch Native Switch Element
- number/string New Native Switch Selection

Example:
```lua
local NativeUI = exports.MTA-RAGE-NativeUI
local menu = NativeUI:createNativeUI("NativeUI", "Menu Example:", "assets/defaultbg.png", false, tocolor(255,255,255), tocolor(255,255,255), "left", true)
local switch = NativeUI:addNaitveSwitch(menu, "Inventory", tocolor(255,255,255), {"Ketchup", "Mustard"})

addCommandHandler("changeswitch", function()
    if not item then
       item = "Mustard"
       NativeUI:setNativeSwitchSelection(menu, switch, item)
    else
       item = "Ketchup"
       NativeUI:setNativeSwitchSelection(menu, switch, item)
    end
end)
```

## Checkbox

**addNativeCheckbox**

Description:
*This function will create a Native Checkbox*

Parameters:

- native-menu Native Menu element
- string Text to be displayed
- color Text color
- bool True/False if checkbox is selected(checked)

returns native-checkbox element

Example:
```lua
local NativeUI = exports.MTA-RAGE-NativeUI
local menu = NativeUI:createNativeUI("NativeUI", "Menu Example:", "assets/defaultbg.png", false, tocolor(255,255,255), tocolor(255,255,255), "left", true)
local checkbox = NativeUI:addNativeCheckbox(menu, "Dance", tocolor(255,255,255), false)
```

**nativeSetCheckBoxSelection**

Description:
*This function will set Native Checkbox selected/unselected*

Parameters:

- native-menu Native Menu element
- native-checkbox Native Checkbox element
- bool True/False if checkbox is selected(checked)

Example:
```lua
local NativeUI = exports.MTA-RAGE-NativeUI
local menu = NativeUI:createNativeUI("NativeUI", "Menu Example:", "assets/defaultbg.png", false, tocolor(255,255,255), tocolor(255,255,255), "left", true)
local checkbox = NativeUI:addNativeCheckbox(menu, "Dance", tocolor(255,255,255), false)
NativeUI:nativeSetCheckBoxSelection(menu, checkbox, true)
```

**nativeGetCheckBoxSelection**

Description:
*This function will get Native Checkbox selected/unselected*

Parameters:

- native-menu Native Menu element
- native-checkbox Native Checkbox element

Example:
```lua
local NativeUI = exports.MTA-RAGE-NativeUI
local menu = NativeUI:createNativeUI("NativeUI", "Menu Example:", "assets/defaultbg.png", false, tocolor(255,255,255), tocolor(255,255,255), "left", true)
local checkbox = NativeUI:addNativeCheckbox(menu, "Dance", tocolor(255,255,255), false)
NativeUI:nativeSetCheckBoxSelection(menu, checkbox, true)

addCommandHandler("checkbox", function()
    if NativeUI:nativeGetCheckBoxSelection(menu, checkbox) == true then
       NativeUI:nativeSetCheckBoxSelection(menu, checkbox, false)
    elseif NativeUI:nativeGetCheckBoxSelection(menu, checkbox) == false then
       NativeUI:nativeSetCheckBoxSelection(menu, checkbox, true)
    end
end)
```
