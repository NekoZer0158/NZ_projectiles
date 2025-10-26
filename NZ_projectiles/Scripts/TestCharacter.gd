extends CharacterBody2D

@export var hp : int = 15:
	set(value):
		hp = clamp(value,0,abs(value))
		if hp == 0:
			queue_free()
@export_enum("Neutral","Enemy") var type : int = 0

var dont_print : bool = false
var move_right : bool = false

const SPEED : int = 325

signal remove_tile_map_layer()

func _physics_process(_delta: float) -> void:
	if move_right:
		velocity.x = SPEED
		move_and_slide()

func hit(atk:int) -> void:
	hp -= atk
	if !dont_print:
		print("-----------",name,"-----------")
		print("Type: ",type)
		print("HP:",hp," | ATK:",atk)

func hit_extended_array(atk:int,array:Array) -> void:
	hit(atk)
	print("Array values: ",array)

func hit_extended_3(_atk:int,_n0=null,_n1=null,_n2=null,_n3=null,projectile_id:String="None") -> void:
	print(projectile_id)

func hit_extended(_atk:int,projectile_id:String,some_bool_value:bool=false) -> void:
	match projectile_id:
		"tilemap_remove":
			if !dont_print:
				print("-----------",name,"-----------")
				print("Projectile ID is: ",projectile_id)
				print("TileMapLayer is removed")
			remove_tile_map_layer.emit()
		"instant_qf":
			if !dont_print:
				print("-----------",name,"-----------")
				print("Instant queue_free")
			queue_free()
		"type_neutral":
			if !dont_print:
				print("-----------",name,"-----------")
				print("Type changed to Neutral (0)")
			type = 0
		"move_right":
			if !dont_print:
				print("-----------",name,"-----------")
				print("Projectile ID is: ",projectile_id)
				print("Character is now moving right")
				print("Projectile remove_when_tilemap_layer:",some_bool_value)
			move_right = true
