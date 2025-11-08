extends Node
class_name Island

@export var island_name : String = "Campus"
@export var island_unlocked : bool = false
@export var population : int = 1
@export var items : Dictionary = {
	"Item1" : {
		"Name": "Blank",
		"Value": 1.00,
		"Description": "Desc Maou",
		"Locked": false
	},
	"Item2" : {
		"Name": "Blank",
		"Value": 1.00,
		"Description": "Desc Maou",
		"Locked": true 
	},
	"Item3" : {
		"Name": "Blank",
		"Value": 1.00,
		"Description": "Desc Maou", 
		"Locked": true
	}
}

