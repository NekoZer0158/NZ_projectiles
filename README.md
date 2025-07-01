# NZ projectiles
Plugin for Godot that adds a projectile system. There are two projectile classes, base one and extended, to which you can add more stuff, like changing speed every second or making it disappear only after interacting with 3 objects.

## Changelog
### 1.16
	Added changelog
	Changed function name from chech_if_resource_has_ready_method to check_if_resource_has_ready_method
	Removed set(value) for min_value and max_value in AC_random_range, because it didn't work if min_value was greater than 0
	set_direction in ProjectileSetter stopped making errors every time it's used

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
