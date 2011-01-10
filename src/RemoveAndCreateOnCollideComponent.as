package	
{
	import com.pblabs.box2D.CollisionEvent;
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.entity.EntityComponent;
	import com.pblabs.engine.entity.IEntity;
	import com.pblabs.engine.entity.IEntityComponent;
	import com.pblabs.rendering2D.SimpleSpatialComponent;
	import com.pblabs.engine.entity.PropertyReference;
	import flash.geom.Point;
	
	public class RemoveAndCreateOnCollideComponent extends EntityComponent
	{
		public var newComponentName:String;
		public var positionProperty:PropertyReference;
		public var newComponentPositionProperty:PropertyReference;
		
		public function RemoveAndCreateOnCollideComponent()
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
			var entity:IEntity = PBE.templateManager.instantiateEntity(newComponentName);
			var thisPositionProperty:Point = this.owner.getProperty(positionProperty);
			entity.setProperty(newComponentPositionProperty, thisPositionProperty);
			this.owner.destroy();
		}
	}
}