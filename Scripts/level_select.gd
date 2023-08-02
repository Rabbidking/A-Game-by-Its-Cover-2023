extends Control

@export var card: PackedScene = preload("res://Scenes/card.tscn")

var next_card = null

func _ready():
	#randomize()
	$CardContainer/Card.enabled = true

func _on_Card_moving():
	if $CardContainer.get_child_count() != 1: return
	var instance = card.instantiate()
	$CardContainer.add_child(instance)
	$CardContainer.move_child(instance, 0)
	next_card = instance
	instance.connect("moving", Callable(self, "_on_Card_moving"))
	instance.connect("finished", Callable(self, "_on_Card_finished"))
	instance.connect("like", Callable(self, "on_card_liked"))
	instance.connect("dislike", Callable(self, "on_card_disliked"))

func _on_Card_finished():
	next_card.enabled = true

func on_card_liked(card, im):
	if randf() < 0.1:
		# It's a match!
		#var instance = match_scene.instantiate()
		#$MatchContainer.add_child(instance)
		#instance.set_image(im)
		#instance.connect("keep_swiping", Callable(self, "on_keep_swiping"))
		pass
	
func on_card_disliked(card):
	pass
	
func on_keep_swiping():
	$MatchContainer.get_child(0).call_deferred("queue_free")
