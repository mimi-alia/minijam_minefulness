extends RichTextLabel

var default_text = "stimulation: "
@onready var game: Node2D = get_parent()
var stimulation: float = 0.0

func _ready() -> void:
	game.stimulation_updated.connect(_on_updated)

func _on_updated(updated_stimulation: float) -> void:
	stimulation = updated_stimulation
	self.text = str(default_text, str(int(stimulation)))
