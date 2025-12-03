extends Projectile_resource

@export var speed : int

func give_speed_to_projectile(projectile:Node) -> void:
	projectile.speed = speed
