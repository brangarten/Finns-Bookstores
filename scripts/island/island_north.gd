extends Island

@onready var title_label : Label = $Title
@onready var area : Area2D = $Area

var north_items : Dictionary = {
	"Item1" : {
		"Name": "Ice Cream",
		"Value": 1.00,
		"Description": "Desc Maou",
		"Texture": "res://assets/textures/sprites/items/icon_icecream.png",
		"Locked": false
	},#lab coat, 
	"Item2" : {
		"Name": "Lab Coat",
		"Value": 1.00,
		"Description": "Desc Maou",
		"Texture": "res://assets/textures/sprites/items/icon_labcoat.png",
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

func _ready():

    title_label.visible = false

    self.island_name = "North Island"
    self.island_unlocked = false
    self.island_population = 1

    self._set_island(island_name, island_unlocked, island_population, north_items)
    title_label.text = island_name

    area.body_entered.connect(_on_body_entered)
    area.body_exited.connect(_on_body_exited)

func _on_body_entered(body : Node2D):
    if body is Player:
        print_debug(":DDD")
        title_label.visible = true

func _on_body_exited(body : Node2D):
    if body is Player:
        title_label.visible = false
