extends Area2D

var direction = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if direction == Vector2.ZERO:
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * WorldStats.ally_bullet_speed * delta
	





func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemies"):
		queue_free()
