extends ProgressBar

@onready var game: Node2D = get_parent()

func _ready() -> void:
	min_value = 0.0
	max_value = 1.0
	visible = false
	game.breath_prompt_started.connect(func(): visible = true; value = 0.0)
	game.breath_prompt_ended.connect(func(success): visible = true)
	game.breath_hold_updated.connect(func(p): value = p)
	
