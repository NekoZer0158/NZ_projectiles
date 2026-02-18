@icon("res://addons/NZ_projectiles/Icons/Remove_projectile/Multiple.svg")
class_name RP_multiple
extends Remove_projectile

## Activates other Remove_projectile resources when removing itself

@export var RP_resources : Array[Remove_projectile]
@export var push_error_if_resource_is_null : bool = true

func _remove_projectile_step_2(projectile:Node) -> void:
	for i in RP_resources:
		if i != null:
			i._remove_projectile_step_2(projectile)
		elif push_error_if_resource_is_null:
			push_error("resource is null")
	check_particle_resource(projectile)
