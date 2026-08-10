@icon("res://addons/NZ_projectiles/Icons/Move_extended/Direction.svg")
class_name ME_direction
extends Move_extended_projectile_node

## Moves projectile in the direction

@export var direction : Vector2: ## If you need to set this through code, use PorjectileSetter
	set(value):
		direction = Vector2(clampf(value.x,-1.0,1.0),clampf(value.y,-1.0,1.0))
@export var look_at_this_direction : bool = false
@export_range(-360,360,0.01,"suffix:°") var add_degrees : float = 0

var added_degrees : bool = false

func move_extended(projectile:Projectile,delta:float) -> void:
	if look_at_this_direction:
		projectile.look_at(projectile.global_position+direction)
		look_at_this_direction = false
	if !added_degrees:
		if add_degrees != 0:
			projectile.rotation_degrees += add_degrees
		added_degrees = true
	projectile.position += direction*projectile.speed*delta
