extends TextureButton

@export var clicks_needed: int = 10
var current_clicks: int = 0
@export var all_crystalls: Array[CrystallData] = []


func _pressed():
	current_clicks += 1
	print(current_clicks)
	if current_clicks >= clicks_needed:
		current_clicks = 0
		var crystal = _pick_crystall()
		_give_crystal(crystal)
		
func _pick_crystall() -> CrystallData:
	var total_weight:= 0
	for crystal in all_crystalls:
		total_weight += crystal.weight
	print(total_weight)
	var roll:= randf_range(0, total_weight)
	for crystal in all_crystalls:
		roll-= crystal.weight
		print (roll)
		if roll <= 0:
			return crystal
	return all_crystalls[-1]



func _give_crystal(crystal: CrystallData):
	
	print("you mined a ", crystal.name)
	
	
	
	pass


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
