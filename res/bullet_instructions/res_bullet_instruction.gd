class_name BulletInstruction
extends Resource

var bullet: Bullet
var wait: bool

func _register(b: Bullet):
    bullet = b
    register()

func register():
    pass

func _effect():
    return effect()

func effect():
    pass
