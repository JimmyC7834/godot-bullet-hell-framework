## Takes in instructions and execute them on the [param subject]
class_name Bullet
extends Node2D

## The Node the instructions is executed on
@export var subject: Node2D = self

@export_group("Bullet Properties")
## Velocity of the bullet, will be rotated to [param direction]
@export var velocity: Vector2

## Direction of the bullet
@export var direction_degree: int

## The angular velocity of the bullet
@export var alpha: float

@export_group("Bullet Behaviour")
## Instructions of the bullet's behaviour
@export var instructions: Array[BulletInstruction] = []

func _ready():
    instructions = instructions.duplicate()
    for i in range(instructions.size()):
        instructions[i] = instructions[i].duplicate()
        instructions[i].register(subject)

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
