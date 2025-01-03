extends Resource #this allows to attach to any inventory we have

class_name Inv

@export var slots: Array[InvSlot] #stores items in inventory in class array

func insert(item: InvItem):
	pass
