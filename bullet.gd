class_name Bullet
extends Node2D

@export var instructions: Array[BulletInstruction] = []

var velocity: Vector2
var alpha: float

func _ready():
    instructions = instructions.duplicate()
    for i in range(instructions.size()):
        instructions[i] = instructions[i].duplicate()
        instructions[i]._register(self)

    next_modifiers()

func _process(delta):
    global_position += velocity * delta
    rotate(alpha * delta)

func next_modifiers():
    var i: BulletInstruction = instructions.pop_front()

    while i != null:
        await i.effect()
        i = instructions.pop_front()

    if i == null:
        return
