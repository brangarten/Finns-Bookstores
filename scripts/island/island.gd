extends Node2D
class_name Island

#@onready var island_menu = get_tree().get_node("island_menu")
#var island_menu = preload("res://scripts/island/island_menu.gd") 
signal _display_island_menu(island : Island)
var island_name : String = "Island"
var island_unlocked : bool = false
var island_population : int = 1
var player_nearby : bool = false
var island_time_rate : int = 30
var island_wallet : float = 0.00
var elapsed_time : float = 0.0
var progress_bar : ProgressBar = null 

var island_items : Dictionary = {
	"Item1" : {
		"Name": "Blank",
		"Value": 1.00,
		"Description": "Desc Maou",
		"Texture": "res://icon.svg",
		"Locked": false, 
		"UnlockPrice": 0.00
	},
	"Item2" : {
		"Name": "Blank",
		"Value": 1.00,
		"Description": "Desc Maou",
		"Texture": "res://icon.svg",
		"Locked": true,
		"UnlockPrice": 40
	},
	"Item3" : {
		"Name": "Blank",
		"Value": 1.00,
		"Description": "Desc Maou", 
		"Texture": "res://icon.svg",
		"Locked": true,
		"UnlockPrice": 50
	}
}

func _set_island(island_name : String, island_unlocked : bool, island_population : int, island_items : Dictionary):
	self.island_name = island_name
	self.island_unlocked = island_unlocked
	self.island_population = island_population
	self.island_items = island_items

func _input(event):
	# Check for Enter key press when player is nearby
	if player_nearby and event.is_action_pressed("enter"):
		emit_signal("_display_island_menu", self)

func _set_player_nearby(is_nearby : bool):
	player_nearby = is_nearby

func _process(delta : float):
	# If the island has an unlocked item then update the progress bar
	for item_key in island_items.keys():
		var item_data = island_items[item_key]
		if not item_data.get("Locked", true):
			# Update elapsed time
			elapsed_time += delta
			
			# Check if time rate is reached (process cycles until we're under the limit)
			while elapsed_time >= island_time_rate:
				# Calculate money from unlocked items
				var money_earned = _calculate_earnings()
				island_wallet += money_earned
				
				# Subtract one cycle from elapsed time
				elapsed_time -= island_time_rate
		
		# Update progress bar
		if progress_bar:
			var progress_percent = (elapsed_time / island_time_rate) * 100.0
			progress_bar.value = progress_percent

func _calculate_earnings() -> float:
	var total_earnings : float = 0.0
	
	# Sum up the value of all unlocked items
	for item_key in island_items.keys():
		var item_data = island_items[item_key]
		if not item_data.get("Locked", true):
			var item_value = item_data.get("Value", 0.0)
			total_earnings += item_value
	
	return total_earnings

func set_progress_bar(bar : ProgressBar):
	progress_bar = bar
	if progress_bar:
		progress_bar.min_value = 0.0
		progress_bar.max_value = 100.0
		progress_bar.value = 0.0
