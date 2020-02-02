package;

import flixel.FlxObject;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.ogmo.FlxOgmoLoader;

class Level
{
	public var mWalls:FlxTilemap;
    public var mFloor:FlxTilemap;
 
    public var width:Int;
    public var height:Int;

    var _map:FlxOgmoLoader;
    var _objects:FlxGroup;
    var _players:FlxTypedGroup<object.Player>;

    public function new(players:FlxTypedGroup<object.Player>, objects:FlxGroup, pathname:String) {
        // super();

        _players = players;
        _objects = objects;

		// Basic level structure
		_map = new FlxOgmoLoader(pathname);
		mWalls = _map.loadTilemap("assets/images/tileset_test.png", 32, 32, "walls");
		mWalls.follow();
        for (i in 1...120)
            mWalls.setTileProperties(i, FlxObject.ANY);

        mFloor = _map.loadTilemap("assets/images/tileset_test.png", 32, 32, "floor");
		for (i in 1...120)
            mFloor.setTileProperties(i, FlxObject.NONE);

        _map.loadEntities(placeEntities, "entities");
        height = _map.height;
        width = _map.width;
    }

    function placeEntities(entityName:String, entityData:Xml):Void {
        var x:Int = Std.parseInt(entityData.get("x"));
        var y:Int = Std.parseInt(entityData.get("y"));
        if (entityName == "drone") {
            _players.add(new object.Drone(x, y));
        }
        if (entityName == "mecha") {
            _players.add(new object.Mecha(x, y));
        }
        if (entityName == "box") {
            _objects.add(new object.Box(x, y));
        }
    }
}