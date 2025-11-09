extends Island

@onready var title_label : Label = $Title
@onready var area : Area2D = $Area
@onready var progress_bar_node : ProgressBar = $ProgressBar

var homestead_items : Dictionary = {
	"Item1" : {
		"Name": "MDC Cap",
		"Value": 20.00,
		"Description": "Desc Maou",
		"Texture": "res://assets/textures/sprites/items/icon_cap.png",
		"Locked": true,
		"UnlockPrice": 180.00
	},
	"Item2" : {
		"Name": "MDC T-Shirt",
		"Value": 22.00,
		"Description": "Desc Maou",
		"Texture": "res://assets/textures/sprites/items/icon_mdctshirt.png",
		"Locked": true,
		"UnlockPrice": 300
	},
	"Item3" : {
		"Name": "MDC Hoodie",
		"Value": 25.00,
		"Description": "Desc Maou", 
		"Texture": "res://assets/textures/sprites/items/icon_mdchoodie.png",
		"Locked": true,
		"UnlockPrice": 450
		
	}
}

func _ready():

	title_label.visible = false

	self.island_name = "Homestead Island"
	self.island_unlocked = false
	self.island_population = 1
	self.island_time_rate =900

	self._set_island(island_name, island_unlocked, island_population, homestead_items)
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
