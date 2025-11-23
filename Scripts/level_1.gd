extends Node2D

var spawn_scene = preload("res://Scenes/Enemies/enemy_spawn.tscn")
var minibos_scene = preload("res://Scenes/Enemies/minibos_slime.tscn")

@export var level_number = 1
@export var next_level: String

@export var enemy_reload: float
@export var enemy_bullet_speed: int
@export var enemy_speed: int
@export var enemy_spawn_time: int
@export var starting_enemies: int
@export var enemy_amount: int
@export var enemy_life: int

@onready var time = WorldStats.time

@onready var time_label: Label = $TimeLabel
@onready var money_label: Label = $MoneyLabel
@onready var lose: Control = $Lose
@onready var spawn_timer: Timer = $SpawnTimer

var killed_enemies = 0
var necesary_kills = 15

var is_minibos = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time_label.text = str(time)
	money_label.text = str(WorldStats.this_run_money)
	spawn_timer.wait_time = WorldStats.enemy_spawn_time
	spawn_timer.start()
	for i in WorldStats.starting_enemies:
		var spawn = spawn_scene.instantiate()
		add_child(spawn)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	money_label.text = str(WorldStats.this_run_money)
	
	if WorldStats.player_life <= 0:
		WorldStats.player_life = WorldStats.player_max_life
		WorldStats.this_run_money = 0
		lose.label.text = "You Died"
		lose.show()
		get_tree().paused = true
	
	if killed_enemies >= necesary_kills and not is_minibos:
		is_minibos = true
		var minibos = minibos_scene.instantiate()
		add_child(minibos)



func _on_time_timer_timeout() -> void:
	time -= 1
	time_label.text = str(time)
	if time <= 0:
		WorldStats.player_life = WorldStats.player_max_life
		WorldStats.this_run_money = 0
		lose.label.text = "The time ran out"
		lose.show()
		get_tree().paused = true


func _on_spawn_timer_timeout() -> void:
	if is_minibos:
		return
	for i in WorldStats.enemy_amount:
		var spawn = spawn_scene.instantiate()
		add_child(spawn)

func win():
	WorldStats.level = next_level
	WorldStats.player_life = WorldStats.player_max_life
	WorldStats.this_run_money = 0
	
	WorldStats.enemy_attack_time -= int(enemy_reload/100.0 * WorldStats.enemy_attack_time) 
	WorldStats.enemy_bullet_speed += int(enemy_bullet_speed% WorldStats.enemy_bullet_speed)
	WorldStats.enemy_speed += int(enemy_speed% WorldStats.enemy_speed)
	WorldStats.enemy_amount += enemy_amount
	WorldStats.enemy_spawn_time -= int(enemy_spawn_time% WorldStats.enemy_spawn_time)
	WorldStats.starting_enemies += starting_enemies
	WorldStats.enemy_life += enemy_life% WorldStats.enemy_life
	
	lose.label.text = "¡¡YOU WON THIS LEVEL!!"
	lose.show()
	get_tree().paused = true
