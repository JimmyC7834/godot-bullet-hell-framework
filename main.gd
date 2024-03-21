extends Node2D

const BULLET = preload("res://bullet.tscn")

func _process(delta):
    if Input.is_action_just_pressed("LMB"):
        var b = BULLET.instantiate()
        add_child(b)
        b.global_position = get_global_mouse_position()
