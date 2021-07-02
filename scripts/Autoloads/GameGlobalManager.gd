extends Node2D

var playerStatus = {
	"lives": 3,
	"health": 3,
	"numberOfDeaths": 0,
	"score": 0,
	"hasDied": false,
	"lastScene": "Level1",
	"hasTheCure": false
}

var Level1Data = {
	"hasFinishedLevel": false,
	"hasTalkedToMother": false
}

var Level2Data = {
	"hasFinishedLevel": false,
	"hasTalkedToJotaro": false,
	"hasCompletedJotaroQuest": false
}

var Level3Data = {
	"hasFinishedLevel": false,
	"hasTalkedToJotaro": false,
	"hasCompletedJotaroQuest": false
}

var Level4Data = {
	"hasFinishedLevel": false,
	"hasTalkedToJotaro": false,
	"hasCompletedJotaroQuest": false
}

func setLevel1Data(property: String, value) -> void:
	Level1Data[property] = value
