extends Island

@onready var title_label : Label = $Title
@onready var area : Area2D = $Area

func _ready():

    title_label.visible = false

    self.island_name = "Kendall Island"
    self.island_unlocked = false
    self.island_population = 1

    self._set_island(island_name, island_unlocked, island_population, self.island_items)
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
