extends Node

var level = "res://Scenes/Levels/level_1.tscn"

var player_max_life = 1
var player_life = 1
var player_speed = 120
var player_attack_speed = 1.3
var player_damage = 10
var dash_cooldown = 1
var dash_distance = 500

var collect_range = 48

var enemy_life = 10
var enemy_attack_time = 2.2
var enemy_speed = 88
var enemy_bullet_speed = 195

var starting_enemies = 4
var enemy_spawn_time = 1
var enemy_amount = 1

var money = 0
var this_run_money = 0

var time = 10

var ally_bullet_speed = 180

func _ready() -> void:
	pass # Replace with function body.
