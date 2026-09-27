extends Node2D
var score: int = 300
var odds_modifier: int = 0
var purchased_items: Array[UpgradesData]
var has_dwarf: bool = false
@onready var passive_income_label: Label = $passive_income_label
@onready var crystal_popup: Control = $show_crystall
@onready var crystal_texture: TextureRect = $show_crystall/TextureRect
@onready var dwarf_texture: TextureRect = $dwarf_icon
@onready var mining_button: TextureButton = $clicker
@onready var upgrade_item: TextureButton = $shop_item
@onready var upgrade_item2: TextureButton = $shop_item2
@onready var income_timer: Timer = $IncomeTimer



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mining_button.crystal_mined.connect(_on_mined)
	upgrade_item.item_bought.connect(_on_purchased)
	upgrade_item2.item_bought.connect(_on_purchased)
	income_timer.timeout.connect(_on_dwarf_mining)

signal score_updated(current_score: int)

func _on_mined (crystal: CrystallData):
	crystal_texture.texture = crystal.icon
	score += crystal.points
	print("score is ", score)
	score_updated.emit(score)
	crystal_popup.visible = true

func _show_plus_one():
	passive_income_label.visible = true
	await get_tree().create_timer(0.5).timeout
	passive_income_label.visible = false

func _on_purchased(item: UpgradesData):
	print ("item purchased", item.name)
	if item.name == "Mining Dwarf":
		dwarf_texture.visible = true
		passive_income_label.text = str("+", str(item.passive_income))
		has_dwarf = true
	score -= item.previous_cost
	score_updated.emit(score)
	var existing_item = _find_purchased(item.name)
	if existing_item:
		existing_item.tier = item.tier
		existing_item.passive_income = item.passive_income
	else:
		purchased_items.append(item)
	print ("items owned ", purchased_items)
	odds_modifier+=item.modifier
	
func _find_purchased(name: String) -> UpgradesData:
	for existing in purchased_items:
		if existing.name == name:
			return existing
	return null	
	
func _on_dwarf_mining():
	if has_dwarf:
		var dwarf = _find_purchased("Mining Dwarf")
		_show_plus_one()
		score+= dwarf.passive_income
		score_updated.emit(score)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	pass
