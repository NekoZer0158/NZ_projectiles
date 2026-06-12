extends Node

@export var projectiles : Dictionary[String,PackedScene]

var default_projectile_use_amount : int = 5

func get_this_projectile(projectile_id:String) -> Projectile:
	if projectiles.has(projectile_id):
		if default_projectile_use_amount > 0 and projectile_id == "default":
			default_projectile_use_amount -= 1
			return projectiles[projectile_id].instantiate()
		elif projectiles.has("2"):
			return projectiles["2"].instantiate()
	return null
