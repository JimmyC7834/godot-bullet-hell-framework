## Takes in instructions and execute them on the [param subject]
class_name BulletController
extends Node2D

const BULLET_HITBOX = preload("res://examples/bullets/bullet_hitbox.tres")

## The default forward direction of bullet
const FORWARD: Vector2 = Vector2.DOWN

static var shared_area: RID
static var bullet_count: int = 0

@export var bullet_texture: Texture2D

@export_group("Bullet Properties")
## Velocity of the bullet, will be rotated to [param direction]
@export var speed: float

## Direction of the bullet
@export var direction_degree: float

## The angular velocity of the bullet
@export var alpha: float

## If set to [param true], the bullet reset its rotation and direction at spawn
@export var reset_direction: bool

var instructions: Array[NodeInstruction] = []

var p_rid: RID
var r_rid: RID
var id: int

func _enter_tree():
    id = bullet_count
    bullet_count += 1

func _exit_tree():
    bullet_count -= 1

#func _init():
    #if !shared_area.is_valid():
        #new_share_area()

func _ready():

    # grab and register instructions
    var children = get_children()
    while not children.is_empty():
        var c = children.pop_front()
        if c is NodeInstruction:
            c.register(self)
            instructions.append(c)
        children.append_array(c.get_children())

    # inherit_rotation
    if reset_direction:
        global_rotation = 0
    else:
        direction_degree = rad_to_deg(FORWARD.angle_to(Vector2.RIGHT) + global_rotation)

    #r_rid = RenderingServer.canvas_item_create()
    #RenderingServer.canvas_item_set_parent(r_rid, get_canvas_item())
#
    ## Add it, centered.
    #RenderingServer.canvas_item_add_texture_rect(r_rid, 
        #Rect2(bullet_texture.get_size() / 2, bullet_texture.get_size()), bullet_texture)
    #
    ## Add the item, rotated 45 degrees and translated.
    #var xform = Transform2D().scaled(Vector2(.25, .25))
    #RenderingServer.canvas_item_set_transform(r_rid, xform)

    #PhysicsServer2D.area_add_shape(shared_area, BULLET_HITBOX.get_rid(), transform)

    execute_instruction_batch()

func _process(delta):
    global_position += FORWARD.rotated(deg_to_rad(direction_degree)) * speed * delta
    rotate(alpha * delta)

#func _physics_process(delta):
    #PhysicsServer2D.area_set_shape_transform(shared_area, id, transform)
    #transform = PhysicsServer2D.area_get_shape_transform(shared_area, id)

#func new_share_area():
    #shared_area = PhysicsServer2D.area_create()
    #PhysicsServer2D.area_set_collision_mask(shared_area, 1)
    #PhysicsServer2D.area_set_collision_layer(shared_area, 1)
    #PhysicsServer2D.area_set_monitorable(shared_area, true)
    #PhysicsServer2D.area_set_area_monitor_callback(shared_area,
        #func(_1, _2, _3, _4, _5):
            #set_process(false)
            #hide())

func execute_instruction_batch():
    var i: NodeInstruction = instructions.pop_front()

    while i != null:
        await i.effect()
        i = instructions.pop_front()

    if i == null:
        return

class TestInstruction:
    @export var speed: int
