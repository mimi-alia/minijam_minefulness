extends ProgressBar

@onready var game: Node2D = get_parent()

func _ready() -> void:
	min_value = 0.0
	max_value = 1.0
	game.blink_cycle_updated.connect(func(p): value = p)
