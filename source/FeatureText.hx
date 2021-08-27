package;

import flixel.addons.text.FlxTypeText;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;

class FeatureText extends FlxSpriteGroup {
	private static inline var LINE_HOLD_TIME:Float = 6;
	private static var values:Array<Array<String>> = [
		[
			"COFFEE_COFFEE_COFFEE...",
			"INPUT_STREAM_DATA...",
			"ADJUST_MIC_VOLUME...",
			"STRETCH_1_2_3_1_2...",
			"VOCAL_WARMUP_AAAA..."
		],
		[
			"COFFEE_COFFEE_COFFEE...",
			"INPUT_STREAM_DATA...",
			"ADJUST_MIC_VOLUME...",
			"STRETCH_1_2_3_1_2...",
			"VOCAL_WARMUP_AAAA...",
			"SPEEEEEEEEEEEEEED..."
		],
		[
			"COFFEE_COFFEE_COFFEE...",
			"INPUT_STREAM_DATA...",
			"ADJUST_MIC_VOLUME...",
			"STRETCH_1_2_3_1_2...",
			"VOCAL_WARMUP_AAAA...",
			"BAE_IS_BAE.........."
		]
	];

	private var caret:FlxText;
	private var text:FlxTypeText;

	public var set(default, set):Int = 0;

	private var line:Int = 0;

	private var lineTime:Float = LINE_HOLD_TIME;

	public function new(x:Float, y:Float) {
		super(x, y);

		caret = new FlxText(0, 0, 0, ">>");
		caret.setFormat(AssetPaths.CheckboxFLF__ttf, 75, 0xFFFFFFFF);
		add(caret);

		text = new FlxTypeText(caret.width + 48, 0, 0, values[set][line]);
		text.setFormat(AssetPaths.CheckboxFLF__ttf, 75, 0xFFFFFFFF);
		text.start(0.1);
		add(text);
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		lineTime -= elapsed;
		if (lineTime < 0) {
			nextLine();
			lineTime = LINE_HOLD_TIME;
		}
	}

	public function set_set(value:Int):Int {
		line = 0;
		return set = value;
	}

	private inline function nextLine() {
		line++;
		if (line >= values[set].length) {
			line = 0;
		}

		text.resetText(values[set][line]);
		text.start(0.1);
	}
}
