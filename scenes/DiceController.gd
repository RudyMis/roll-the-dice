extends Spatial

signal rolled

onready var dice = $Dice
onready var guard = $DiceGuard
onready var timer = $StopCountdown
onready var lock_timer = $StartLock

var collider = null

# Amount of time to wait after throw.
export var start_lock_time = 0.5

# Amount of time from cube stop to signal delivery.
export var stop_countdown_time = 0.5

var last_pos = translation
var rolling = false
var locked = false

func guard_movement():
	guard.translation = dice.translation
	collider = guard.get_collider()
	var pos = guard.translation
	if collider != null:
		if pos.distance_squared_to(last_pos) < 1e-6:
			if timer.is_stopped():
				timer.start(stop_countdown_time)
		else:
			timer.stop()
	last_pos = pos

func _process(_delta):
	if (rolling):
		guard_movement()

func roll(direction):
	rolling = true
	locked = true
	lock_timer.start(start_lock_time)
	dice.roll(direction)

func _on_StopCountdown_timeout():
	var colliding = 7 - int(collider.get_name()[5])
	print("Thrown: " + String(colliding))
	rolling = false
	timer.stop()
	var side = dice.get_side(str(colliding - 1))
	print(side)
	emit_signal("rolled", side.duplicate())


func _on_StartLock_timeout():
	locked = false
