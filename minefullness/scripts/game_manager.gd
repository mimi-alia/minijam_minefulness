extends Node2D
var score: int = 0
@onready var crystal_popup: Control = $show_crystall
@onready var crystal_texture: TextureRect = $show_crystall/TextureRect
@onready var mining_button: TextureButton = $clicker



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mining_button.crystal_mined.connect(_on_mined)
	
signal score_updated(current_score: int)
func _on_mined (crystal: CrystallData):
	crystal_texture.texture = crystal.icon
	score += crystal.points
	print("score is ", score)
	score_updated.emit(score)
	crystal_popup.visible = true
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
