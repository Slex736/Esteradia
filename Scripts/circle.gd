extends Area2D

var is_in_circle = false

func _on_mouse_entered() -> void:
	is_in_circle = true


func _on_mouse_exited() -> void:
	is_in_circle = false
