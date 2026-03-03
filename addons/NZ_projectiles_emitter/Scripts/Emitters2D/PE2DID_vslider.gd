@icon("res://addons/NZ_projectiles_emitter/Icons/PE2DID_vslider.svg")
class_name PE2DID_Vslider
extends PE2DID_slider

## @experimental
## Recommned to not change position or rotation during runtime

@export var vslider : VSlider

func _ready() -> void:
	super()
	if !is_instance_valid(vslider):
		push_error("vslider isn't valid")
	if autoconnect_drag_ended:
		vslider.drag_ended.connect(_on_slider_drag_ended)
	_calculate_all_needed_slider_values(vslider)

func _get_random_position_from_slider() -> Vector2:
	var random_pos : Vector2
	random_pos.x = vslider.global_position.x+vslider.size.x/2
	random_pos.y = vslider.global_position.y+vslider.size.y-randf_range(0,vslider.value*_one_step_pixel_size)
	if vslider.rotation_degrees != 0:
		random_pos = (random_pos-vslider.global_position).rotated(vslider.rotation)+vslider.global_position
	if debug:
		print("random_pos: ",random_pos)
	return random_pos

func _on_slider_drag_ended(value_changed:bool) -> void:
	if value_changed:
		_calculate_dragger_pos(vslider,true)
		if debug:
			queue_redraw()

func _get_cur_slider() -> Slider:
	return vslider

func _get_rotation_to_front() -> float:
	return 0
