extends Control

@onready var label: Label = $Label

func _ready() -> void:
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_play_again_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(WorldStats.level)


func _on_tree_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/tree_scene.tscn")
