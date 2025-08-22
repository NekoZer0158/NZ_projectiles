# NZ projectiles
Plugin for Godot that adds a projectile system. There are two projectile classes, base one and extended, to which you can add more stuff, like changing speed every second or making it disappear only after interacting with 3 objects.

## Changelog

### 1.18
	Sandbox scene - in it you can test projectiles much better, than in other scenes, included in this plugin.
	Added short documentations in English and Russian languages. (z_EN_documentation for English documentation, z_RU_documentation for Russian documentation).
	More variables and functions explained in scripts.
	Fixed RP_spawn_projectile.
	Renamed "Resources" to "Modules (Resources)" in Projectile_extended
### 1.17
	New scene, where you can look at different variants of using HE_more_variables.
	Added remove_when_ignore_and_try_to_hit_anything to Projectile, which ignores any other remove_when and just tries to hit whatever it is.
	You can use up to 5 variables in HE_more_variables if call_function_with_array is set to false.
	You can put however many variables you want in HE_more_variables if call_function_with_array is set to true.
	Some experimentations in Move_to_node2D_projectile (they are commented).
### 1.16
	Added changelog
	Changed function name from chech_if_resource_has_ready_method to check_if_resource_has_ready_method.
	Removed set(value) for min_value and max_value in AC_random_range, because it didn't work if min_value was greater than 0.
	set_direction in ProjectileSetter stopped making errors every time it's used.

## Projectile
![Gif_1](/NZ_projectiles/gifs/gif_1.gif)

## Extended projectile
You can set a resource to change projectiles speed, atk, movement, hit arguments and removal logic.

### Speed
![Gif_2](/NZ_projectiles/gifs/gif_2.gif)

### Movement
![Gif_3](/NZ_projectiles/gifs/gif_3.gif)

### Removal
![Gif_4](/NZ_projectiles/gifs/gif_4.gif)

### Combined
![Gif_5](/NZ_projectiles/gifs/gif_5.gif)
