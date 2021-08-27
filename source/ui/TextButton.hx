package ui;

import flixel.text.FlxText;

class TextButton extends Button {
	private var txt:FlxText;

	public function new(text:String, textSize:Int, callback:Void->Void) {
		txt = new FlxText(0, 0, 0, text, textSize);
		txt.setFormat(AssetPaths.CheckboxFLF__ttf, textSize);
		super(txt, callback);
	}
}
