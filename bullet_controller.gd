## Takes in instructions and execute them on the [param subject]
class_name BulletController
extends Node2D

@export_group("Bullet Properties")
## Velocity of the bullet, will be rotated to [param direction]
@export var velocity: Vector2

## Direction of the bullet
@export var direction_degree: int

## The angular velocity of the bullet
@export var alpha: float

var instructions: Array[BulletInstruction] = []

func _ready():
    var children = get_children()
    while not children.is_empty():
        var c = children.pop_front()
        if c is BulletInstruction:
            c.register(self)
            instructions.append(c)
        children.append_array(c.get_children())

    execute_instruction_batch()

func _process(delta):
    global_position += velocity.rotated(direction_degree) * delta
    rotate(alpha * delta)

func execute_instruction_batch():
    var i: BulletInstruction = instructions.pop_front()

    while i != null:
        await i.effect()
        i = instructions.pop_front()

    if i == null:
        return
