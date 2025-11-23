extends Area2D

var bullet_scene = preload("res://Scenes/Enemies/boss_1_bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_atack_timer_timeout() -> void:
	var bullet = bullet_scene.instantiate()
	bullet.position = position
	add_sibling(bullet)
