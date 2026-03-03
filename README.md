![Banner](/NZ_projectiles/Textures/Updates/Banners/Projectiles_symphony.png)
# NZ projectiles
Plugin for Godot that adds a projectile system in 2D&3D. There are four projectile classes (2 each for 2D & 3D), base one and extended, to which you can add more stuff, like changing speed every second or making it disappear only after interacting with 3 objects. <br>
Also includes two more plugins: NZ_projectiles_custom (adds a new projectile class that is much more customizable, but harder to work with) and NZ_projectiles_emitter (adds nodes with which you can emit projectiles). Both plugins require the main one - NZ_projectiles. <br>
Every update adds a new scene in NZ_projectiles/Scenes/Updates where you can see recently added things (even if the update doesn't say that it added a new scene).

## Changelog

### 2.8 (Projectiles Symphony)
	Updates now have names.
	There is now a separate showcase scene for emitters, 2D & 3D projectiles for 2.8 update (and will be for every future update).
	Add Projectile_resource_extra - use to call it in other projectile modules.
	Add PR_extra_changer - replace any module in Projectile_extended or Projectile3D_extended.
	Add PR_extras - change multiple modules at once.
	Update SC_condition and Hit_extended_projectile to include Projectile_resource_extra that will be activated after fulfilling the condition.
	Update AC_time to include Projectile_resource_extra that will be activated after atk is reached the required value.
	Update Hit_extended_projectile to include Projectile_resource_extra that will be activated after attacking anything.
	Update Move_to_node2D and Move_to_node3D, now you can set it to move away from Node2D, multiply to scale when the projectile doesn't look at Node2D or if there is no Node2D to switch to default movement.
	Add icons to SC_increase_func and ProjectileEnum.
	Add changelog for updates 2.0-2.7 (only here).
	Showcase scenes for updates 2.0-2.7 were moved to the separate scene.
	Update NZ_projectiles_emitter to 1.4.

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

## Movement on Line2D and Path3D
![Gif_9](/NZ_projectiles/gifs/gif_9.gif)

## Emitters example
![Gif_8](/NZ_projectiles/gifs/gif_8.gif)
