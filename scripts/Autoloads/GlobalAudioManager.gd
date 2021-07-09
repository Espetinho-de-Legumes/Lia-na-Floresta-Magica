extends Node

onready var FadeInTransition: Tween = get_node("FadeIn")
onready var FadeOutTransition: Tween = get_node("FadeOut")

var currentPlaying: AudioStreamPlayer = null

func setAudio(newAudio: String) -> void:
	var audioStream: AudioStreamPlayer = get_node_or_null(newAudio)
	
	if audioStream:
		if currentPlaying:
			fadeCurrentMusicOut()
		
		currentPlaying = audioStream
		fadeMusicIn()
	else:
		push_error("Ocorreu um erro no Global Audio Manager")

func fadeCurrentMusicOut() -> void:
	var transitionTime:float = 0.5
	
	FadeOutTransition.interpolate_property(currentPlaying, "volume_db", currentPlaying.volume_db, -40, transitionTime, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	FadeOutTransition.start()

func fadeMusicIn() -> void:
	var transitionTime:float = 1
	
	currentPlaying.play()
	FadeInTransition.interpolate_property(currentPlaying, "volume_db", -40, -15, transitionTime, Tween.TRANS_LINEAR, Tween.EASE_IN)
	FadeInTransition.start()


func _on_FadeOut_tween_completed(object: Object, key: NodePath) -> void:
	object.stop()
