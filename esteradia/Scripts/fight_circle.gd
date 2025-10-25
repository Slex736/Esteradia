extends Node2D

var particle = preload("res://Scenes/particle_attack_ring.tscn")
var is_in_circle = false
var particle_placements = []

var files_runes = ["res://Rune Paths/Rune Of Flame(fireball).txt", "res://Rune Paths/Rune Of Lightning(stunenemiesandbreakdoors).txt",
	"res://Rune Paths/Rune Of motion(telekenesis).txt", "res://Rune Paths/Rune Of Shift(tping).txt",
	"res://Rune Paths/Rune Of stone(placebrickcanbemovedwithtk).txt", "res://Rune Paths/Rune Of Weave(slingortrapping).txt"	
]

var root = preload("res://Scenes/root.tscn")

func _process(_delta: float) -> void:
	# inherits from circle
	is_in_circle = $circle.is_in_circle
	# checks for left click
	var place_particle = Input.is_action_pressed("Place_particle")
	
	if place_particle and is_in_circle:
		Note_cords()
		make_particle()
	
	var play_spell = Input.is_action_just_pressed("Play_Spell")
	if play_spell:
		var rune = recognise_spell()
		print(rune_int(rune))
		get_tree().change_scene_to_packed(root)
		

func make_particle():
		var mouse_pos = get_global_mouse_position()
		var scene = particle.instantiate()
		add_child(scene)
		scene.global_position = mouse_pos

func Note_cords():
	var mouse_pos = get_global_mouse_position()
	particle_placements.append(mouse_pos)


		
func recognise_spell():
	
	var counter = 1
	var smallest_index = 0
	var smallest_distance = INF
	
	for file_rune in files_runes:
		var coords = []
		var file = FileAccess.open(file_rune, FileAccess.READ)
		
		while file.get_position() < file.get_length():
			var line = file.get_line()
			var parts = line.split(",")
			if parts.size() == 2:
				coords.append(Vector2(parts[0].to_float(), parts[1].to_float()))
		file.close()
		
		if particle_placements == null:
			print("no particles have been placed")
		
		var total_dist = path_similarity(coords, particle_placements)
		# Keep the smallest distance
		if total_dist < smallest_distance:
			smallest_distance = total_dist
			smallest_index = counter
		
		counter += 1
		
	return smallest_index
	
func path_similarity(a: Array, b: Array):
	if a.size() == 0 or b.size() == 0:
		return 

	var length = max(a.size(), b.size())
	var total_dist = 0.0

	for i in range(length):
		var ai = a[int(float(i) / length * a.size())]
		var bi = b[int(float(i) / length * b.size())]
		total_dist += ai.distance_to(bi)

	return total_dist
	
func rune_int(rune):
	if rune == 1:
		return "Rune Of Flame"
	elif rune == 2:
		return "Rune Of Lightning"
	elif rune == 3:
		return "Rune Of motion"
	elif rune == 4:
		return "Rune Of Shift"
	elif rune == 5:
		return "Rune Of stone"
	elif rune == 6:
		return "Rune Of Weave" 
	
