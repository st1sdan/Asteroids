extends SubViewport

@export var mob_scene: PackedScene
@export var max_asteroid_velocity : float = 175.0
@onready var asteroids = $Enemy
@onready var score_label = $"../../UI/Score"

func _process(delta):
    score_update()


func _on_mob_timer_timeout():
    var mob = mob_scene.instantiate()

    var mob_spawn_location = $MobPath/MobSpawnLocation
    mob_spawn_location.progress_ratio = randf()

    var direction = mob_spawn_location.rotation + PI/2

    mob.position = mob_spawn_location.position

    direction += randf_range(-PI/4, PI/4)
    mob.rotation = direction

    var velocity = Vector2(randf_range(max_asteroid_velocity - 100, max_asteroid_velocity), 0.0)
    mob.linear_velocity = velocity.rotated(direction)
    mob.get_child(2).gravity = velocity

    add_child(mob)


func score_update():
    score_label.text = "%s" % Globals.score
