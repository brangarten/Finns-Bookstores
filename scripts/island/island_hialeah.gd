extends Island

@onready var title_label : Label = $Title
@onready var area : Area2D = $Area
@onready var progress_bar_node : ProgressBar = $ProgressBar

var hialeah_items : Dictionary = {
	"Item1" : {
		"Name": "Chips",
		"Value": 7.00,
		"Description": "Desc Maou",
		"Texture": "res://assets/textures/sprites/items/icon_chips.png",
		"Locked": true,
		"UnlockPrice": 60.00
	},
	"Item2" : {
		"Name": "Lanyard",
		"Value": 9.00,
		"Description": "Desc Maou",
		"Texture": "res://assets/textures/sprites/items/icon_lanyard.png",
		"Locked": true,
		"UnlockPrice": 80
	},
	"Item3" : {
		"Name": "Parking Decal",
		"Value": 10.00,
		"Description": "Desc Maou", 
		"Texture": "res://assets/textures/sprites/items/icon_decal.png",
		"Locked": true,
		"UnlockPrice": 90
		
	}
}

func _ready():

	title_label.visible = false

	self.island_name = "Hialeah Island"
	self.island_unlocked = false
	self.island_population = 1
	self.island_time_rate = 120

	self._set_island(island_name, island_unlocked, island_population, hialeah_items)
	title_label.text = island_name
	
	# Set up progress bar if found
	if progress_bar_node:
		set_progress_bar(progress_bar_node)

	# I <3 HARDCODING SIGNALS
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)

func _on_body_entered(body : Node2D):
	if body is Player:
		print_debug(":DDD")
		title_label.visible = true
		# Set player_nearby flag in base class
		_set_player_nearby(true)

func _on_body_exited(body : Node2D):
	if body is Player:
		title_label.visible = false
		# Clear player_nearby flag in base class
		_set_player_nearby(false)
