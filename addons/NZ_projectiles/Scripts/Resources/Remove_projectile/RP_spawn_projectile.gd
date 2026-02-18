@tool
@icon("res://addons/NZ_projectiles/Icons/Remove_projectile/Spawn_projectile.svg")
class_name RP_spawn_projectile
extends Remove_projectile

## Spawns another projectile when removing itself

@export var spawn_this_projectile : PackedScene
@export var same_scale : bool = true
@export var immortality_seconds : float = 0.25:
	set(value):
		immortality_seconds = clamp(value,0,abs(value))
@export var remove_this_projectile : bool = true

var me : RP_spawn_projectile

func _remove_projectile_step_2(projectile:Node) -> void:
	if spawn_this_projectile != null:
		var resource_itself := self
		var spawn_this = spawn_this_projectile.instantiate()
		var tree_node : SceneTree
		if spawn_this is Projectile:
			spawn_this.position = projectile.position
		elif spawn_this is Projectile3D:
			spawn_this.transform = projectile.transform
		if immortality_seconds > 0 and spawn_this is Area2D:
			spawn_this.monitoring = false
		if same_scale:
			spawn_this.scale = projectile.scale
		projectile.call_deferred(&"add_sibling",spawn_this)
		if immortality_seconds > 0 and spawn_this is Area2D:
			tree_node = projectile.get_tree()
		check_particle_resource(projectile)
		if remove_this_projectile:
			projectile.queue_free()
		if immortality_seconds > 0 and spawn_this is Area2D:
			await tree_node.create_timer(immortality_seconds,false).timeout
			if is_instance_valid(spawn_this):
				spawn_this.monitoring = true
		resource_itself = null
	else:
		push_error("No spawn_this_projectile")
