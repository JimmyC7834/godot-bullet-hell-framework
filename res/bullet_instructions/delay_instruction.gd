class_name DelayInstruction
extends BulletInstruction

@export var time: float

func _effect():
    return bullet.get_tree().create_timer(time).timeout
