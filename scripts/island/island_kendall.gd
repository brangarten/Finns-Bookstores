extends Island

@onready var title_label : Label = $Title
@onready var area : Area2D = $Area
@onready var progress_bar_node : ProgressBar = $ProgressBar

var kendall_items : Dictionary = {
	"Item1" : {
		"Name": "Scantron",
		"Value": 12.00,
		"Description": "Desc Maou",
		"Texture": "res://assets/textures/sprites/items/icon_scantron.png",
		"Locked": true,
		"UnlockPrice": 100.00
	},
	"Item2" : {
		"Name": "Lab coat",
		"Value": 14.00,
		"Description": "Desc Maou",
		"Texture": "res://assets/textures/sprites/items/icon_labcoat.png",
		"Locked": true,
		"UnlockPrice": 120.00
	},
	"Item3" : {
		"Name": "Calculator",
		"Value": 16.00,
		"Description": "Desc Maou", 
		"Texture": "res://assets/textures/sprites/items/icon_calculator.png",
		"Locked": true,
		"UnlockPrice": 140.00
		
	}
}

func _ready():

	title_label.visible = false

	self.island_name = "Kendall Island"
	self.island_unlocked = false
	self.island_population = 1
	self.island_time_rate = 420

	self._set_island(island_name, island_unlocked, island_population, kendall_items)
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
