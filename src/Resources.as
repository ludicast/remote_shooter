package
{
	import com.pblabs.engine.resource.ResourceBundle;

	public class Resources extends ResourceBundle
	{
		[Embed(source = "assets/LevelDescriptions.xml", mimeType = 'application/octet-stream')]
		public var LevelDescriptions:Class;
		
		[Embed(source = "assets/Level1.pbelevel", mimeType = 'application/octet-stream')]
		public var Level1:Class;
		
		[Embed(source = "assets/Level2.pbelevel", mimeType = 'application/octet-stream')]
		public var Level2:Class;
		
		[Embed(source="assets/player.png")]
		public var PlayerImage:Class;
		
		[Embed(source="assets/enemy.png")]
		public var EnemyImage:Class;
		
		[Embed(source="assets/bigexplosion.png")]
		public var BigExplosionImage:Class;
		
		[Embed(source="assets/background.png")]
		public var BackgroundImage:Class;
		
		[Embed(source="assets/mainscreen.png")]
		public var MainScreenImage:Class;
		
		[Embed(source = "assets/explosion.mp3")]
		public var ExplosionSound:Class;
	}
}