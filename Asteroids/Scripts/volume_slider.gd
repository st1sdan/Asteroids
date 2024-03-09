extends HSlider

@export
var bus_name : String

var bus_index : int

func _ready():
    value = Globals.master_volume
    _on_value_changed(Globals.master_volume)
    bus_index = AudioServer.get_bus_index(bus_name)
    value_changed.connect(_on_value_changed)


func _on_value_changed(value : float)  -> void:
    AudioServer.set_bus_volume_db(
        bus_index,
        linear_to_db(value/10)
    )
    Globals.master_volume = value
