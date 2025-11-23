extends Area2D

@onready var player = $"../Player"
@onready var attack_timer: Timer = $AttackTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var curve_soft = 0.2

var old_speed = Vector2.ZERO

var max_enemy_distance = 200

var velocity = 130

var can_attack = true

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var enemy_list = get_tree().get_nodes_in_group("Enemies")
	var enemy = null
	var distance_to_enemy = max_enemy_distance
	for i in enemy_list:
		if position.distance_to(i.position) <= distance_to_enemy:
			enemy = i
			distance_to_enemy = position.distance_to(i.position)
	
	if enemy:
		var direction = enemy.position - position
		direction = direction.normalized()
		var direct_speed = direction 
		var speed = direct_speed * curve_soft + old_speed * (1 - curve_soft)
		position += speed * delta * velocity
		old_speed = speed
		if position.distance_to(enemy.position) < 6:
			attack()
	
	else:
		if position.distance_to(player.position) > 90:
			var direction = player.position - position
			direction = direction.normalized()
			var direct_speed = direction 
			var speed = direct_speed * curve_soft + old_speed * (1 - curve_soft)
			position += speed * delta * velocity
			old_speed = speed

func attack():
	if can_attack:
		can_attack = false 
		animation_player.play("attack")
		attack_timer.start()


func _on_attack_timer_timeout() -> void:
	can_attack = true
