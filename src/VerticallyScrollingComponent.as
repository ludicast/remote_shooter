package  
{
	import com.pblabs.engine.components.TickedComponent;
	import com.pblabs.engine.entity.PropertyReference;
	import com.pblabs.engine.PBE;
	import flash.geom.Point;
	
	public class VerticallyScrollingComponent extends TickedComponent
	{
		public var scrollSpeed:Number = 1;
		public var positionProperty:PropertyReference;
		public var sizeProperty:PropertyReference;
		
		public function VerticallyScrollingComponent() 
		{
			
		}
		
		public override function onTick(deltaTime:Number):void
		{
			super.onTick(deltaTime);
			var position:Point = this.owner.getProperty(positionProperty);
			var size:Point = this.owner.getProperty(sizeProperty);
			
			var maxVerticalMovement:int = size.y / 2 - PBE.mainStage.stageHeight / 2;
			
			if (position.y < maxVerticalMovement)
			{
				position.y += scrollSpeed * deltaTime;
			}
			else 
			{
				position.y = maxVerticalMovement;
			}
			
			this.owner.setProperty(positionProperty, position);
		}
		
	}

}