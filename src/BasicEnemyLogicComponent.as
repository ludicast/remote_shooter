package  
{
	import com.pblabs.engine.components.TickedComponent;
	import com.pblabs.engine.entity.PropertyReference;
	import flash.geom.Point;
	
	public class BasicEnemyLogicComponent extends TickedComponent
	{
		public var movementSpeed:Number;
		public var positionProperty:PropertyReference;
		
		public function BasicEnemyLogicComponent() 
		{
			

		}
		
		public override function onTick(deltaTime:Number):void
		{
			super.onTick(deltaTime);
			var position:Point = this.owner.getProperty(positionProperty);
			position.y += movementSpeed * deltaTime;
			this.owner.setProperty(positionProperty, position);
		}
		
	}

}