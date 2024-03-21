class_name BulletRotationInstruction
extends BulletInstruction

@export var degree: float

func _effect():
    bullet.rotation = deg_to_rad(degree)
