extends CharacterBody2D
class_name Player

@onready var attack_animation_player: AnimationPlayer = $AttackAnimationPlayer
@onready var attack_timer: Timer = $AttackTimer
@onready var collector_collision: CollisionShape2D = $Collector/CollectorCollision
@onready var dash_timer: Timer = $DashTimer
@onready var dash_cooldown_timer: Timer = $DashCooldownTimer

var can_attack = true
var can_dash = true

enum STATES {MOVING, DASHING}
var state = STATES.MOVING

var dash_direccion = Vector2.ZERO

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	
	collector_collision.shape.radius = WorldStats.collect_range
	
	attack_timer.wait_time = WorldStats.player_attack_speed
	
	dash_cooldown_timer.wait_time = WorldStats.dash_cooldown

func _physics_process(delta: float) -> void:
	match state:
		STATES.MOVING:
			velocity.x = Input.get_axis("move_left", "move_right")
			velocity.y = Input.get_axis("move_up", "move_down")
			velocity = velocity.normalized() * WorldStats.player_speed
			move_and_slide()
			
			if Input.is_action_just_pressed("attack") and can_attack:
				var angle = position.angle_to_point(get_global_mouse_position())
				$Attack.rotation = angle
				attack_animation_player.play("attack")
				can_attack = false
				attack_timer.start()
			
			if Input.is_action_just_pressed("dash") and can_dash:
				dash_direccion = velocity.normalized()
				state = STATES.DASHING
				if dash_direccion == Vector2.ZERO:
					state = STATES.MOVING
					return
				can_dash = false
				dash_timer.start()
				$DashAnimationPlayer.play("dash")
		STATES.DASHING:
			velocity = dash_direccion * WorldStats.dash_distance
			move_and_slide()


func _on_attack_timer_timeout() -> void:
	can_attack = true

func _on_dash_timer_timeout() -> void:
	state = STATES.MOVING
	dash_direccion = Vector2.ZERO
	dash_cooldown_timer.start()
	await get_tree().create_timer(0.215).timeout
	$DashAnimationPlayer.play("not_dash")


func _on_dash_cooldown_timer_timeout() -> void:
	can_dash = true
