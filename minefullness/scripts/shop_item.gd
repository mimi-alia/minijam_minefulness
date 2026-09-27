extends TextureButton

@export var item: UpgradesData
@onready var game: Node2D = get_parent()
var inflation:float = 0.2
var income_multiplier:int = 5

signal item_bought(item: UpgradesData)
func _pressed():
	if game.score>=item.cost:
		var purchased_copy = item.duplicate()
		item_bought.emit(purchased_copy)
		item.previous_cost = item.cost
		item.cost+= int(item.cost*inflation)
		item.tier+=1
		if item.passive_income > 0:
			item.passive_income*=income_multiplier
		
		
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.texture_normal = item.icon
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
