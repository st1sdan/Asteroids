class_name Upgrade
extends Node2D

@onready var time_stop_timer = $TimeStopTimer

#func _process(delta):
    #if $TripleShotTimer.time_left != 0:
        #printt($TripleShotTimer.time_left)


func _ready():
    var life_timer = get_tree().create_timer(5)
    await life_timer.timeout
    if !hidden:
        die()


func _on_area_2d_area_entered(area):
    if area.name == "CollisionPlayer" and $AnimatedSprite2D.get_animation() == "time_stop" and Globals.triple_shot == false and get_tree().paused == false:
        get_tree().paused = true
        $TimeStopTimer.start()
        hide()
        $Area2D.hide()
    if area.name == "CollisionPlayer" and $AnimatedSprite2D.get_animation() == "triple_shot" and Globals.triple_shot == false and get_tree().paused == false:
        $TripleShotTimer.start()
        Globals.triple_shot = true
        hide()
        $Area2D.hide()


func _on_time_stop_timer_timeout():
    get_tree().paused = false
    queue_free()


func _on_triple_shot_timer_timeout():
    Globals.triple_shot = false
    queue_free()


func die():
    queue_free()
