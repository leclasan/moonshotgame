extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_value = get_parent().necesary_kills


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	value = get_parent().killed_enemies
