extends RigidBody

export var items : int

# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_meta("type", "interactable")
	self.set_meta("name", "interactable")
