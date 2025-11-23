extends Area2D

@onready var player = $"../Player" 

var direction = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if direction == Vector2.ZERO:
		direction = player.position - position
		direction = direction.normalized()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * WorldStats.enemy_bullet_speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		WorldStats.player_life -= 1
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("weapons"):
		queue_free()
