package  
{
	import com.pblabs.engine.components.TickedComponent;
	import com.pblabs.engine.entity.PropertyReference;
	import com.pblabs.engine.PBE;
	import flash.geom.Point;
	
	public class RemoveIfOffScreenComponent extends TickedComponent
	{
		public var positionProperty:PropertyReference;
		public var sizeProperty:PropertyReference;
		
		public function RemoveIfOffScreenComponent() 
		{
			
		}
		
		public override function onTick(deltaTime:Number):void
		{
			super.onTick(deltaTime);
			var point:Point = this.owner.getProperty(positionProperty);
			var size:Point = this.owner.getProperty(sizeProperty);
			
			var halfStageWidth:int = PBE.mainStage.stageWidth / 2;
			var halfStageHeight:int = PBE.mainStage.stageHeight / 2;
			
			if (point.x + size.x / 2 < -halfStageWidth ||
				point.x - size.x / 2 > halfStageWidth ||
				point.y + size.y / 2 < -halfStageHeight ||
				point.y - size.y / 2 > halfStageHeight)
			{
				this.owner.destroy();
			}
		}
		
	}

}