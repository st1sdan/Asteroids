extends RigidBody2D

var mob_scale
var hitpoint : int = 10
var collision_scale
@export var shatter_amount : int = 2

func _init():
    mob_scale = Vector2(randf_range(4, 7), randf_range(4, 7))
    collision_scale = Vector2(0.1, 0.1)


func _physics_process(_delta):
    scale = mob_scale
    $RigidbodyCollision.scale = collision_scale


func take_damage(amount: int):
    hitpoint -= amount

    if hitpoint <= 0 and shatter_amount == 0:
        $CPUParticles2D.emitting = true
        $Rock.hide()
        $Trail.hide()


func _on_cpu_particles_2d_finished():
    queue_free()
