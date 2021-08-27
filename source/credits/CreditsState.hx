package credits;

import flixel.FlxSubState;
import flixel.text.FlxText;
import openfl.Lib;
import openfl.net.URLRequest;
import ui.InteractionUtils;
import ui.TextButton;

class CreditsState extends FlxSubState {
	private var coverLink:FlxText = null;
	private var coverLinkHover:Bool = false;
	private var urlHover:FlxTextFormat;

	public function new() {
		super(0xBE000000);
		urlHover = new FlxTextFormat(0xFFFF0000);
	}

	override function create() {
		super.create();

		var title = new FlxText(0, 16, 0, "Credits");
		title.setFormat(AssetPaths.CheckboxFLF__ttf, 72, 0xFFFFFFFF);
		title.x = Main.WIDTH / 2 - title.width / 2;
		add(title);

		var yAcc = title.height + 40;

		var bae = new CreditLine("Hakos Bae");
		bae.addLink("https://www.youtube.com/channel/UCgmPnx-EEeOrZSg5Tiw7ZRQ", AssetPaths.yt_icon__png);
		bae.addLink("https://twitter.com/hakosbaelz", AssetPaths.tw_icon__png);
		bae.x = 40;
		bae.y = yAcc;
		add(bae);

		yAcc += CreditLine.SIZE * 2;
		var ani = new CreditLine("Animations by Taho (@tamagotaho)");
		ani.addLink("https://twitter.com/tamagotaho", AssetPaths.tw_icon__png);
		ani.x = 40;
		ani.y = yAcc;
		add(ani);

		yAcc += CreditLine.SIZE * 2;
		var mus = new CreditLine("Music (8bit Game Menu) by FuRi");
		mus.addLink("https://www.youtube.com/watch?v=LXMQPiXUBHA", AssetPaths.yt_icon__png);
		mus.x = 40;
		mus.y = yAcc;
		add(mus);

		yAcc += CreditLine.SIZE * 2;
		var lc = new CreditLine("Game by Luke Cann");
		lc.addLink("https://twitter.com/cannl", AssetPaths.tw_icon__png);
		lc.x = 40;
		lc.y = yAcc;
		add(lc);

		yAcc += CreditLine.SIZE * 4;
		coverLink = new FlxText();
		coverLink.setFormat(AssetPaths.CheckboxFLF__ttf, CreditLine.SIZE, 0xFFFFFFFF);
		coverLink.wordWrap = true;
		coverLink.fieldWidth = Main.WIDTH - 40;
		coverLink.text = "Characters are the property of cover corp.\nSee their fan work terms for details https://en.hololive.tv/terms";
		coverLink.x = 40;
		coverLink.y = yAcc;
		add(coverLink);

		var closeBtn = new TextButton("Close", 60, () -> {
			close();
		});
		closeBtn.x = Main.WIDTH - closeBtn.width - 20;
		closeBtn.y = Main.HEIGHT - closeBtn.height - 20;
		add(closeBtn);
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		if (coverLink == null) {
			return;
		}

		var interact = InteractionUtils.wasClicked(coverLink.getHitbox());

		if (interact == OVER && !coverLinkHover) {
			coverLink.addFormat(urlHover, 80, 110); // and artwork
			coverLinkHover = true;
		}

		if (interact == CLICK) {
			Lib.getURL(new URLRequest("https://en.hololive.tv/terms"), "_blank");
		}

		if (interact == NONE && coverLinkHover) {
			coverLink.removeFormat(urlHover);
			coverLinkHover = false;
		}
	}
}
