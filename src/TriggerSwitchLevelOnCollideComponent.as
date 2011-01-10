package	
{
	import com.pblabs.box2D.CollisionEvent;
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.entity.EntityComponent;
	import com.pblabs.engine.entity.IEntity;
	import com.pblabs.engine.entity.IEntityComponent;
	import com.pblabs.rendering2D.SimpleSpatialComponent;
	import com.pblabs.engine.entity.PropertyReference;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class TriggerSwitchLevelOnCollideComponent extends EntityComponent
	{
		public function TriggerSwitchLevelOnCollideComponent()
		{
			super();
		}
		
		protected override function onAdd():void
		{
			super.onAdd();			
			owner.eventDispatcher.addEventListener(CollisionEvent.COLLISION_EVENT, OnCollision);
		}
		
		protected override function onRemove():void
		{
			super.onRemove();			
			owner.eventDispatcher.removeEventListener(CollisionEvent.COLLISION_EVENT, OnCollision);
		}
		
		private function OnCollision(event:CollisionEvent):void
		{
			PBE.mainStage.dispatchEvent(new Event(TimedSwitchLevelComponent.SWITCH_LEVEL_EVENT));
		}
	}
}