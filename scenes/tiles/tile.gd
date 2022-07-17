extends Spatial

onready var mesh = $mesh
onready var sprite = $sprite

func into_tile():
	mesh.visible = true
	sprite.visible = false

func _ready():
	mesh.visible = false
	sprite.visible = true
