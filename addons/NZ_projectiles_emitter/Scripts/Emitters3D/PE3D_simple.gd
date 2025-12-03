class_name PE3D_simple
extends Projectile_emitter3D_base

@export var projectile_scene : PackedScene
## If add_child_to_this_node is null, than projectile_instance will be added as child to this node (PE2D_simple)

func emit(type:int=0) -> void:
	var projectile_instance : Projectile3D = projectile_scene.instantiate()
	_add_projectile_instance_to_the_scene(projectile_instance,type)
	
