extends Area2D

var bullet_scene = preload("res://Scenes/Animals/eagle_bullet.tscn")

@onready var player = $"../Player"
@onready var atack_timer: Timer = $AtackTimer
@onready var move_timer: Timer = $MoveTimer

var curve_soft = 0.2

var old_speed = Vector2.ZERO

var velocity = 150

var can_attack = true
var can_move = true

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var enemy_list = get_tree().get_nodes_in_group("Enemies")
	var enemy = null
	var distance_to_enemy = 10000.0
	for i in enemy_list:
		if position.distance_to(i.position) <= distance_to_enemy:
			enemy = i
			distance_to_enemy = position.distance_to(i.position)
	
	if enemy and can_attack and position.distance_to(player.position) < 100:
			attack(enemy.position)
			can_move = false
			move_timer.start()
	
	elif can_move:
		if position.distance_to(player.position) > 90:
			var direction = player.position - position
			direction = direction.normalized()
			var direct_speed = direction 
			var speed = direct_speed * curve_soft + old_speed * (1 - curve_soft)
			position += speed * delta * velocity
			old_speed = speed

func attack(pos):
	can_attack = false
	atack_timer.start()
	var bullet = bullet_scene.instantiate()
	bullet.direction = (pos - position).normalized()
	bullet.global_position = global_position
	add_sibling(bullet) 


func _on_atack_timer_timeout() -> void:
	can_attack = true


func _on_move_timer_timeout() -> void:
	can_move = true
