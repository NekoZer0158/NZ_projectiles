@tool
@icon("res://addons/NZ_projectiles/Icons/Remove_projectile/Spawn_projectile.svg")
class_name RP_spawn_projectile
extends Remove_projectile

@export var spawn_this_projectile : PackedScene
@export var same_scale : bool = true
@export var immortality_seconds : float = 0.25:
	set(value):
		immortality_seconds = clamp(value,0,abs(value))

var me : RP_spawn_projectile

func remove_projectile(projectile:Projectile) -> void:
	if spawn_this_projectile != null:
		var spawn_this : Node2D = spawn_this_projectile.instantiate()
		var tree_node : SceneTree
		spawn_this.position = projectile.position
		if immortality_seconds > 0 and spawn_this is Area2D:
			spawn_this.monitoring = false
		if same_scale:
			spawn_this.scale = projectile.scale
		projectile.call_deferred("add_sibling",spawn_this)
		if immortality_seconds > 0 and spawn_this is Area2D:
			tree_node = projectile.get_tree()
			me = self
		check_particle_resource(projectile)
		projectile.queue_free()
		if immortality_seconds > 0 and spawn_this is Area2D:
			await tree_node.create_timer(immortality_seconds,false).timeout
			spawn_this.monitoring = true
			me = null
	else:
		push_error("No spawn_this_projectile")
