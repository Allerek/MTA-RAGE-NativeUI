
local test_icons = {
    "art",
    "armour",
    "ammo",
    "accept",
    "barber",
}

local menu = createNativeUI("Test", "Test2", "assets/24.png", false, tocolor(0,0,0), tocolor(255,255,255), "left", true)

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

print("[NATIVE-TEST] getSwitchText: "..getSwitchText(menu, switch))
print("[NATIVE-TEST] setNativeSwitchSelection: "..tostring(setNativeSwitchSelection(menu, switch, 2)))
print("[NATIVE-TEST] setNativeSwitchSelection(2): "..tostring(setNativeSwitchSelection(menu, switch, "Ketchup")))

print("[NATIVE-TEST] nativeSetCheckBoxSelection: "..tostring(nativeSetCheckBoxSelection(menu, checkbox, true)))
print("[NATIVE-TEST] nativeGetCheckBoxSelection: "..tostring(nativeGetCheckBoxSelection(menu, checkbox)))

addEventHandler("onClientAcceptNativeSwitch", getRootElement(), function(value)
    print("[NATIVE-TEST] onClientAcceptNativeSwitch: "..value)
end)

addEventHandler("onClientChangeNativeSwitch", getRootElement(), function(value)
    print("[NATIVE-TEST] onClientChangeNativeSwitch: "..value)
end)

addEventHandler("onClientNativeCheckBoxChange", root, function(value)
    print("[NATIVE-TEST] onClientNativeCheckBoxChange: "..tostring(value))
end)


--local button = addNativeButton(menu, "KetchupJD")
