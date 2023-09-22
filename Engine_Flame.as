/**
 *  Author:   Zbynek Dusatko  
 *  Date:     04/10/2008
 *  Course:   1410-EAE Asteroids - Final Project
 *  Partner:  None
 * 
 */
 
package Asteroids
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;
				
	/**
     * CLASS Engine_Flame
     *
	 *  Description:
 	 *     This is simulation of racket engine flame. It imports a tweening ( expanding and inpanding shape )
 	 *     from Flash CS3. 
 	 * 
     */  
	public class Engine_Flame extends Sprite
	{
		/**
         * OBJECT LEVEL VARIABLES
         *
		 *   flame   	        :  this will contain the Flash CS3 artwork
		 *   engine_coeficient  :  coeficcient between graphic representaion (scale) and the ship thrust 
		 *                         force
         */
		private var flame             : Sprite;
		private var engine_coeficient : Number;
		
		/**
		 * CONSTRUCTOR
		 * 
		 * 
		 * PARAMETERS:
		 *     parent_sprite     : 
		 *     init_loc          : 
		 *     rotate_me         : 
		 *     scale_x           : 
		 *     scale_y           : 
		 *     engine_coeficient :
		 * 
		 * DESCRIPTION:
		 */
		public function Engine_Flame( parent_sprite     : DisplayObjectContainer,
									  init_loc          : Point,
									  rotate_me         : Number,
									  scale_x           : Number,
									  scale_y           : Number,
									  engine_coeficient : Number )
		{
			this.engine_coeficient = engine_coeficient;
			
			// Add flash CS3 artwork.
			[Embed(source="./Resources/flame_lib.swf", symbol="flame_mc")] 				
			var run_time_class : Class; 			               
			this.flame = new run_time_class();            
            this.addChild( this.flame ); 
            
            parent_sprite.addChild( this );
            
            // Set angle.
            this.rotation = rotate_me;
            
            // Set position.
            this.x = init_loc.x;
            this.y = init_loc.y;
            
            // Set scale.
            this.scaleX = scale_x;
            this.scaleY = scale_y;           
		}
		
		/**
         * fire_me
		 * 
		 * PARAMETERS: fulage : represents the gas input to the flame
		 * 
		 * RETURNS:   
		 * 
		 * DESCRIPTION:
		 * 		For too low speeds it scales to 0
		 */
		public function fire_me( fulage : Number ) : void
		{
			if( fulage > 50 )
			{
				this.flame.scaleX = fulage * this.engine_coeficient;
			}
			else
			{
				this.flame.scaleX = 0;
			}
		}		
	}
}