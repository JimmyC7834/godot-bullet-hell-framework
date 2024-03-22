class_name DelayInstruction
extends NodeInstruction

@export var time: float

func _effect():
    return node.get_tree().create_timer(time).timeout
