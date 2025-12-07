extends Button

@export var markers_projectiles : Array[Marker2D]
@export var markers_characters : Array[Marker2D]

@onready var parent_parent_node := get_parent().get_parent()
@onready var marker_2d_2: Marker2D = $"../../Markers_for_projectiles/Marker2D2"
@onready var marker_2d_4: Marker2D = $"../../Markers_for_projectiles/Marker2D4"


var characters : Array[CharacterBody2D]

func create_projectiles() -> void:
	var cur_projectile : int = 0
	for i in markers_projectiles:
		cur_projectile += 1
		var new_projectile : Projectile_extended = parent_parent_node.PROJECTILE_EXTENDED.instantiate()
		new_projectile.atk = 15
		match cur_projectile:
			1:
				new_projectile.r_remove_projectile = RP_lives.new()
			2:
				new_projectile.r_remove_projectile = RP_group.new()
				new_projectile.r_remove_projectile.group_name = "Remove"
				var top_projectile : Projectile_extended = parent_parent_node.PROJECTILE_EXTENDED.instantiate()
				var bottom_projectile : Projectile_extended = parent_parent_node.PROJECTILE_EXTENDED.instantiate()
				top_projectile.speed -= 50
				bottom_projectile.speed -= 50
				marker_2d_2.add_child(top_projectile)
				marker_2d_4.add_child(bottom_projectile)
				top_projectile.add_to_group("Remove")
				bottom_projectile.add_to_group("Remove")
			3:
				new_projectile.r_remove_projectile = RP_multiple.new()
				new_projectile.r_remove_projectile.RP_resources.append(RP_spawn_projectile.new())
				new_projectile.r_remove_projectile.RP_resources.front().spawn_this_projectile = load("res://NZ_projectiles/Projectiles/Projectile.tscn")
				new_projectile.r_remove_projectile.RP_resources.append(RP_lives.new())
				new_projectile.r_remove_projectile.RP_resources.back().hits_before_removing = 2
				new_projectile.r_remove_projectile.RP_resources.front().remove_this_projectile = false
		i.add_child(new_projectile)

func _on_pressed() -> void:
	create_projectiles()
	for i in characters:
		i.queue_free()
	for i in markers_characters:
		var new_character : CharacterBody2D = parent_parent_node.TEST_CHARACTER.instantiate()
		new_character.dont_print = true
		i.add_child(new_character)
