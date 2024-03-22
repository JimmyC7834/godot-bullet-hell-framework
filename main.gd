extends Node2D

@export var spawner: CustomSpawner

func _process(delta):
    if Input.is_action_just_pressed("LMB"):
        spawner.trigger()

    spawner.rotate(PI / 4 * delta)
