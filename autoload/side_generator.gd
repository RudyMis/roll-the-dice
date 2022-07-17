extends Node

var ps_side = preload("res://scenes/dice/side.tscn")
var all_types = ["factory", "house", "field", "shop", "water", "tree_parent"]
var all_dividers = ["road"]
var divider_chance = 0.5
var field_directory = "res://scenes/tiles/"
var divider_directory = "res://scenes/dividers/"

func get_files(directory: String, prefix: String, sufix: String):
	var files = []
	var dir = Directory.new()
	dir.open(directory)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif file.begins_with(prefix) and file.ends_with(sufix):
			files.append(file)

	dir.list_dir_end()
	return files

func create_divider(types = all_dividers):
	if randf() > divider_chance:
		return null
	
	var type = randi() % len(types)
	# FIXME: Give correct path to mesh files
	var divider_files = get_files(divider_directory, types[type], ".tscn")
	if len(divider_files) == 0:
		print("No files for type: ", types[type])
		return null
	var divider_idx = randi() % len(divider_files)
	var ps_divider = load(divider_directory + divider_files[divider_idx])
	if ps_divider and ps_divider.has_method("instance"):
		var divider = ps_divider.instance()
		var direction = randi() % 4
		divider.rotate_y(direction * PI / 2)
		return divider
	return null

func create_side(types = all_types):
	randomize()
	var side = ps_side.instance()
	
	# Fields
	for i in range(4):
		var type = randi() % len(types)
		var field_files = get_files(field_directory, types[type], ".tscn")
		if len(field_files) == 0:
			print("No files for type: ", types[type])
			continue
		var field_idx = randi() % len(field_files)
		var field = load(field_directory + field_files[field_idx]).instance()
		field.type = types[type]
		side.set_field(str(i), field)
	
	var divider = create_divider()
	if divider:
		divider.scale *= Vector3.ONE / side.scale
		side.add_child(divider)
	
	return side

func side_to_tile(side):
	return load("res://scenes/tiles/house.tscn").instance()

func _ready():
	pass # Replace with function body.
