extends Panel

func _ready():
	set_process(false)
	connect("draw", self, "_on_draw")
	connect("hide", self, "_on_hide")

func _process(delta : float) -> void:
	var mouse_shift = Vector2(5, 0)
	set_position(get_global_mouse_position() + mouse_shift)

func _on_draw() -> void:
	set_process(true)

func _on_hide() -> void:
	set_process(false)

func initialize(obj_name : String, data : Dictionary = {}):
	$VBox/Name.set_text(obj_name)
