extends CharacterBody2D

@export var hp : int = 15:
	set(value):
		hp = clamp(value,0,abs(value))
		if hp == 0:
			queue_free()
@export_enum("Neutral","Enemy") var type : int = 0
@export var speed : Vector2 = Vector2(15,0)

func _physics_process(delta: float) -> void:
	position += speed*delta

func _reverse_speed() -> void:
	speed = -speed

func hit(atk:int) -> void:
	hp -= atk

func hit_extended(atk:int) -> void:
	hit(atk)

func hit_extended_speed(atk:int,_speed:int) -> void:
	hit(atk)
