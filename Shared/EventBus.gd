extends Node

signal toggle_inventory(msg)

#Build Menu Signals
signal build_menu_opened() #This signal is emitted whenever the build menu is opened
signal build_menu_closed() #This signal is used to capture the event when the build menu is closed, either by the user or a proces
signal close_build_menu() #This signal is used to close the build menu
signal placing_mud_hut() #Emitted when user clicks on the Mud Hut's Place It button
signal placing_large_wall() #Emitted when user clicks on the Large Wall's Place It button
signal placing_small_wall() 

#Battle Menu Signals
signal battle_button_pressed() #Emitted when the user click the battle button
signal battle_menu_opened() #Emitted when the battle menu is opened 
signal battle_menu_closed() #Emitted when the user battle menu is closed
signal start_button_pressed() #Emitted when the start button is pressed
signal battle_banner_opened() #Emitted when the battle banner has been opened
signal battle_banner_closed() #Emitted when the battle banner is closed

signal victory() #Emitted when emeny spawn is defeated