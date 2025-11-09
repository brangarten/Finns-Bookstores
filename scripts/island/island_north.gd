extends Island

@onready var title_label : Label = $Title
@onready var area : Area2D = $Area
@onready var progress_bar_node : ProgressBar = $ProgressBar

var north_items : Dictionary = {
	"Item1" : {
		"Name": "Ice Cream",
		"Value": 5.00,
		"Description": "Desc Maou",
		"Texture": "res://assets/textures/sprites/items/icon_icecream.png",
		"Locked": false,
		"UnlockPrice": 0.00
	},
	"Item2" : {
		"Name": "Paper",
		"Value": 5.00,
		"Description": "Desc Maou",
		"Texture": "res://assets/textures/sprites/items/icon_paper.png",
		"Locked": true,
		"UnlockPrice": 40
	},
	"Item3" : {
		"Name": "Earbuds",
		"Value": 5.00,
		"Description": "Desc Maou", 
		"Texture": "res://assets/textures/sprites/items/icon_earbuds.png",
		"Locked": true,
		"UnlockPrice": 50
		
	}
}

func _ready():

	title_label.visible = false

	self.island_name = "North Island"
	self.island_unlocked = false
	self.island_population = 1
	self.island_time_rate = 30 

	self._set_island(island_name, island_unlocked, island_population, north_items)
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
