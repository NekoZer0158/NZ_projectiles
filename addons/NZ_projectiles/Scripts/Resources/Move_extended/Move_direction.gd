@tool
@icon("res://addons/NZ_projectiles/Icons/Move_extended/Direction.svg")
class_name Move_direction_projectile
extends Move_extended_projectile

## Moves projectile in the direction

@export var direction : Vector2: ## If you need to set this through code, use PorjectileSetter
	set(value):
		direction = Vector2(clamp(value.x,-1,1),clamp(value.y,-1,1))
@export var look_at_this_direction : bool = false
@export_range(-360,360,0.5,"suffix:°") var add_this_degrees : float = 0

var added_degrees : bool = false

func move_extended(projectile:Projectile,delta:float) -> void:
	if look_at_this_direction:
		projectile.look_at(projectile.global_position+direction)
		look_at_this_direction = false
	if !added_degrees:
		if add_this_degrees != 0:
			projectile.rotation_degrees += add_this_degrees
		added_degrees = true
	projectile.position += direction*projectile.speed*delta
