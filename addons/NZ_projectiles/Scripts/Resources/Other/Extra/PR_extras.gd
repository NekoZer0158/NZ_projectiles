@icon("res://addons/NZ_projectiles/Icons/Other/Extra/PR_extras.svg")
class_name PR_extras
extends Projectile_resource_extra

@export var extras : Array[Projectile_resource_extra]

func use_extra() -> void:
	for i in extras:
		i.projectile = projectile
		i.use_extra()
