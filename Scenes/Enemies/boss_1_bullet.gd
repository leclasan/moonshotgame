extends Area2D

var velocity = Vector2(140,-150)
var accel = Vector2(0,90)



func _ready() -> void:
	pass

func _process(delta: float) -> void:
	
	position += velocity * delta 
	velocity += accel * delta

func _on_timer_timeout() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		WorldStats.player_life -= 1
		queue_free()
