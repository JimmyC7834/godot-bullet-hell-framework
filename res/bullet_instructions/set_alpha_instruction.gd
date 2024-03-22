class_name SetAlphaInstruction
extends NodeInstruction

@export var d_degree: float

func _effect():
    node.alpha = deg_to_rad(d_degree)
