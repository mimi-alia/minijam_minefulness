extends TextureButton

@export var clicks_needed: int = 10
var current_clicks: int = 0
@export var all_crystalls: Array[CrystallData] = []


func _pressed():
	current_clicks += 1
	print(current_clicks)
	if current_clicks >= clicks_needed:
		current_clicks = 0
		var crystal = _pick_crystall(clicks_needed)
		_give_crystal(crystal)
		clicks_needed = _randomize_clicks()
		
		
func _randomize_clicks():
	var new_clicks :=randi_range(10, 30)
	print ("new amount of clicks needed", new_clicks)
	return new_clicks
	
func _pick_crystall(clicks_needed: int) -> CrystallData:
	var total_weight:= 0
	var modifier := remap(clicks_needed, 10, 30, 0, 10)
	for crystal in all_crystalls:
		total_weight += crystal.weight
	print(total_weight)
	var roll:= randf_range(0, total_weight+modifier)
	print ("you rolled ", roll)
	for crystal in all_crystalls:
		roll-= crystal.weight
		print (crystal.name, " ", roll)
		if roll <= 0:
			return crystal
	return all_crystalls[-1]

signal crystal_mined(crystal: CrystallData)

func _give_crystal(crystal: CrystallData):
	crystal_mined.emit(crystal)
	print("you mined a ", crystal.name)
	
	
	
	
	pass


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
