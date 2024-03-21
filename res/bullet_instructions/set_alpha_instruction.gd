class_name SetAlphaInstruction
extends BulletInstruction

@export var d_degree: float

func _effect():
    bullet.alpha = deg_to_rad(d_degree)
