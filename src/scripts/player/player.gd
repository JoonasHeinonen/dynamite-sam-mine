extends KinematicBody

export var speed : float  	= 0

onready var interact_radius = $InteractRadius
onready var lamp_oil_ui 	= $PlayerUI/VBoxContainer/HBoxContainer/LampOil

# In-game player-specific variables
var player_lamp_oil : float = 100.0
var player_health : int 	= 10
var player_start : bool 	= true
var player_game_over : bool = false
var player_inv : Array		= []

# Player logic defining variables
var interactables : Array 	= []
var velocity 			  	= Vector3(0, 0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	interactables = interact_radius.interactables

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (player_start):
		$LampOilTimer.autostart = true
	interactables = interact_radius.interactables
	walk(5,  "x") if (Input.is_action_pressed("ui_right")) else stop_player()
	walk(-5, "x") if (Input.is_action_pressed("ui_left"))  else stop_player()
	walk(5,  "z") if (Input.is_action_pressed("ui_down"))  else stop_player()
	walk(-5, "z") if (Input.is_action_pressed("ui_up"))    else stop_player()
	if (Input.is_action_just_pressed("ui_accept")):
		print(interactables)

	move_and_slide(velocity, Vector3.UP)

# Walking functionality.
func walk(vel : float, axis : String):
	# If the axis matches, move player in that axis.
	match axis:
		"x":
			velocity.x = vel * speed
		"z":
			velocity.z = vel * speed
		_:
			stop_player()

# Stops the player movement.
func stop_player():
	velocity.x = lerp(velocity.x, 0, 0.01)
	velocity.z = lerp(velocity.z, 0, 0.01)

# Decrease the lamp oil value by half second.
func _on_LampOilTimer_timeout():
	player_lamp_oil -= 0.5 if player_lamp_oil > 0 else get_tree().reload_current_scene()
	lamp_oil_ui.value = player_lamp_oil

func _on_LampOil_value_changed(value):
	print(lamp_oil_ui.value)
