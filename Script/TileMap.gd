extends Node

var tileMap:TileMap

var verifMap:TileMap

var playerPos:Vector2
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	tileMap = $TileMap
	
	verifMap = $VerifMap
	
	playerPos = Vector2(2, 2)

func verif():
	var cratesPos:Array = tileMap.get_used_cells_by_id(1)
	var verifsPos:Array = verifMap.get_used_cells()
	
	cratesPos.sort()
	verifsPos.sort()
	
	for i in range(verifsPos.size()):
		if cratesPos[i] != verifsPos[i]:
			return false
			
	return true

func move(dir:Vector2):
	var newPos = playerPos + dir
	
	match(tileMap.get_cellv(newPos)):
		-1:
			tileMap.set_cellv(playerPos, -1)
			tileMap.set_cellv(newPos, 2)
		
			playerPos = newPos
			
		1:
			var newCratePos = playerPos+dir*2
			
			if tileMap.get_cellv(newCratePos) == -1:
				tileMap.set_cellv(newCratePos, 1)
				tileMap.set_cellv(newPos, 2)
				tileMap.set_cellv(playerPos, -1)
			
				playerPos = newPos
				
				if(verif()):
					print("ok")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_down"):
		move(Vector2(0, 1))
			
	if Input.is_action_just_pressed("ui_up"):
		move(Vector2(0, -1))
		
	if Input.is_action_just_pressed("ui_left"):
		move(Vector2(-1, 0))
		
	if Input.is_action_just_pressed("ui_right"):
		move(Vector2(1, 0))
	
#	pass
