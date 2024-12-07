@tool
@icon("res://addons/NZ_projectiles/Icons/Speed_change/Speed_change.svg")
class_name Speed_change_projectile
extends Resource

func change_speed(projectile_speed:int) -> int:
	return projectile_speed

func activate() -> void:
	pass
