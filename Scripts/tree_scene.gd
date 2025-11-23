extends Node2D

@onready var skill_tree: Control = $SkillTree
@onready var coliseum: Control = $Coliseum
@onready var animals: Control = $Animals

@onready var money_label: Label = $RightBarContainer/MoneyLabel

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	money_label.text = str(WorldStats.money)


func _on_skill_tree_button_pressed() -> void:
	skill_tree.show()
	skill_tree.process_mode = Node.PROCESS_MODE_PAUSABLE
	coliseum.hide()
	coliseum.process_mode = Node.PROCESS_MODE_DISABLED
	animals.hide()
	animals.process_mode = Node.PROCESS_MODE_DISABLED


func _on_colliseum_button_pressed() -> void:
	coliseum.show()
	coliseum.process_mode = Node.PROCESS_MODE_PAUSABLE
	skill_tree.hide()
	skill_tree.process_mode = Node.PROCESS_MODE_DISABLED
	animals.hide()
	animals.process_mode = Node.PROCESS_MODE_DISABLED


func _on_animals_button_pressed() -> void:
	animals.show()
	animals.process_mode = Node.PROCESS_MODE_PAUSABLE
	skill_tree.hide()
	skill_tree.process_mode = Node.PROCESS_MODE_DISABLED
	coliseum.hide()
	coliseum.process_mode = Node.PROCESS_MODE_DISABLED
