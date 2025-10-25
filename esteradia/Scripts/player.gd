extends CharacterBody2D

@export var SPEED = 500 


var spelldrawer = preload("res://Scenes/Spell_Drawer.tscn")


func _physics_process(_delta: float) -> void:
	
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * SPEED
	
	var spell_screen = Input.is_action_just_pressed("Enter_Spell_screen")
	if spell_screen:
		get_tree().change_scene_to_packed(spelldrawer)
	
	move_and_slide()
