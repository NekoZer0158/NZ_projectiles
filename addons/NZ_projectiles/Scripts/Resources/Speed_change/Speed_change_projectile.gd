@tool
@abstract
@icon("res://addons/NZ_projectiles/Icons/Speed_change/Speed_change.svg")
class_name Speed_change_projectile
extends Projectile_resource

func change_speed(projectile_speed:int) -> int:
	return projectile_speed

## Can be used, for example, to activate a timer
func activate() -> void:
	pass
