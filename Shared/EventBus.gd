extends Node

signal toggle_inventory(msg)

#pause
signal pause_game()
signal unpause_game()

#Build Menu Signals
signal build_menu_opened() #This signal is emitted whenever the build menu is opened
signal build_menu_closed() #This signal is used to capture the event when the build menu is closed, either by the user or a proces
signal close_build_menu() #This signal is used to close the build menu
signal placing_mud_hut() #Emitted when user clicks on the Mud Hut's Place It button
signal placing_large_wall() #Emitted when user clicks on the Large Wall's Place It button
signal placing_small_wall() #Emitted when user clicks on the Small Wall's Place It button
signal placing_torch() #Emitted when user clicks on the Torch's Place It button
signal placing_bomb_barrel() #Emitted when user clicks on the Bomb Barrel's Place It button

#Battle Menu Signals
signal battle_button_pressed() #Emitted when the user click the battle button
signal battle_menu_opened() #Emitted when the battle menu is opened 
signal battle_menu_closed() #Emitted when the user battle menu is closed
signal start_button_pressed() #Emitted when the start button is pressed
signal battle_banner_opened() #Emitted when the battle banner has been opened
signal battle_banner_closed() #Emitted when the battle banner is closed

#Enemy Spawning signals
signal spawnDefeated() #Emitted when mobspawn has been defeated
signal victory() #Emitted when emeny spawn and windigo is defeated

#Defeat Signals
signal defeat() #When the character dies Game Over Window pops up
signal close_toolbar()
signal set_enemies_killed()
signal set_heroes_killed()
signal set_defenses_destroyed()
