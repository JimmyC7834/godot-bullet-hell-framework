extends Node2D

const DIFFUSION_REGULAR = preload("res://diffusion-regular.ttf")

@export var spawner: CustomSpawner

func _process(delta):
    if Input.is_action_just_pressed("LMB"):
        #spawner.trigger()
        for i in range(500):
            Bullets.spawn_bullet(spawner.position, Vector2.RIGHT, 100)
    #spawner.rotate(PI / 4 * delta)
    queue_redraw()

func _draw():
    draw_string(DIFFUSION_REGULAR, Vector2(50, 25), str(Engine.get_frames_per_second()))
    draw_string(DIFFUSION_REGULAR, Vector2(50, 50), str(Bullets.bullets.size()))
    #draw_string(DIFFUSION_REGULAR, Vector2(50, 50), str(BulletController.bullet_count))
