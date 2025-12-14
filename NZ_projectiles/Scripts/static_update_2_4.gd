extends StaticBody2D

@export_enum("Neutral","Enemy") var type : int = 0
@export var hp_x : int
@export var hp_y : int

func hit(atk:Vector2i) -> void:
	print("HP before hitting: hp_x:",hp_x," hp_y:",hp_y," | atk: ",atk)
	hp_x -= atk.x
	hp_y -= atk.y
	print("HP after hitting: hp_x:",hp_x," hp_y:",hp_y," | atk: ",atk)
	if hp_x == 0 and hp_y == 0:
		queue_free()
