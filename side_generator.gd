extends Node

var ps_side = preload("res://scenes/dice/side.tscn")
var all_types = ["factory", "house", "tree", "water"]
var sprites_directory = "res://assets/sprites/"

func get_texture_files(name: String):
	var files = []
	var dir = Directory.new()
	dir.open(sprites_directory)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif file.begins_with(name):
			files.append(file)

	dir.list_dir_end()

	return files

func create_side(types):
	var side = ps_side.instance()
	for i in range(4):
		var type = randi() % len(types)
		var texture_files = get_texture_files(type)
		if len(texture_files) == 0:
			print("No textures for type", types[type])
			continue
		var texture_idx = randi() % len(texture_files)
		side.set_texture(str(i), load(texture_idx))
	return side

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
