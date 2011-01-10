package  
{
	import com.pblabs.engine.components.TickedComponent;
	import com.pblabs.engine.PBE;
	import com.pblabs.screens.ImageScreen;
	
	public class DisplayScreenAndSwitchLevelComponent extends TickedComponent
	{		
		protected static const SCREEN_NAME:String = "MainScreen";
		protected var screen:ImageScreen;
		public var levelToSwitchTo:int;
		
		public function DisplayScreenAndSwitchLevelComponent() 
		{
			super();
		}
		
		protected override function onAdd():void
		{
			super.onAdd();
			screen = new ImageScreen("assets/mainscreen.png");
			PBE.screenManager.registerScreen(SCREEN_NAME, screen);
			PBE.screenManager.push(SCREEN_NAME);
		}

		public override function onTick(deltaTime:Number):void
        {
			super.onTick(deltaTime);
			if (PBE.inputManager.isAnyKeyDown())
			{
				PBE.screenManager.pop();
				PBE.screenManager.registerScreen(SCREEN_NAME, null);
				screen = null;
				PBE.levelManager.loadLevel(levelToSwitchTo);
			}
		}
	}

}