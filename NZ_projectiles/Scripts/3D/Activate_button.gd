extends Button

@export var projectile : Projectile3D

func _ready() -> void:
	if !is_instance_valid(projectile):
		push_error("No projectile")
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	if is_instance_valid(projectile):
		projectile.activated = !projectile.activated
		if projectile.activated:
			text = "Deactivate"
		else:
			text = "Activate"
