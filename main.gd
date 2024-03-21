extends Node2D

const BULLET = preload("res://bullet.tscn")

@export var spawner: BulletSpawner

func _process(delta):
    if Input.is_action_just_pressed("LMB"):
        spawner.trigger()
