package
{
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.components.TickedComponent;
	import com.pblabs.engine.entity.EntityComponent;
	import com.pblabs.engine.entity.PropertyReference;
	
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	public class KeyboardMovementComponent extends TickedComponent
	{
		public var positionProperty:PropertyReference;
		public var direction:String = InteractionEvent.STOP;
		
		protected override function onAdd():void
		{
			super.onAdd();
			PBE.mainStage.addEventListener(InteractionEvent.MOVEMENT, changeDirection);
		}
		
		protected override function onRemove():void
		{
			super.onRemove();
			PBE.mainStage.removeEventListener(InteractionEvent.MOVEMENT, changeDirection);
		}
		public function changeDirection(event:InteractionEvent):void
		{
			direction = event.data;
		}
		
		public override function onTick(deltaTime:Number):void {
			
			var position:Point = owner.getProperty(positionProperty);
			var originalPoint:Point = position.clone();
			switch (direction) {
				case InteractionEvent.LEFT:
					position.x -= 5;
					break;
				case InteractionEvent.RIGHT:
					position.x += 5;				
					break;
				case InteractionEvent.UP:
					position.y -= 5;
					break;
				case InteractionEvent.DOWN:
					position.y += 5;				
					break;
			}
			if ((position.x < (-(PBE.mainStage.width / 2) + 50)) || (position.x > ((PBE.mainStage.width / 2) - 50) ) ){
				position.x = originalPoint.x;
			}			
			if ((position.y < (-(PBE.mainStage.height / 2) + 50)) || (position.y > ((PBE.mainStage.height / 2) - 50) ) ){
				position.y = originalPoint.y;
			}					
			owner.setProperty(positionProperty, position);
		}
	
	}
}