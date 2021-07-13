extends Node
class_name InventoryItem

onready var iconPrefab = preload("res://Scenes/UI/InventoryIcon.tscn")

var itemName = name
var icon
var iconTexture: Texture
var type
var stackable: bool
var stackSize: int
var quantity: float
var values = {}   # for conserving value of shieldGenerator energy, etc
var price: int
var slot

func _init(_itemName:String, _iconTexture: Texture, _type, _stackable: bool, _stackSize: int, _quantity: int, _values: Dictionary, _price: int, _slot):
	itemName = _itemName
	iconTexture = _iconTexture
	type = _type
	stackable = _stackable
	stackSize = _stackSize
	quantity = _quantity
	values = _values
	price = _price
	slot = _slot
	icon = CreateIcon(iconTexture)

func CreateIcon(texture: Texture) -> TextureRect:
	if(!iconPrefab): iconPrefab = load("res://Scenes/UI/InventoryIcon.tscn")
	if(texture == null): push_error("Iventory item \"" + itemName + "\" doesn't have inventoryTexture")
	var newIcon = iconPrefab.instance()
	newIcon.texture = texture
	newIcon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	newIcon.expand = true
	newIcon.mouse_filter = Control.MOUSE_FILTER_PASS
	newIcon.find_node("NameLabel").text = itemName
	var quantityLabel = newIcon.find_node("QuantityLabel")
	quantityLabel.text = str(quantity)
	if(stackable): quantityLabel.show()
	return newIcon

func Split(value: float) -> InventoryItem:
	var portion = min(quantity, value)
	quantity -= value
	var item = self.duplicate()
	item.quantity = value
	if(quantity <= 0.0): queue_free()
	return item
	pass
	###
