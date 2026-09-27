extends Label

@onready var game: Node2D = get_parent()

func _ready() -> void:
	visible = false
	game.breath_prompt_started.connect(_on_started)
	game.breath_prompt_ended.connect(_on_ended)

func _on_started() -> void:
	text = "Take a breath — hold Shift!"
	visible = true

func _on_ended(success: bool) -> void:
	visible = false
