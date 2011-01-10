package  
{
	import com.pblabs.engine.components.TickedComponent;

	public class RemoveAfterTimeComponent extends TickedComponent
	{
		public var countDown:Number;
		
		public function RemoveAfterTimeComponent() 
		{
			
		}
		
		public override function onTick(deltaTime:Number):void
		{
			super.onTick(deltaTime);
			countDown -= deltaTime;
			if (countDown <= 0)
				this.owner.destroy();
		}
		
	}

}