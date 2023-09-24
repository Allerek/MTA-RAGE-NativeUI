
local test_icons = {
    "art",
    "armour",
    "ammo",
    "accept",
    "barber",
}

local menu = createNativeUI("Test", "Test2", "assets/24.png", false, tocolor(0,0,0), tocolor(255,255,255), "center", true)
local menu2 = createNativeUI("Test", "Test2", "assets/24.png", false, tocolor(0,0,0), tocolor(255,255,255), "left", true)

math.randomseed(os.time())
for i=1,15 do
    local rand = math.random(0,2)
    if rand == 0 then
        button = addNativeButton(menu, "Button "..i, tocolor(255, 255, 255), test_icons[math.random(1, #test_icons)])
    elseif rand == 1 then
        switch = addNativeSwitch(menu, "Sauce "..i, tocolor(255, 255, 255), {"Ketchup", "Mayo"})
    elseif rand == 2 then
        checkbox = addNativeCheckbox(menu, "Checkbox "..i, tocolor(255, 255, 255), false)
    end
end

for i=1,15 do
    local rand = math.random(0,2)
    if rand == 0 then
        button2 = addNativeButton(menu2, "Button "..i, tocolor(255, 255, 255), test_icons[math.random(1, #test_icons)])
    elseif rand == 1 then
        switch2 = addNativeSwitch(menu2, "Sauce "..i, tocolor(255, 255, 255), {"Ketchup", "Mayo"})
    elseif rand == 2 then
        checkbox2 = addNativeCheckbox(menu2, "Checkbox "..i, tocolor(255, 255, 255), false)
    end
end

print("[NATIVE-TEST] getSwitchText: "..getSwitchText(menu, switch))
print("[NATIVE-TEST] setNativeSwitchSelection: "..tostring(setNativeSwitchSelection(menu, switch, 2)))
print("[NATIVE-TEST] setNativeSwitchSelection(2): "..tostring(setNativeSwitchSelection(menu, switch, "Ketchup")))

print("[NATIVE-TEST] setNativeCheckboxSelection: "..tostring(setNativeCheckboxSelection(menu, checkbox, true)))
print("[NATIVE-TEST] getNativeCheckboxSelection: "..tostring(getNativeCheckboxSelection(menu, checkbox)))

addEventHandler("onClientAcceptNativeSwitch", getRootElement(), function(value)
    print("[NATIVE-TEST] onClientAcceptNativeSwitch: "..value)
    if activeMenu == menu then
        print("test")
        setNativeMenuActive(menu2)
    else
        print("test2")
        setNativeMenuActive(menu)
    end
end)

addEventHandler("onClientChangeNativeSwitch", getRootElement(), function(value)
    print("[NATIVE-TEST] onClientChangeNativeSwitch: "..value)
end)

addEventHandler("onClientNativeCheckBoxChange", root, function(value)
    print("[NATIVE-TEST] onClientNativeCheckBoxChange: "..tostring(value))
    destroyNativeMenu(menu)
    setNativeMenuActive(menu2)
end)

