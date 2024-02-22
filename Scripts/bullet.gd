extends CharacterBody2D

var life_timer
var screen_size = Vector2(480, 320)


func _physics_process(_delta):
    out_of_bounds()
    move_and_slide()
    die()


## Удалить после 1 секунды существования объекта
func die():
    life_timer = get_tree().create_timer(1, false)
    await life_timer.timeout
    $CPUParticles2D.emitting = true
    $Sprite2D.hide()


func out_of_bounds():
    position = position.posmodv(screen_size)


func _on_cpu_particles_2d_finished():
    queue_free()


func _on_my_hit_box_area_entered(_area):
    queue_free()
