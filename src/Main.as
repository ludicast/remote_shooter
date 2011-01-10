package
{
	import com.ludicast.wandermote.Ambassador;
	import com.ludicast.wandermote.clients.IRemoteControllable;
	import com.pblabs.animation.AnimatorComponent;
	import com.pblabs.box2D.Box2DManagerComponent;
	import com.pblabs.box2D.Box2DSpatialComponent;
	import com.pblabs.box2D.PolygonCollisionShape;
	import com.pblabs.components.basic.EventSoundTrigger;
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.core.LevelManager;
	import com.pblabs.rendering2D.SimpleSpatialComponent;
	import com.pblabs.rendering2D.SpriteRenderer;
	import com.pblabs.rendering2D.SpriteSheetRenderer;
	import com.pblabs.rendering2D.modifier.BlurModifier;
	import com.pblabs.rendering2D.spritesheet.CellCountDivider;
	import com.pblabs.rendering2D.spritesheet.SpriteSheetComponent;
	import com.pblabs.rendering2D.ui.SceneView;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
	
	[SWF(width="1024", height="1024", backgroundColor="0x7F92FF")]
	public class Main extends Sprite implements IRemoteControllable
	{
		private function launch(type:String, data:* = null):void {
			var event:InteractionEvent = new InteractionEvent(type);
			event.data = data;
			PBE.mainStage.dispatchEvent(event);
		}
		
		private var ambassador:Ambassador;
		
		public function startConnection():void {
			var loader:URLLoader  = new URLLoader();
			loader.addEventListener(Event.COMPLETE, dataLoadedEvent);
			loader.load(new URLRequest("ambassadorData.xml"));
		}
		
		public function dataLoadedEvent(event:Event):void {
			this.ambassador = Ambassador.build(event.target.data, this, [{type: "2d", data: {message: "No message", buttons: [
				[InteractionEvent.UP],
				[InteractionEvent.LEFT, InteractionEvent.STOP, InteractionEvent.RIGHT],
				[InteractionEvent.DOWN],
				[InteractionEvent.FIRE]
			]}}]);									
		}
		
		public function recevedRemoteInteractionEvent(message:String):void {
			switch (message) {
				case InteractionEvent.FIRE:
					launch(InteractionEvent.FIRE); break;
				case InteractionEvent.LEFT:
					launch(InteractionEvent.MOVEMENT, InteractionEvent.LEFT); break;
				case InteractionEvent.RIGHT:
					launch(InteractionEvent.MOVEMENT, InteractionEvent.RIGHT); break;
				case InteractionEvent.UP:
					launch(InteractionEvent.MOVEMENT, InteractionEvent.UP); break;
				case InteractionEvent.DOWN:
					launch(InteractionEvent.MOVEMENT, InteractionEvent.DOWN); break;				
				case InteractionEvent.STOP:
					launch(InteractionEvent.MOVEMENT, InteractionEvent.STOP); break;	
			}
		}
		
		private function interceptKeyboardEvent(event:KeyboardEvent):void {
			switch (event.keyCode) {
				case Keyboard.SPACE:
					launch(InteractionEvent.FIRE); break;
				case Keyboard.LEFT:
					launch(InteractionEvent.MOVEMENT, InteractionEvent.LEFT); break;
				case Keyboard.RIGHT:
					launch(InteractionEvent.MOVEMENT, InteractionEvent.RIGHT); break;
				case Keyboard.UP:
					launch(InteractionEvent.MOVEMENT, InteractionEvent.UP); break;
				case Keyboard.DOWN:
					launch(InteractionEvent.MOVEMENT, InteractionEvent.DOWN); break;				
				case Keyboard.ENTER:
					launch(InteractionEvent.MOVEMENT, InteractionEvent.STOP); break;	
			}
		}
		
		
		public function Main()
		{
			PBE.registerType(com.pblabs.animation.AnimatorComponent);
			PBE.registerType(com.pblabs.rendering2D.SpriteSheetRenderer);
			PBE.registerType(com.pblabs.rendering2D.SimpleSpatialComponent);
			PBE.registerType(com.pblabs.rendering2D.spritesheet.SpriteSheetComponent);
			PBE.registerType(com.pblabs.rendering2D.spritesheet.CellCountDivider);
			PBE.registerType(com.pblabs.box2D.Box2DSpatialComponent);
			PBE.registerType(com.pblabs.rendering2D.SpriteRenderer);
			PBE.registerType(com.pblabs.rendering2D.ui.SceneView);
			PBE.registerType(com.pblabs.box2D.PolygonCollisionShape);
			PBE.registerType(KeyboardFireComponent);
			PBE.registerType(KeyboardMovementComponent);
			PBE.registerType(RemoveAndCreateOnCollideComponent);
			PBE.registerType(RemoveAfterTimeComponent);
			PBE.registerType(RemoveIfOffScreenComponent);
			PBE.registerType(com.pblabs.components.basic.EventSoundTrigger);
			PBE.registerType(VerticallyScrollingComponent);
			PBE.registerType(BasicEnemyLogicComponent);
			PBE.registerType(BlurModifier);
			PBE.registerType(EnemyManagerComponent);
			PBE.registerType(TriggerSwitchLevelOnCollideComponent);
			PBE.registerType(TimedSwitchLevelComponent);
			PBE.registerType(DisplayScreenAndSwitchLevelComponent);
			
			// Initialize the engine!
			PBE.startup(this);		
			
			new Resources();
			PBE.resourceManager.onlyLoadEmbeddedResources = true;
			
			// Set up the scene view.
			var sv:SceneView = new SceneView();
			PBE.initializeScene(sv, "SceneDB", null, Box2DManagerComponent);
			(PBE.spatialManager as Box2DManagerComponent).gravity = new Point(0, 0);
			
			LevelManager.instance.load("assets/LevelDescriptions.xml", 1);
			PBE.mainStage.addEventListener(KeyboardEvent.KEY_DOWN, interceptKeyboardEvent);
			
			startConnection();
		}
	}
}