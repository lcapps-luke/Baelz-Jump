package;

import flixel.FlxG;
import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite {
	public static inline var WIDTH:Float = 1920;
	public static inline var HEIGHT:Float = 1080;

	public function new() {
		super();
		addChild(new FlxGame(1920, 1080, PlayState, 1, 60, 60, true, false));

		#if !FLX_NO_MOUSE
		FlxG.mouse.useSystemCursor = true;
		#end
	}
}
