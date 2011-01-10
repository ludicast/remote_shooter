package
{
	import flash.events.DataEvent;
	
	public class InteractionEvent extends DataEvent
	{
		public static const LEFT:String = "left";
		public static const RIGHT:String = "right";
		public static const UP:String = "up"; 
		public static const DOWN:String = "down";
		public static const MOVEMENT:String = "movement";
		public static const STOP:String = "stop";
		public static const FIRE:String = "fire";
		
		public function InteractionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, data:String="")
		{
			super(type, bubbles, cancelable, data);
		}	
	}
}