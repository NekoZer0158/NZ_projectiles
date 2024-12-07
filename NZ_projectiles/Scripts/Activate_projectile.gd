extends Button

@export var projectile : Projectile

func _on_pressed() -> void:
	if !projectile.activated:
		projectile.activated = true
		text = "Deactivate"
	else:
		projectile.activated = false
		text = "Activate"
