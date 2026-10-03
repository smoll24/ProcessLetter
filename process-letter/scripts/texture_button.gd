extends TextureButton

var label: String
var dropped_on_target: bool = false

const DRAG_PREVIEW = preload("res://src/ui/drag_preview.tscn")

func _ready():
	add_to_group("draggable")

func _get_drag_data(_position: Vector2):
	var data = {
		"origin_node": self,
		"origin_texture_normal": texture_normal
	}
	var drag_preview = DRAG_PREVIEW.instantiate()
	print("dragging")
	drag_preview.texture = texture_normal
	set_drag_preview(drag_preview)
	return data


func _can_drop_data(_position: Vector2, data) -> bool:
	return data.has("origin_node") and data["origin_node"] != self

func _drop_data(_position: Vector2, data):
	var origin_node = data["origin_node"]
	var target_texture_normal = texture_normal
	origin_node.texture_normal = target_texture_normal
	texture_normal = data["origin_texture_normal"]
