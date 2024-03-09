class_name Enemy
extends RigidBody2D

enum asteroid_size {
    LARGE,
    MEDIUM,
    SMALL
}

var mob_scale
var hitpoint : int = 1
var collision_scale
var size
var _explosion_count : int
var shatter_amount : int = 2
@onready var upgrade_scene = preload("res://Scenes/upgrades.tscn")
@onready var audio_player : AudioStreamPlayer = $"../../../Audio/EnemyExplosion"

func _init():
    collision_scale = Vector2(0.1, 0.1)
    match Globals.difficulty:
        0:
            _explosion_count = 1
            shatter_amount = 0
            if size == null:
                size = asteroid_size.SMALL
        1:
            _explosion_count = 2
            shatter_amount = 1
            if size == null:
                size = asteroid_size.MEDIUM
        2:
            _explosion_count = 3
            shatter_amount = 2
            if size == null:
                size = asteroid_size.LARGE
    update_size()
    scale = mob_scale


func _physics_process(_delta):
    update_size()
    scale = mob_scale
    $RigidbodyCollision.scale = collision_scale


func take_damage(amount: int):
    hitpoint -= amount
    if hitpoint <= 0:
        spawn_random_upgrade()
        if size == asteroid_size.LARGE:
            Globals.score += 1
            explode(0)
            hitpoint = 1
        elif size == asteroid_size.MEDIUM:
            Globals.score += 2
            explode(1)
            hitpoint = 1
        else:
            Globals.score += 3
            $CPUParticles2D.emitting = true
            $Rock.hide()
            $Trail.hide()

    update_size()


func _on_cpu_particles_2d_finished():
    queue_free()


func update_size():
    match size:
        asteroid_size.LARGE:
            mob_scale = Vector2(5, 5)
        asteroid_size.MEDIUM:
            mob_scale = Vector2(3.5, 3.5)
        asteroid_size.SMALL:
            mob_scale = Vector2(2, 2)


func explode(current_size : int):
    var explosion_count = _explosion_count
    audio_player.pitch_scale = randf_range(0.8, 1.3)
    audio_player.playing = true
    queue_free()
    if current_size == 0:
        for i in range(explosion_count):
            var new_asteroid = duplicate()
            new_asteroid.size = asteroid_size.MEDIUM
            new_asteroid.global_position = global_position + Vector2(randf_range(-25, 25), randf_range(-25, 25))
            new_asteroid.shatter_amount = 1
            new_asteroid.linear_velocity = Vector2(randf_range(-175, 175), randf_range(-175, 175))
            get_parent().add_child(new_asteroid)
    elif current_size == 1:
        for i in range(explosion_count):
            var new_asteroid = duplicate()
            new_asteroid.size = asteroid_size.SMALL
            new_asteroid.global_position = global_position + Vector2(randf_range(-25, 25), randf_range(-25, 25))
            new_asteroid.shatter_amount = 0
            new_asteroid.linear_velocity = Vector2(randf_range(-175, 175), randf_range(-175, 175))
            get_parent().add_child(new_asteroid)


func _on_visible_on_screen_notifier_2d_screen_exited():
    queue_free()


func spawn_random_upgrade():
    var random_drop_chance = randf_range(0,100)
    var random_upgrade_spawn = randf_range(0,100)
    if int(random_drop_chance) <= 10:
        var upg = upgrade_scene.instantiate()
        upg.global_position = global_position
        var rand_upg = upg.find_child("AnimatedSprite2D")
        if random_upgrade_spawn <= 50:
            rand_upg.play("time_stop")
        else:
            rand_upg.play("triple_shot")
        get_parent().add_child(upg)
