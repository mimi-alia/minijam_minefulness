extends TextureButton

@export var item: UpgradesData
@onready var game: Node2D = get_parent()
var inflation:float = 0.2

signal item_bought(item: UpgradesData)
func _pressed():
	if game.score>=item.cost:
		item_bought.emit(item)
		item.cost+= int(item.cost*inflation)
		
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.texture_normal = item.icon
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
