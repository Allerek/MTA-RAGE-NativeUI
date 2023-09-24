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

**destroyNativeMenu**

Description:
*This function will destroy given Native Menu*

Parameters:

- native-menu Native Menu element

**setNativeMenuVisible**

Description:
*This function will set given Native Menu visible/unvisible*

Parameters:

- native-menu Native Menu element
- bool true/false(Visible/Invisibile)

  
**getNativeMenuVisible (Added by Hydra45)**

Description:
*This function will return true if the menu is visible and false if not*

Parameters:

- native-menu Native Menu element
  
**setNativeMenuActive**

Description:
*This function will set given Native Menu active*

Parameters:

- native-menu Native Menu element

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

**setNativeButtonSelected (Added by Hydra45)**

Description:
*This function will make a button from a respective menu to be selected or not*

Parameters:

- native-menu Native Menu element
- native-button Native Button element
- bool true/false

**getNativeButtonSelected (Added by Hydra45)**

Description:
*This function will check if a button from a respective menu is selected or not*

Parameters:

- native-menu Native Menu element
- native-button Native Button element

return true if the button is selected and false if not

**setNativeButtonIcon**

Description:
*This function will change Native Button icon*

Parameters:

- native-menu Native Menu element
- native-button Native Button element
- string Icon(all possible in assets/icons/), do not include a number on the end of the name(f.e "clothing", check test.lua)

**removeNativeButton**

Description:
*This function will destroy Native Button*

Parameters:

- native-menu Native Menu element
- native-button Native Button element

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

**getSwitchText**

Description:
*This function will get current text from Native Switch*

Parameters:

- native-menu Native Menu element
- native-switch Native Switch Element

returns native-switch current text

**setNativeSwitchSelection**

Description:
*This function will set new text for Native Switch Element

Parameters:

- native-menu Native Menu element
- native-switch Native Switch Element
- number/string New Native Switch Selection

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

**nativeSetCheckBoxSelection**

Description:
*This function will set Native Checkbox selected/unselected*

Parameters:

- native-menu Native Menu element
- native-checkbox Native Checkbox element
- bool True/False if checkbox is selected(checked)


**nativeGetCheckBoxSelection**

Description:
*This function will get Native Checkbox selected/unselected*

Parameters:

- native-menu Native Menu element
- native-checkbox Native Checkbox element


