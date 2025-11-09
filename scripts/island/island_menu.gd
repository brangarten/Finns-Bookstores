extends Control

@onready var menu : Control = $Papa
@onready var items_container : VBoxContainer = $Papa/Tabs/Items/ItemsVBoxContainer
@onready var close_button : TextureButton = $Papa/Tabs/CloseButton
@onready var transfer_button : TextureButton = $Papa/Tabs/Items/ItemsTransferButton
@onready var transfer_label : Label = $Papa/Tabs/Items/ItemsTransferButton/Label

var current_island : Island = null

# Style resources (we'll create these programmatically)
var style_box_empty : StyleBoxEmpty = StyleBoxEmpty.new()
var font_resource : FontFile = null

func _ready():
	# Connect close button
	if close_button:
		close_button.pressed.connect(_close_menu)
	
	# Connect transfer button
	if transfer_button:
		transfer_button.pressed.connect(_on_transfer_pressed)
	
	# Load font if needed
	var font_path = "res://assets/fonts/ByteBounce.ttf"
	if ResourceLoader.exists(font_path):
		font_resource = load(font_path)
	
	# Hide menu initially
	self.visible = false
	
	# Connect to islands after scene tree is ready (they might not be initialized yet)
	call_deferred("_connect_island_signals")

func _connect_island_signals():
	# Get all islands from the "islands" group
	var islands = get_tree().get_nodes_in_group("islands")
	for island in islands:
		if island is Island:
			if island._display_island_menu.is_connected(_open_menu):
				continue
			island._display_island_menu.connect(_open_menu)

func _open_menu(selected_island : Island):
	if not selected_island:
		return
	
	# If menu is already open for this island, don't reopen
	if self.visible and current_island == selected_island:
		return
	
	current_island = selected_island
	_clear_items()
	_populate_items(selected_island)
	_update_transfer_button_label()
	self.visible = true

func _close_menu():
	self.visible = false
	current_island = null

func _clear_items():
	# Remove all existing item nodes immediately
	var children = items_container.get_children()
	for child in children:
		items_container.remove_child(child)
		child.queue_free()

func _populate_items(island : Island):
	if not island or not island.island_items:
		return
	
	var items = island.island_items
	var item_keys = items.keys()
	item_keys.sort()  # Sort to maintain consistent order
	
	var item_index = 0
	for item_key in item_keys:
		var item_data = items[item_key]
		
		# Create item container
		var item_panel = _create_item_panel(item_data, item_key, item_index)
		items_container.add_child(item_panel)
		
		# Add separator after each item (except the last one)
		if item_index < item_keys.size() - 1:
			var separator = HSeparator.new()
			separator.layout_mode = 2  # Full rect
			separator.add_theme_stylebox_override("separator", style_box_empty)
			items_container.add_child(separator)
		
		item_index += 1

func _create_item_panel(item_data : Dictionary, item_key : String, index : int) -> PanelContainer:
	# Create PanelContainer
	var panel = PanelContainer.new()
	panel.layout_mode = 2  # Full rect
	panel.add_theme_stylebox_override("panel", style_box_empty)
	
	# Create TextureButton
	var texture_button = TextureButton.new()
	texture_button.layout_mode = 2  # Full rect
	texture_button.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	
	# Load texture
	var texture_path = item_data.get("Texture", "res://icon.svg")
	if ResourceLoader.exists(texture_path):
		var texture = load(texture_path) as Texture2D
		if texture:
			texture_button.texture_normal = texture
	
	# Handle locked state
	var is_locked = item_data.get("Locked", false)
	if is_locked:
		texture_button.disabled = true
		texture_button.modulate = Color(0.5, 0.5, 0.5, 1.0)  # Gray out locked items
	else:
		texture_button.modulate = Color.WHITE
	
	# Create Label for item name and value
	var label = Label.new()
	label.layout_mode = 0  # Manual positioning
	label.offset_left = 341.33334
	label.offset_top = 52.0
	label.offset_right = 1326.3334
	label.offset_bottom = 224.0
	
	# Set font
	if font_resource:
		label.add_theme_font_override("font", font_resource)
		label.add_theme_font_size_override("font_size", 250)
	
	# Set colors
	label.add_theme_color_override("font_color", Color(0.73728323, 0.9986411, 0.70857835, 1))
	label.add_theme_color_override("font_shadow_color", Color(0.06904721, 0.28697067, 0.10262703, 1))
	label.add_theme_constant_override("shadow_offset_x", 10)
	label.add_theme_constant_override("shadow_offset_y", 6)
	label.add_theme_constant_override("shadow_outline_size", 16)
	
	# Set label text with item name and value
	var item_name = item_data.get("Name", "Unknown")
	var item_value = item_data.get("Value", 0.0)
	var population = current_island.island_population if current_island else 1
	var price_per_pop = item_value / population if population > 0 else item_value
	# Format: "$VAL P/#S" where VAL is the price per population, # is population
	label.text = "$%.2f P/%dS" % [price_per_pop, population]
	
	# Connect button press (if unlocked)
	if not is_locked:
		texture_button.pressed.connect(func(): _on_item_pressed(item_data, item_name))
	
	# Assemble hierarchy
	texture_button.add_child(label)
	panel.add_child(texture_button)
	
	# Add unlock button if item is locked (add to panel so it's always clickable)
	if is_locked:
		var unlock_button = Button.new()
		unlock_button.layout_mode = 0  # Manual positioning
		unlock_button.offset_left = 1100.0
		unlock_button.offset_top = 80.0
		unlock_button.offset_right = 1280.0
		unlock_button.offset_bottom = 180.0
		
		# Set font for unlock button
		if font_resource:
			unlock_button.add_theme_font_override("font", font_resource)
			unlock_button.add_theme_font_size_override("font_size", 80)
		
		# Set unlock button text with price
		var unlock_price = item_data.get("UnlockPrice", 0.0)
		unlock_button.text = "Unlock\n$%.2f" % unlock_price
		
		# Connect unlock button
		unlock_button.pressed.connect(func(): _on_unlock_pressed(item_key, unlock_price))
		
		panel.add_child(unlock_button)
	
	return panel

func _on_item_pressed(item_data : Dictionary, item_name : String):
	print("Item pressed: ", item_name)
	# Add your item purchase logic here
	# For example: player.buy_item(item_data)

func _on_unlock_pressed(item_key : String, unlock_price : float):
	if not current_island:
		return
	
	# Check if player has enough money
	if GPlayer.value < unlock_price:
		print("Not enough money! Need $%.2f, have $%.2f" % [unlock_price, GPlayer.value])
		return
	
	# Check if item exists and is locked
	if not current_island.island_items.has(item_key):
		return
	
	var item_data = current_island.island_items[item_key]
	if not item_data.get("Locked", false):
		return
	
	# Deduct money
	GPlayer.value -= unlock_price
	
	# Unlock the item
	item_data["Locked"] = false
	current_island.island_items[item_key] = item_data
	
	print("Unlocked item: ", item_data.get("Name", "Unknown"))
	
	# Refresh the menu to show updated state
	_clear_items()
	_populate_items(current_island)
	_update_transfer_button_label()

func _process(delta : float):
	# Update transfer button label if menu is visible and island exists
	if visible and current_island:
		_update_transfer_button_label()

func _update_transfer_button_label():
	if transfer_label and current_island:
		var wallet_value = current_island.island_wallet
		transfer_label.text = "$%.2f" % wallet_value

func _on_transfer_pressed():
	if not current_island:
		return
	
	# Transfer all money from island_wallet to player
	var amount_to_transfer = current_island.island_wallet
	if amount_to_transfer > 0:
		GPlayer.value += amount_to_transfer
		current_island.island_wallet = 0.0
		_update_transfer_button_label()
		print("Transferred $%.2f from %s to player" % [amount_to_transfer, current_island.island_name])
