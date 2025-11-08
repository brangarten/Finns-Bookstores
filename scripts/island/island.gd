extends Node2D
class_name Island

var island_name : String = "Island"
var island_unlocked : bool = false
var island_population : int = 1

var island_items : Dictionary = {
	"Item1" : {
		"Name": "Blank",
		"Value": 1.00,
		"Description": "Desc Maou",
		"Texture": "res://icon.svg",
		"Locked": false
	},
	"Item2" : {
		"Name": "Blank",
		"Value": 1.00,
		"Description": "Desc Maou",
		"Texture": "res://icon.svg",
		"Locked": true 
	},
	"Item3" : {
		"Name": "Blank",
		"Value": 1.00,
		"Description": "Desc Maou", 
		"Texture": "res://icon.svg",
		"Locked": true
	}
}

func _set_island(island_name : String, island_unlocked : bool, island_population : int, island_items : Dictionary):
	self.island_name = island_name
	self.island_unlocked = island_unlocked
	self.island_population = island_population
	self.island_items = island_items
