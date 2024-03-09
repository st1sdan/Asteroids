extends Control

@onready var over : RichTextLabel = $RichTextLabel
var speed = 10

func _ready():
    $Label.text = "SCORE %s" % Globals.score
    $LineEdit.grab_focus()


func _process(delta):
    move_game_over(delta)
    if $LineEdit.text == "":
        $Confirm.disabled = true
    else:
        Globals.player_name = $LineEdit.text
        $Confirm.disabled = false


func move_game_over(delta):
    var current_x = over.position.x
    var new_x = current_x + speed * delta

    if new_x < 118:
        new_x = 118
        speed = -speed
    elif new_x > 148:
        new_x = 148
        speed = -speed

    over.position.x = new_x


func _on_confirm_pressed():
    SilentWolf.Scores.save_score(Globals.player_name, Globals.score)
    Globals.score = 0
    get_tree().change_scene_to_file("res://Scenes/menu.tscn")


func _on_restart_pressed():
    Globals.score = 0
    get_tree().change_scene_to_file("res://Scenes/main.tscn")
