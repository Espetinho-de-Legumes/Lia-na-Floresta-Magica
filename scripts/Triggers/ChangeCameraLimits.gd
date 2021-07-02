extends Area2D

export(NodePath) var cameraPath
export(int) var topLimit = 0
export(int) var rightLimit = 0
export(int) var bottomLimit = 0
export(int) var leftLimit = 0
export(bool) var onEnter = true

var camera: Camera2D
var lastTopLimit: int = 0
var lastRightLimit: int = 0
var lastBottomLimit: int = 0
var lastLeftLimit: int = 0

func _ready() -> void:
	camera = get_node(cameraPath)

func _on_ChangeCameraLimits_body_entered(body: Player) -> void:
	lastTopLimit = camera.get_limit(MARGIN_TOP)
	lastRightLimit = camera.get_limit(MARGIN_RIGHT)
	lastBottomLimit = camera.get_limit(MARGIN_BOTTOM)
	lastLeftLimit = camera.get_limit(MARGIN_LEFT)
	
	if body.velocity.x * int(onEnter) > 0:
		camera.set_limit(MARGIN_TOP, topLimit)
		camera.set_limit(MARGIN_RIGHT, rightLimit)
		camera.set_limit(MARGIN_BOTTOM, bottomLimit)
		camera.set_limit(MARGIN_LEFT, leftLimit)
	else:
		camera.set_limit(MARGIN_TOP, lastTopLimit)
		camera.set_limit(MARGIN_RIGHT, lastRightLimit)
		camera.set_limit(MARGIN_BOTTOM, lastBottomLimit)
		camera.set_limit(MARGIN_LEFT, lastLeftLimit)
