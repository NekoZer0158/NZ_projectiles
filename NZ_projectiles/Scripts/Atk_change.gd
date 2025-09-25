extends Button

@export var debug : bool = false
@export var markers_projectiles : Array[Marker2D]
@export var markers_characters : Array[Marker2D]

@onready var parent_parent_node := get_parent().get_parent()

var character_1 : CharacterBody2D
var character_2 : CharacterBody2D
var character_3 : CharacterBody2D

func create_projectiles() -> void:
	var cur_projectile : int = 0
	for i in markers_projectiles:
		cur_projectile += 1
		var new_projectile : Projectile_extended= parent_parent_node.PROJECTILE_EXTENDED.instantiate()
		match cur_projectile:
			1:
				new_projectile.r_atk_change = AC_random_range.new()
				new_projectile.r_atk_change.min_value = -15
				new_projectile.r_atk_change.max_value = 15
			2:
				var atk_step : int = randi_range(15,35)
				new_projectile.r_atk_change = AC_time.new()
				new_projectile.r_atk_change.increase_atk_to_this = 100
				new_projectile.r_atk_change.atk_step = atk_step
				new_projectile.r_atk_change.time = 0.25
				if debug:
					new_projectile.r_atk_change.debug = true
				print("----------------------")
				print("atk_step middle: ",atk_step)
			3:
				var atk_step : int = randi_range(2,5)
				new_projectile.r_atk_change = ACT_multiplier.new()
				new_projectile.r_atk_change.increase_atk_to_this = 1000
				new_projectile.r_atk_change.atk_step = atk_step
				new_projectile.r_atk_change.time = 0.25
				if debug:
					new_projectile.r_atk_change.debug = true
				print("atk_step bottom: ",atk_step)
				print("----------------------")
		i.add_child(new_projectile)

func _on_pressed() -> void:
	create_projectiles()
	parent_parent_node.check_and_free_character(character_1)
	parent_parent_node.check_and_free_character(character_2)
	parent_parent_node.check_and_free_character(character_3)
	character_1 = parent_parent_node.TEST_CHARACTER.instantiate()
	character_1.name = "Character_top"
	markers_characters[0].add_child(character_1)
	character_2 = parent_parent_node.TEST_CHARACTER.instantiate()
	character_2.name = "Character_middle"
	markers_characters[1].add_child(character_2)
	character_3 = parent_parent_node.TEST_CHARACTER.instantiate()
	character_3.name = "Character_bottom"
	markers_characters[2].add_child(character_3)
