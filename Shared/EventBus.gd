extends Node


signal toggle_inventory(msg)

signal build_menu_opened() #This signal is emitted whenever the build menu is opened
signal build_menu_closed() #This signal is used to capture the event when the build menu is closed, either by the user or a proces
signal close_build_menu() #This signal is used to close the build menu
signal placing_mud_hut() #Emitted when user clicks on the Mud Hut's Place It button
signal placing_large_wall() #Emitted when user clicks on the Large Wall's Place It button

