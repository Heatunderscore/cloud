package; 

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.FlxObject;
import flixel.addons.transition.FlxTransitionableState;
import lime.app.Application;
import openfl.utils.Assets as OpenFlAssets;

#if sys
import sys.FileSystem;
#end

class GalleryState extends MusicBeatState
{
    var curSprite:Int = 0;
    var descriptionText:FlxText;
    var curSpriteTxt:FlxText;

    var galSprite:FlxSprite;

    var folder:String = Paths.mods('images/cloud/gallery/images');

    var spritesPushed:Array<String> = [];
    var spriteAmount:Int = 0;

    var textList:Array<String> = [
        'Made by @astroisonline',//0
        'Made by u/TrexDaBomb',//1
        'Made by u/kianoo00',//2
        'Made by u/TrexDaBomb',//3
        'Made by u/flurbleblurblenaut',//4
        'Made by u/flurbleblurblenaut',//5
        'Made by NBLYTmusic',//6
        'Made by u/ricewave',//7
        'Made by Angelattes',//8
        'Made by u/CrispyBeanss',//9
        'Made by u/notlteddy',//10
        'Made by u/chica_the_great',//11
        'Made by u/chica_the_great',//12
        'Made by u/cometflamer',//13
        'Made by u/ricewave',//14
        'Made by u/Palutenoie',//15
        'Made by u/AzAva',//16
    ];

    override function create()
    {
        Application.current.window.title = Main.initTitle + ' - In Gallery';
        #if desktop
        DiscordClient.changePresence("In Gallery", null);
        #end
        var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuBG'));
		bg.scrollFactor.set();
		bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

        galSprite = new FlxSprite().loadGraphic(Paths.image('cloud/gallery/images/' + 'cloud' + curSprite));
        galSprite.scrollFactor.set();
        galSprite.updateHitbox();
        galSprite.screenCenter();
        galSprite.antialiasing = ClientPrefs.globalAntialiasing;
        add(galSprite);
        galSprite.setGraphicSize(FlxG.width, FlxG.height);

        var black:FlxSprite = new FlxSprite(0, 600).makeGraphic(FlxG.width, 200, FlxColor.BLACK);
        black.alpha = 0.7;
        add(black);

        descriptionText = new FlxText(0, 630, 0, "Hi", 32);
        descriptionText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        descriptionText.scrollFactor.set();
        descriptionText.screenCenter(X);
        add(descriptionText);

        curSpriteTxt = new FlxText(1120, 20, 0, "Hi", 32);     
        curSpriteTxt.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        curSpriteTxt.scrollFactor.set();
        curSpriteTxt.scale.set(2, 2);
        add(curSpriteTxt);

        if(FileSystem.exists(folder))
        {
            for (file in FileSystem.readDirectory(folder))
            {
                if(!spritesPushed.contains(file))
                {
                    spritesPushed.push(file);
                }
            }
        }

        spriteAmount = spritesPushed.length - 1;
    }

    override function update(elapsed:Float) 
    {
        if (controls.BACK)
			{
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new MainMenuState());
			}

        if (controls.UI_RIGHT_P)
		    {
			    FlxG.sound.play(Paths.sound('scrollMenu'));
				    changeSprite(1);
		    }
        if (controls.UI_LEFT_P)
            {
                FlxG.sound.play(Paths.sound('scrollMenu'));
                changeSprite(-1);
            } 

        descriptionText.text = textList[curSprite];
        
        
        curSpriteTxt.text = Std.string(1 + curSprite + '/' + (1 + spriteAmount));

        super.update(elapsed);  
    }

    function changeSprite(amount:Int)
    {
        curSprite += amount;
        if (curSprite < 0)  
            curSprite = spriteAmount;
        else if (curSprite > spriteAmount)
            curSprite = 0; 

        trace(curSprite);
        remove(galSprite);
        galSprite = new FlxSprite().loadGraphic(Paths.image('cloud/gallery/images/' + 'cloud' + curSprite));
        galSprite.setGraphicSize(FlxG.width, FlxG.height);
        galSprite.screenCenter();
        add(galSprite);
    }

       
   
}