extends Area

export var interactables = []

var interactables_length = null

func _process(delta):
	interactables_length = interactables.size()

func _on_InteractRadius_body_entered(body):
	# Detects if the body has the meta of type 'interactable'.
	if (body.has_meta("type") && body.get_meta("type") == "interactable"):
		interactables.insert(interactables_length, body)

func _on_InteractRadius_body_exited(body):
	# Detects if the body has the meta of type 'interactable'.
	if ( body.has_meta("type") && body.get_meta("type") == "interactable"):
		interactables.erase(body)
