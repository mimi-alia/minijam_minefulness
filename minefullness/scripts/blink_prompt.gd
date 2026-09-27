extends Label

@onready var game: Node2D = get_parent()

func _ready() -> void:
	visible = false
	game.blink_prompt_started.connect(_on_started)
	game.blink_prompt_ended.connect(_on_ended)

func _on_started() -> void:
	text = "Remember to blink!"
	visible = true

func _on_ended(success: bool) -> void:
	visible = false
