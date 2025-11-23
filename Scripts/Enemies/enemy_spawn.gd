extends Area2D

var zombi_scene = preload("res://Scenes/Enemies/zombie.tscn")
var espectro_scene = preload("res://Scenes/Enemies/espectro.tscn")

var is_player = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(randi_range(15,1137),randi_range(15,633))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		is_player = true


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		is_player = false


func _on_spawn_timer_timeout() -> void:
	if not is_player:
		var num = randi_range(1,10)
		if num < 10:
			var zombie = zombi_scene.instantiate()
			zombie.position = position
			add_sibling(zombie)
		elif num > 9:
			var espectro = espectro_scene.instantiate()
			espectro.position = position
			add_sibling(espectro)
	queue_free()
