extends Node

var score : int = 0
var player_name : String
var last_scene_path : String
var difficulty : int = 1
var triple_shot : bool = false

# Sounds volume
var master_volume : int = 5
var music_volume : int = 5
var sfx_volume : int = 5

func _ready():
    SilentWolf.configure({
        "api_key": "",
        "game_id": "asteroids",
        "log_level": 0
    })

    SilentWolf.configure_scores({
        "open_scene_on_close": "res://Scenes/menu.tscn"
    })
