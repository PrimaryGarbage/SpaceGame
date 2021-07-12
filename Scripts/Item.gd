extends Node2D
class_name Item

export(String) var itemName = name
export(Texture) var inventoryTexture
export(String, MULTILINE) var description
export(ItemDatabase.ITEM_TYPE) var type
export(bool) var stackable = false
export(int) var stackSize = 1
export(float) var quantity = 1


func _ready():
	get_parent().item = self

func GetInventoryItem() -> InventoryItem:
	### override this in children to assign values to t
	return InventoryItem.new(itemName, inventoryTexture, type, stackable, stackSize, quantity, {}, null)

#func UpdateInventoryItemValue(key: String, value):
#	inventoryItem.values[key] = value

func GetValuesFromInventoryItem(item : InventoryItem):
	# abstract #
	### get required info from inventoryItem values dictionary
	pass

func GetInformation():
	var info = []
	info.append("Name: " + itemName)
	info.append("Type: " + ItemDatabase.GetTypeAsString(type))
	info.append("Description: " + description)
	return info
