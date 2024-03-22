## Takes in instructions and execute them on the [param subject]
class_name BulletController
extends Node2D

const FORWARD: Vector2 = Vector2.RIGHT

@export_group("Bullet Properties")
## Velocity of the bullet, will be rotated to [param direction]
@export var speed: float

## Direction of the bullet
@export var direction_degree: float

## The angular velocity of the bullet
@export var alpha: float

## If set to [param true], the bullet will set its rotation and direction to the parent's
@export var reset_direction: bool

var instructions: Array[BulletInstruction] = []

func _ready():
    # grab and register instructions
    var children = get_children()
    while not children.is_empty():
        var c = children.pop_front()
        if c is BulletInstruction:
            c.register(self)
            instructions.append(c)
        children.append_array(c.get_children())

    # inherit_rotation
    if reset_direction:
        global_rotation = 0

    direction_degree = global_rotation_degrees

    execute_instruction_batch()

func _process(delta):
    global_position += FORWARD.rotated(deg_to_rad(direction_degree)) * speed * delta
    rotate(alpha * delta)

func execute_instruction_batch():
    var i: BulletInstruction = instructions.pop_front()

    while i != null:
        await i.effect()
        i = instructions.pop_front()

    if i == null:
        return
