extends Area2D

@onready var player = $"../Player"
@onready var life = WorldStats.enemy_life

var coin_scene = preload("res://Scenes/coin.tscn")

var old_speed = Vector2.ZERO

var curve_soft = 0.2


func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = player.position - position
	direction = direction.normalized()
	var direct_speed = direction 
	var speed = direct_speed * curve_soft + old_speed * (1 - curve_soft)
	position += speed * delta * WorldStats.enemy_speed
	old_speed = speed
	if life <= 0:
		die()


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		WorldStats.player_life -= 1
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("weapons"):
		life -= WorldStats.player_damage

func die():
	var coin = coin_scene.instantiate()
	coin.position = position
	add_sibling(coin)
	
	get_parent().killed_enemies += 1
	
	queue_free()
