extends AudioStreamPlayer

var songs = []
var current = -1

func _ready():
	songs.append(load("res://assets/sounds/music/chosic-calm-and-peaceful.ogg"))
	songs.append(load("res://assets/sounds/music/chosic-downtown-glow.ogg"))
	songs.append(load("res://assets/sounds/music/chosic-glow.ogg"))
	songs.append(load("res://assets/sounds/music/chosic-spring-flowers.ogg"))
	songs.append(load("res://assets/sounds/music/chosic-warm-memories.ogg"))
	songs.append(load("res://assets/sounds/music/musopen-air-on-the-g-string.ogg"))
	current = randi() % len(songs)
	stream = songs[current]
	play()

func _on_MusicPlayer_finished():
	var new_current = current
	while new_current == current:
		new_current = randi() % len(songs)
	
	stream = songs[current]
	play()
