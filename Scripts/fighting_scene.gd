extends Node2D

var particle = preload("res://Scenes/particle_attack_ring.tscn")
var is_in_circle = false
var particle_placements = []


func _process(_delta: float) -> void:
	# inherits from circle
	is_in_circle = $circle.is_in_circle
	# checks for left click
	var place_particle = Input.is_action_pressed("Place_particle")
	
	if place_particle and is_in_circle:
		Note_cords()
		make_particle()
	
	var print_cords = Input.is_action_just_pressed("show_cords_of_path")
	if print_cords:
		print_cords_func()

func make_particle():
		var mouse_pos = get_global_mouse_position()
		var scene = particle.instantiate()
		add_child(scene)
		scene.global_position = mouse_pos

func Note_cords():
	
	var mouse_pos = get_global_mouse_position()
	particle_placements.append(mouse_pos)
	
func print_cords_func():
	var file = FileAccess.open("res://Rune Paths/Rune Of motion(telekenesis).txt", FileAccess.WRITE)
	for coord in particle_placements:
		file.store_line(str(coord.x) + "," + str(coord.y))
	file.close()
	print("updated file")
