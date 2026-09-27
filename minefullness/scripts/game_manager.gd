extends Node2D
var score: int = 0
var stimulation: float = 0.0
@onready var crystal_popup: Control = $show_crystall
@onready var crystal_texture: TextureRect = $show_crystall/TextureRect
@onready var mining_button: TextureButton = $clicker

@onready var blink_timer: Timer = $BlinkTimer
@onready var blink_window_timer: Timer = $BlinkWindowTimer
@onready var breath_timer: Timer = $BreathTimer
@onready var breath_window_timer: Timer = $BreathWindowTimer
@onready var breath_hold_timer: Timer = $BreathHoldTimer

var blink_window_open: bool = false
var breath_window_open: bool = false
var breath_holding: bool = false

signal score_updated(current_score: int)
signal stimulation_updated(current_stimulation: float)

signal blink_cycle_updated(progress: float)
signal blink_prompt_started()
signal blink_prompt_ended(success: bool)

signal breath_cycle_updated(progress: float)
signal breath_prompt_started()
signal breath_hold_updated(progress: float)
signal breath_prompt_ended(success: bool)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mining_button.crystal_mined.connect(_on_mined)
	blink_timer.timeout.connect(_on_blink_timer_timeout)
	blink_window_timer.timeout.connect(_on_blink_window_timeout)
	breath_timer.timeout.connect(_on_breath_timer_timeout)
	breath_window_timer.timeout.connect(_on_breath_window_timeout)
	breath_hold_timer.timeout.connect(_on_breath_hold_timeout)


func _on_mined(crystal: CrystallData):
	crystal_texture.texture = crystal.icon
	score += crystal.points
	print("score is ", score)
	score_updated.emit(score)
	crystal_popup.visible = true


func _process(delta: float) -> void:
	blink_cycle_updated.emit(1.0 - (blink_timer.time_left / blink_timer.wait_time))
	breath_cycle_updated.emit(1.0 - (breath_timer.time_left / breath_timer.wait_time))
	if breath_holding:
		breath_hold_updated.emit(1.0 - (breath_hold_timer.time_left / breath_hold_timer.wait_time))


func _add_stimulation(amount: float) -> void:
	stimulation += amount
	print("stimulation is ", stimulation)
	stimulation_updated.emit(stimulation)


# ---------- BLINK ----------

func _on_blink_timer_timeout() -> void:
	blink_window_open = true
	blink_prompt_started.emit()
	blink_window_timer.start()


func _on_blink_window_timeout() -> void:
	if blink_window_open:
		blink_window_open = false
		blink_prompt_ended.emit(false)
		_add_stimulation(1)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("blink"):
		if blink_window_open:
			blink_window_open = false
			blink_window_timer.stop()
			blink_prompt_ended.emit(true)

	if event.is_action_pressed("breathe"):
		if breath_window_open and not breath_holding:
			breath_window_open = false
			breath_window_timer.stop()
			breath_holding = true
			breath_hold_timer.start()

	if event.is_action_released("breathe"):
		if breath_holding:
			breath_holding = false
			breath_hold_timer.stop()
			breath_prompt_ended.emit(false)
			_add_stimulation(2)


# ---------- BREATHE ----------

func _on_breath_timer_timeout() -> void:
	breath_window_open = true
	breath_prompt_started.emit()
	breath_window_timer.start()


func _on_breath_window_timeout() -> void:
	if breath_window_open:
		breath_window_open = false
		breath_prompt_ended.emit(false)
		_add_stimulation(2)


func _on_breath_hold_timeout() -> void:
	breath_holding = false
	breath_prompt_ended.emit(true)
