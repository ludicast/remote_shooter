package
{
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.components.TickedComponent;
	import com.pblabs.engine.entity.EntityComponent;
	import com.pblabs.engine.entity.IEntity;
	import com.pblabs.engine.entity.PropertyReference;
	import com.pblabs.rendering2D.SimpleShapeRenderer;
	import com.pblabs.rendering2D.SimpleSpatialComponent;
	
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	public class KeyboardFireComponent extends EntityComponent
	{
		public var positionProperty:PropertyReference;
		public var direction:Number = 0;
		public static var bulletId:Number = 0;
		
		protected override function onAdd():void
		{
			super.onAdd();
			PBE.mainStage.addEventListener(InteractionEvent.FIRE, keyPress);
		}
		
		protected override function onRemove():void
		{
			super.onRemove();
			PBE.mainStage.removeEventListener(InteractionEvent.FIRE, keyPress);
		}
	
		public function fireBullet(location:Point):void {
			var bullet:IEntity = PBE.templateManager.instantiateEntity("Bullet");
			bullet.setProperty(new PropertyReference("@Spatial.position"), location);

			var render:SimpleShapeRenderer = new SimpleShapeRenderer();          // Create a renderer to display our object
			render.fillColor = 0x0000FF0;
			render.isCircle = true;
			render.lineSize = 2;
			render.radius = 10;
			render.lineColor = 0x000000;
			render.scene = PBE.scene;                                            // Set which scene this is a part of
			
			render.positionProperty = new PropertyReference("@Spatial.position");
			render.rotationProperty = new PropertyReference("@Spatial.rotation");
			
			bullet.addComponent( render, "Render" );                               // Add our render component to the Hero entity with the name "Render"
		
			var mover:BulletMovementController = new BulletMovementController();
			mover.positionReference = new PropertyReference("@Spatial.position");
			bullet.addComponent(mover, "Mover");
			
			bullet.initialize("Hero" + bulletId++);                                             // Register the entity with PBE under the name "Hero"         
		
		}
		
		public function keyPress(event:InteractionEvent):void
		{
			var position:Point = owner.getProperty(positionProperty);
			fireBullet(position);
		}
	}
}