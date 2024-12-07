extends CharacterBody2D

@export var hp : int = 15:
	set(value):
		hp = clamp(value,0,abs(value))
		if hp == 0:
			queue_free()
@export_enum("Neutral","Enemy") var type : int = 0

var dont_print : bool = false

signal remove_tile_map_layer()

func hit(atk:int) -> void:
	hp -= atk
	if !dont_print:
		print("-----------",name,"-----------")
		print("Type: ",type)
		print("HP:",hp," | ATK:",atk)

func hit_extended(_atk:int,projectile_id:int) -> void:
	match projectile_id:
		1:
			if !dont_print:
				print("-----------",name,"-----------")
				print("Projectile ID is: ",projectile_id)
				print("TileMapLayer is removed")
			remove_tile_map_layer.emit()
		2:
			if !dont_print:
				print("-----------",name,"-----------")
				print("Instant queue_free")
			queue_free()
		3:
			if !dont_print:
				print("-----------",name,"-----------")
				print("Type changed to Neutral (0)")
			type = 0
