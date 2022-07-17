extends Control

signal tile_chosen

func _ready():
	pass

func _on_button1_press():
	emit_signal("tile_chosen", 0)

func _on_button2_press():
	emit_signal("tile_chosen", 1)

func _on_button3_press():
	emit_signal("tile_chosen", 2)
