## Base class for instrcution for bullet behaviour
class_name BulletInstruction
extends Node

## The bullet this instruction should act on
var bullet: Node2D

func register(b: Node2D):
    bullet = b
    _init()

## Called after this intruction is registered
## Similar to _init() of Node
func _init():
    pass

func effect():
    return _effect()

## Called when effect is executed
## This method should returns a signal if this instruction is
## meant to be awaited before executing the next instruction
func _effect():
    pass
