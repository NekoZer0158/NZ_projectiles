extends CharacterBody2D

@export var hp : int = 15:
	set(value):
		hp = clamp(value,0,value)
		if hp == 0:
			queue_free()
@export_enum("Warrior","Mage","Archer","Hunter","Thief") var character_class : int = 0

func got_damage(dmg:int) -> void:
	hp -= dmg
	print("-----------",name,"-----------")
	print("Character class: ",character_class)
	print("HP:",hp," | DMG:",dmg)

func change_position(_atk:int,projectile_position:Vector2) -> void:
	position = projectile_position+Vector2(-64,0)
