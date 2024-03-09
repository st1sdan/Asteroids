extends CPUParticles2D

@onready var player = $".."
var max_velocity : int = 55

func _ready():
    hide()

func _physics_process(_delta):
    if player.velocity != Vector2.ZERO:
        max_velocity = move_toward(max_velocity, 55, 5)
        initial_velocity_max = max_velocity
        show()
    else:
        max_velocity = move_toward(max_velocity, 0, 1)
        initial_velocity_max = max_velocity
        if initial_velocity_max <= 1:
            hide()
    gravity = -Vector2(0, 1).rotated(rotation) * 100
