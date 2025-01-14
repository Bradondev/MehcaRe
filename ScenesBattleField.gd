extends TileMapLayer
class_name  BattleField



@export var fields: FieldManager 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_parent().ready
	for cell in get_used_cells():
		
		await  SpawnInCell(cell)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
	
func  SpawnInCell(coords: Vector2i, source_id: int = -1, atlas_coords: Vector2i = Vector2i(-1, -1), alternative_tile: int = 0)->void:
	
	
	var newTween: Tween = get_tree().create_tween()
	var atlas =tile_set. get_source(0) as TileSetAtlasSource
	var atlasImage :Image  = atlas.texture.get_image()
	var tileAtlasData: Vector2i = get_cell_atlas_coords(coords)
	var tileImage :Image = atlasImage.get_region(atlas.get_tile_texture_region(tileAtlasData))
	var tiletexture:ImageTexture  = ImageTexture.create_from_image(tileImage)
	var NewSprite :Sprite2D = Sprite2D.new()
	NewSprite.global_position.x = map_to_local(coords).x 
	NewSprite.global_position.y = 0
	NewSprite.y_sort_enabled = true
	fields.add_child(NewSprite)
	NewSprite.texture = tiletexture
	newTween.tween_property(NewSprite,"global_position",map_to_local(coords), .2 )
	
	await  newTween.finished
	

	
	
	#set_cell(coords, source_id ,atlas_coords,alternative_tile)
	
