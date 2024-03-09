extends Control

@onready var difficulty : OptionButton = $VBoxContainer/HBoxContainer/OptionButton

func _ready():
    if Globals.last_scene_path == "res://Scenes/main.tscn":
        difficulty.disabled = true
    $Back.grab_focus()
    difficulty.add_item("EASY", 0)
    difficulty.add_item("NORMAL", 1)
    difficulty.add_item("HARD", 2)
    difficulty.select(Globals.difficulty)


func _on_back_pressed():
    match Globals.last_scene_path:
        "res://Scenes/menu.tscn":
            get_tree().change_scene_to_file("res://Scenes/menu.tscn")
        "res://Scenes/main.tscn":
            get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_option_button_item_selected(index):
    Globals.difficulty = index


func _on_credits__help_pressed():
    get_tree().change_scene_to_file("res://Scenes/help.tscn")
