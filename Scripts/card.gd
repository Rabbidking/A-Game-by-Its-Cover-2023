extends Control

signal moving()
signal finished()
signal like(card, image)
signal dislike(card)

@export var image1: CompressedTexture2D
@export var image2: CompressedTexture2D
@export var image3: CompressedTexture2D
@export var image4: CompressedTexture2D

@onready var images = [image1, image2, image3, image4]

var image_idx = 0

var pressed = false
var first_press_pos = null
var latest_speed = Vector2.ZERO

var nope_like_visible_dist = 450

var enabled = false

#var name_age_arr = ["John, 22", "Gabriella, 100", "Ipo, 33"]
var name_arr = ["Date 1", "Date 2", "Date 3", "Date 4"]
#var images = []

func _ready():
#	randomize()
#	# Choose random image set
#	images = sets[int(randf_range(0, 3))]
#
#	change_image(0)
#
#	## Choose random name
#	$Button/MarginContainer/HBoxContainer/VBoxContainer/NameAge.text = name_age_arr[int(randf_range(0, name_age_arr.size()))]
	#$Button/MarginContainer/HBoxContainer/VBoxContainer/Name.text = name_arr[int(randf_range(0, name_arr.size()))]
#
	$ScrollContainer/VBoxContainer/Image.material.set_shader_parameter("size", $ScrollContainer/VBoxContainer/Image.size)
#
	print($ScrollContainer/VBoxContainer/Image.texture.get_height())
	print($ScrollContainer/VBoxContainer/Image.texture.get_width())
	
func _input(event):
	if !enabled: return
	#if event is InputEventScreenDrag:
	#	var dist = event.position - first_press_pos
	#	emit_signal("moving")
	#	position = dist
	#	rotation = -(event.position.x - first_press_pos.x) * 0.025
		#if sign(dist.x) > 0: 
		#	$Like.modulate = lerp(Color("#00ffffff"), Color("#ffffffff"), abs(dist.x)/nope_like_visible_dist)
		#else:
		#	$Nope.modulate = lerp(Color("#00ffffff"), Color("#ffffffff"), abs(dist.x)/nope_like_visible_dist)
	#	pressed = false
	#	latest_speed = event.speed
		
	if event is InputEventMouseButton:
		if event.pressed:
			pressed = true
			first_press_pos = event.position
		else:
			if pressed:
				if event.position.x > (size.x/2):
					_on_next_button_pressed()
				else:
					_on_prev_button_pressed()
			else:
				pressed = false
				first_press_pos = null
				if abs(latest_speed.x) > 1000:
					# remove card
					position += latest_speed
					emit_signal("finished")
					if sign(latest_speed.x) > 0:
						emit_signal("like", self, $ScrollContainer/VBoxContainer/Image.texture)
					else:
						emit_signal("dislike", self)
					queue_free()
				else:
					position = Vector2.ZERO
					rotation = 0
					$Like.modulate = Color("#00ffffff")
					$Nope.modulate = Color("#00ffffff")
	
	
func change_image(idx):
	for child in $MarginContainer/HBoxContainer.get_children():
		child.value = 0
	$ScrollContainer/VBoxContainer/Image.texture = images[idx]
	$MarginContainer/HBoxContainer.get_child(idx).value = 100

func _on_prev_button_pressed():
	if image_idx == 0: image_idx = images.size() - 1
	else: image_idx -= 1
	change_image(image_idx)

func _on_next_button_pressed():
	if image_idx == images.size() - 1: image_idx = 0
	else: image_idx += 1
	change_image(image_idx)

func _on_Card_gui_input(event):
	print(event)

func _on_button_pressed():
	#load level corresponding to date
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	#pass # Replace with function body.
