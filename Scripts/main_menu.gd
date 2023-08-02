extends Node

@onready var drop_down_menu: OptionButton = $CanvasLayer/Settings/CenterContainer/PanelContainer/MarginContainer/ScrollContainer/VBoxContainer/ResolutionButton
@onready var main: Control = $CanvasLayer/MainMenu
@onready var settings: Control = $CanvasLayer/SettingsMenu
@onready var music = $AudioStreamPlayer2D

@export var _bus = AudioServer.get_bus_index("Master")

func _ready():
	#add_items()
	main.visible = true
	settings.visible = false
	#music.play()


#Button pressed functions
func _on_play_button_pressed():
	pass

func _on_quit_button_pressed():
	get_tree().quit()

func _on_options_button_pressed():
	main.visible = false
	settings.visible = true

func _on_load_button_pressed():
	pass # Replace with function body.
