extends RichTextLabel


# Called when the node enters the scene tree for the first time.
var default_text = "$"
@onready var buff: TextureButton = get_parent()
var price: int

# Called when the node enters the scene tree for the first time.


func _ready() -> void:
	price = buff.item.cost
	buff.item_bought.connect(_on_purchased)
	self.text = str(default_text, str(price))


func _on_purchased(bought_item: UpgradesData):
	var new_price = bought_item.cost
	self.text = str(default_text, str(new_price))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	pass
