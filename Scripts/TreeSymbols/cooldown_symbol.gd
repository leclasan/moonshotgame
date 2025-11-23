extends TextureButton

@export var before_symbol: TextureButton

@onready var label: Label = $Label
@onready var tooltip_text_node: RichTextLabel = $Tooltip/TooltipText

@export var modification = 5
@export var base_cost: float = 6.0
@export var max_upgrades = 5
@export var index = 1
@export var text = "[b]{Attack Speed}[/b] [br] You attack 5% faster"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if before_symbol:
		if TreeStats.upgrades[before_symbol.index] > 0 and not visible:
			show()
			disabled = false
	
	if TreeStats.base_cost[index] == 0:
		TreeStats.base_cost[index] = base_cost
	
	if TreeStats.cost[index] == 0:
		TreeStats.cost[index] = int(TreeStats.base_cost[index])
	
	label.text = str(TreeStats.upgrades[index]) + "/" + str(max_upgrades)
	if TreeStats.upgrades[index] < max_upgrades:
		tooltip_text_node.text = text + ", cost:" + str(TreeStats.cost[index])
	else:
		tooltip_text_node.text = "[center][b]MAXED[/b][/center]"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if before_symbol:
		if TreeStats.upgrades[before_symbol.index] > 0 and not visible:
			show()
			disabled = false
			
	label.text = str(TreeStats.upgrades[index]) + "/" + str(max_upgrades)
	if TreeStats.upgrades[index] < max_upgrades:
		tooltip_text_node.text = text + ", cost:" + str(TreeStats.cost[index])
	else:
		tooltip_text_node.text = "[center][b]MAXED[/b][/center]"


func _on_pressed() -> void:
	if WorldStats.money >= TreeStats.cost[index] and TreeStats.upgrades[index] < max_upgrades:
		WorldStats.player_attack_speed -= (modification * WorldStats.player_attack_speed) / 100
		TreeStats.upgrades[index] += 1
		WorldStats.money -= TreeStats.cost[index]
		TreeStats.base_cost[index] += 10.0/100.0 * TreeStats.base_cost[index]
		TreeStats.cost[index] = int(TreeStats.base_cost[index])
