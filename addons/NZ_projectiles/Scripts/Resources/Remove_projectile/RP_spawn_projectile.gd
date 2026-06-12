@tool
@icon("res://addons/NZ_projectiles/Icons/Remove_projectile/Spawn_projectile.svg")
class_name RP_spawn_projectile
extends Remove_projectile

## Spawns another projectile when removing itself. The new projectile will be added as a sibling to the current projectile

@export var spawn_this_projectile : PackedScene
@export var same_scale : bool = true
@export var immortality_seconds : float = 0.25: ## spawn_this_projectile should be [Area2D] or any of its subclasses
	set(value):
		immortality_seconds = clampf(value,0,abs(value))
@export var remove_this_projectile : bool = true
@export var add_to_position : Vector3 ## When adding to [Projectile], z will be ignored
@export var extra_resource_for_spawned_projectile : Projectile_resource_extra

var me : RP_spawn_projectile ## @deprecated

func _use_extra_resource_for_spawned_projectile(spawned_node:Node) -> void:
	if extra_resource_for_spawned_projectile != null and (spawned_node is Projectile or spawned_node is Projectile3D):
		extra_resource_for_spawned_projectile.use_extra(spawned_node)

func _remove_projectile_step_2(projectile:Node) -> void:
	if spawn_this_projectile != null:
		var resource_itself := self
		var spawned_node = spawn_this_projectile.instantiate()
		var tree_node : SceneTree
		if spawned_node is Projectile:
			spawned_node.position = projectile.position+Vector2(add_to_position.x,add_to_position.y)
		elif spawned_node is Projectile3D:
			spawned_node.position = projectile.global_position+add_to_position
		if immortality_seconds > 0 and spawned_node is Area2D:
			spawned_node.monitoring = false
		if same_scale:
			spawned_node.scale = projectile.scale
		projectile.call_deferred(&"add_sibling",spawned_node)
		_use_extra_resource_for_spawned_projectile(spawned_node)
		if immortality_seconds > 0 and spawned_node is Area2D:
			tree_node = projectile.get_tree()
		check_particle_resource(projectile)
		if remove_this_projectile:
			projectile.queue_free()
		if immortality_seconds > 0 and spawned_node is Area2D:
			await tree_node.create_timer(immortality_seconds,false).timeout
			if is_instance_valid(spawned_node):
				spawned_node.monitoring = true
		resource_itself = null
	else:
		push_error("No spawn_this_projectile")
