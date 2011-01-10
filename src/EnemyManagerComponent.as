package  
{
	import com.pblabs.engine.components.TickedComponent;
	import com.pblabs.engine.entity.IEntity;
	import com.pblabs.engine.entity.PropertyReference;
	import com.pblabs.engine.PBE;
	import flash.geom.Point;
	
	public class EnemyManagerComponent extends TickedComponent
	{
		public var timeToNextEnemy:Number = 0;
		public var timeBetweenEnemies:Number = 3;
		public var positionProperty:PropertyReference = new PropertyReference("@Spatial.position");
		public var sizeProperty:PropertyReference = new PropertyReference("@Spatial.size");
		
		public function EnemyManagerComponent() 
		{
			
		}
		
		public override function onTick(deltaTime:Number):void
		{
			super.onTick(deltaTime);
			
			timeToNextEnemy -= deltaTime;
			
			if (timeToNextEnemy <= 0)
			{
				var entity:IEntity = PBE.templateManager.instantiateEntity("BasicEnemy");
				var position:Point = entity.getProperty(positionProperty);
				var size:Point = entity.getProperty(sizeProperty);
				position.y = -PBE.mainStage.stageHeight / 2 - size.y / 2 + 1;
				position.x = Math.random() * (PBE.mainStage.stageWidth - size.x) - (PBE.mainStage.stageWidth - size.x) / 2;
				entity.setProperty(positionProperty, position);
				timeToNextEnemy = timeBetweenEnemies;
			}
		}
		
	}

}