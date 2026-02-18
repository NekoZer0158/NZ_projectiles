@icon("res://addons/NZ_projectiles/Icons/Remove_projectile/Other.svg")
class_name RP_other
extends Remove_projectile

## Calls other_function_name in a projectile_resource and then removes itself using queue_free()

@export var other_function_name : String
@export var projectile_resource : Projectile_resource
@export var remove_this_projectile : bool = true

func _remove_projectile_step_2(projectile:Node) -> void:
	projectile_resource.call(other_function_name,projectile)
	check_particle_resource(projectile)
	if remove_this_projectile:
		projectile.queue_free()
