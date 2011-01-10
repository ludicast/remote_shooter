package  
{
	import com.pblabs.box2D.CollisionEvent;
	import com.pblabs.engine.components.TickedComponent;
	import com.pblabs.engine.core.IPBObject;
	import com.pblabs.engine.core.PBGroup;
	import com.pblabs.engine.entity.IEntity;
	import com.pblabs.engine.PBE;
	import flash.events.Event;
	
	public class TimedSwitchLevelComponent extends TickedComponent
	{
		public static const SWITCH_LEVEL_EVENT:String = "SwitchLevelEvent";
		public var countDown:Number;
		public var level:int;
		protected var startCountdown:Boolean = false;
		
		public function TimedSwitchLevelComponent() 
		{
			
		}
		
		protected override function onAdd():void
		{
			super.onAdd();			
			PBE.mainStage.addEventListener(SWITCH_LEVEL_EVENT, OnSwitchLevel);
		}
		
		protected override function onRemove():void
		{
			super.onRemove();
			PBE.mainStage.removeEventListener(SWITCH_LEVEL_EVENT, OnSwitchLevel);
		}
		
		private function OnSwitchLevel(event:Event):void
		{
			startCountdown = true;
		}		
		
		public override function onTick(deltaTime:Number):void
		{
			super.onTick(deltaTime);
			if (startCountdown)
			{
				countDown -= deltaTime;
				if (countDown <= 0)
				{					
					PBE.levelManager.loadLevel(level, true);
					var root:PBGroup = PBE.rootGroup;
					var clearGroup:Array = new Array();
					for (var i:int = 0; i < root.length; ++i)
					{
						if (root.getItem(i).name != "SceneDB" &&
							root.getItem(i) as IEntity != null)
						{
							clearGroup.push(root.getItem(i));
						}
					}
					
					for each (var entity:IEntity in clearGroup)
						entity.destroy();
				}
			}
		}		
	}

}