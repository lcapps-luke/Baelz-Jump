package;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

class Bar extends FlxSpriteGroup {
	private static inline var SEGMENT_RATIO:Float = 1.0 / 13.0;

	private var back:FlxSprite;
	private var front:FlxSprite;

	public var progress(default, set):Float = 0;

	public function new(x:Float, y:Float) {
		super(x, y);

		back = new FlxSprite(0, 0, AssetPaths.bar_back__png);
		add(back);

		front = new FlxSprite(48, 48);
		front.makeGraphic(313, 25, 0xA0BE0000);
		front.origin.x = 0;
		front.scale.set(0, 1);
		add(front);
	}

	private function set_progress(value:Float):Float {
		var scale = Math.round(value / SEGMENT_RATIO) * SEGMENT_RATIO;
		front.scale.set(SEGMENT_RATIO + scale, 1);

		return progress = value;
	}
}
