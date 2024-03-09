extends Node

func _ready():
    Globals.last_scene_path = "res://Scenes/main.tscn"
    Globals.triple_shot = false
    Globals.score = 0
    get_tree().paused = false


func _process(delta):
    if Input.is_action_just_pressed("pause"):
        _on_menu_button_pressed()


func _on_menu_button_pressed():
    $Audio/Click.playing = true
    ## Пауза при нажатии кнопки
    match get_tree().paused:
        true:
            var pause_timer = get_tree().create_timer(0.2)
            await pause_timer.timeout
            get_tree().paused = false
        false:
            get_tree().paused = true
            get_tree().change_scene_to_file("res://Scenes/options.tscn")


func _on_back_ground_music_finished():
    $Audio/BackGroundMusic.playing
