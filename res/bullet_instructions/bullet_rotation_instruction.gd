class_name RotationInstruction
extends NodeInstruction

@export var degree: float

func _effect():
    node.rotation = deg_to_rad(degree)
