extends Node

var currentPlaying: AudioStreamPlayer = null

func setAudio(newAudio: String) -> void:
	var audioStream: AudioStreamPlayer = get_node_or_null(newAudio)
	
	if audioStream:
		if currentPlaying:
			currentPlaying.stop()
		
		currentPlaying = audioStream
		currentPlaying.play()
	else:
		push_error("Ocorreu um erro no Global Audio Manager")
