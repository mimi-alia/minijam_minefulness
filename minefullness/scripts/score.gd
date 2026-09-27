extends RichTextLabel

var default_text = "current score: "
@onready var game: Node2D = get_parent()
var score:int = 100
# Called when the node enters the scene tree for the first time.


func _ready() -> void:
	game.score_updated.connect(_on_updated)
	self.text = str(default_text, str(game.score))

func _on_updated(updated_score: int):
	print(updated_score)
	score = updated_score
	self.text = str(default_text, str(score))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	pass
