extends Control

@onready var item_nodes = {
    "Item1": $VBoxContainer/Item1/ItemTexture1,
    "Item2": $VBoxContainer/Item2/ItemTexture2,
    "Item3": $VBoxContainer/Item3/ItemTexture3
}

var current_island : Island = null

func _open_menu(selected_island : Island):
    current_island = selected_island
    self.visible = true

func _close_menu():
    self.visible = false

func _set_items():
    if current_island == null:
        print("No Islands?")
        return
    
    var island_data = current_island.island_items

    for key in item_nodes:
        var item_ui_node = item_nodes.get(key)
        var item_data = island_data.get(key)

        if item_ui_node and item_data:
            var is_locked = item_data.get("Locked", true) 

            if is_locked == false:
                item_ui_node.visible = true 
                
                var item_name = item_data.get("Name", "---")
                var item_value = item_data.get("Value", 0.00)
                var item_texture_path = item_data.get("Texture", "")
                
                
                # --- A. Update Texture Button/Item Image ---
                # We'll use find_child to get the texture node (e.g., ItemTexture3)
                # This assumes your texture display node's name contains "Texture"
                # If Item1 and Item2 have different child names, you might need to adjust this.
                var texture_node = item_ui_node.find_child("ItemTexture*", true) # Recursive search (true)
                
                if texture_node and item_texture_path:
                    var new_texture = load(item_texture_path)
                    if new_texture is Texture2D:
                        # Assuming the found node is a TextureRect or has a 'texture' property
                        texture_node.texture = new_texture
                        
                # --- B. Update Name and Value Labels ---
                # You MUST name your labels consistently for this to work (e.g., 'NameLabel', 'ValueLabel')
                var name_label = item_ui_node.find_child("NameLabel", true)
                var value_label = item_ui_node.find_child("ValueLabel", true)

                if name_label is Label:
                    name_label.text = item_name
                
                if value_label is Label:
                    # Format value as currency
                    value_label.text = "$%.2f" % item_value
                    
        else:
                # If the item is locked, hide the container for that item
                item_ui_node.visible = false