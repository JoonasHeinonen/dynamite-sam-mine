extends KinematicBody

export var speed : float  	= 0

onready var interact_radius = $InteractRadius

# In-game player-specific variables
var player_lamp_oil : float = 10.0
var player_health : float 	= 10.0
var player_inv : Array		= []
var player_start : bool 	= true

var velocity 			  	= Vector3(0, 0, 0)
var interactables : Array 	= []

# Called when the node enters the scene tree for the first time.
func _ready():
	interactables = interact_radius.interactables

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
