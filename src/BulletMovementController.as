package
{
	import com.pblabs.engine.components.TickedComponent;
	import com.pblabs.engine.entity.PropertyReference;
	
	import flash.geom.Point;
	
	public class BulletMovementController extends TickedComponent
	{
		public var positionReference:PropertyReference;
		public override function onTick(tickRate:Number):void {
			var position:Point = owner.getProperty(positionReference);
			position.y -= 20;
			owner.setProperty(positionReference, position);
		}
	}
}