extends Control

@onready var text_label : Label = $Label

func _ready():
	text_label.text = ":3"
	
func _process(delta):
	text_label.text = ": $" + str(GPlayer.value) + " BB"
	#GPlayer.value += 2

