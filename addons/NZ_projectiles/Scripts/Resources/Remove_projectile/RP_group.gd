@icon("res://addons/NZ_projectiles/Icons/Remove_projectile/RP_group.svg")
class_name RP_group
extends Remove_projectile

## Queue_free/free or activates a remove resource in every projectile in the same group when removing itself

@export var group_name : String
@export_enum("Queue_free","Free","Activate remove resource") var remove_projectiles_from_group_this_way : int
@export_enum("Queue_free","Free","Activate remove resource","Dont") var remove_this_projectile_this_way : int
@export var second_remove_resource : Remove_projectile
@export var debug : bool = false

enum {QUEUE_FREE,FREE,ACTIVATE_REMOVE_RESOURCE,DONT}

func _remove_projectile_step_2(projectile:Node) -> void:
	check_particle_resource(projectile)
	for i in projectile.get_tree().get_nodes_in_group(group_name):
		if i != projectile:
			if debug:
				print(i.name)
			match remove_projectiles_from_group_this_way:
				QUEUE_FREE:
					i.queue_free()
				FREE:
					i.free()
				ACTIVATE_REMOVE_RESOURCE:
					i.remove_projectile()
	match remove_this_projectile_this_way:
		QUEUE_FREE:
			projectile.queue_free()
		FREE:
			projectile.free()
		ACTIVATE_REMOVE_RESOURCE:
			second_remove_resource.remove_projectile(projectile)
		DONT:
			pass
