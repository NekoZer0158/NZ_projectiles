# NZ projectiles
Plugin for Godot that adds a projectile system in 2D&3D. There are two projectile classes, base one and extended, to which you can add more stuff, like changing speed every second or making it disappear only after interacting with 3 objects.

## Changelog

### 2.0
	Added 3D support
	Changed ID from int to String.
	Moved ID from Projectile_extended to Projectile
	Changed some functions names to include _ in them, also removed deprecated function
	Removed clamp functions from SC_random_range

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

## 3D movement
![Gif_6](/NZ_projectiles/gifs/gif_6.gif)

## 3D extended
![Gif_7](/NZ_projectiles/gifs/gif_7.gif)
