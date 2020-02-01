package;

import flixel.FlxObject;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.ogmo.FlxOgmoLoader;

class Level
{
    /**
	 * Some static constants for the size of the tilemap tiles
	 */
	static inline var TILE_WIDTH:Int = 32;
	static inline var TILE_HEIGHT:Int = 32;

	public var _mWalls:FlxTilemap;
    public var _mFloor:FlxTilemap;

    var _map:FlxOgmoLoader;
    var _drone:object.Drone;

    public function new(drone:object.Drone) {
        // super();

        var array:Array<Int>;

        _drone = drone;

		// Basic level structure
		_map = new FlxOgmoLoader("assets/data/room-002.oel");
		_mWalls = _map.loadTilemap("assets/images/tileset_test.png", 32, 32, "walls");
		_mWalls.follow();
        for (i in 1...120)
            _mWalls.setTileProperties(i, FlxObject.ANY);

        _mFloor = _map.loadTilemap("assets/images/tileset_test.png", 32, 32, "floor");
		for (i in 1...120)
            _mFloor.setTileProperties(i, FlxObject.NONE);

		_map.loadEntities(placeEntities, "entities");
    }

    function placeEntities(entityName:String, entityData:Xml):Void {
        var x:Int = Std.parseInt(entityData.get("x"));
        var y:Int = Std.parseInt(entityData.get("y"));
        if (entityName == "drone") {
            _drone.x = x;
            _drone.y = y;
        }
    }
}