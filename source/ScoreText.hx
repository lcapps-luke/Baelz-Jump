package;

import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;

class ScoreText extends FlxSpriteGroup {
	private var label:String;
	private var labelText:FlxText;

	public var value(default, set):Int;

	public function new(x:Float, y:Float, label:String) {
		super(x, y);

		this.label = label;

		labelText = new FlxText();
		labelText.setFormat(AssetPaths.CheckboxFLF__ttf, 54, 0xFFFFFFFF);
		add(labelText);

		value = 0;
	}

	private function set_value(value:Int):Int {
		labelText.text = '${label}: $value';
		return this.value = value;
	}
}
