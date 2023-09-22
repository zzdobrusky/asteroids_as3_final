/**
 *  Author:   Zbynek Dusatko  
 *  Date:     04/10/2008
 *  Course:   1410-EAE Asteroids - Final Project
 *  Partner:  None
 * 
 *  This populates the entire state by stars. It utilizes the Star class.
 *  You can set how many stars to be put on the stage, the maximum star radius, 
 *  the percentage of transparent stars, of the twinking stars, of the red stars and 
 *  of the blue stars.
 * 
 */

package Asteroids
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
     * CLASS Sky_Generator
     *
	 *  Description:
 	 *      This creates the simulation of moving star sky as a background. It generates stars somewhere
 	 *      above the visible stage box and as particles gives them random locations,  constant y-speed and
 	 *      x-speed = 0. Also the radius, transparency, twinking and color of the stars are calculated at
 	 *      random.
 	 * 
     */                   
	public class Sky_Generator
	{
		/**
		* Class Member Variables
		* 
		*   star_chocker                 :  Number of stars to be put on the stage.
		*   max_star_radius              :  This sets max radius a star can have. Each star radius
		*                                   is random btwn 1 and max_star_radius.
		*   star_transparency_percentage :  Sets the percentage of transparent stars. Again each star
		*                                   transparency is random btwn 0 and 1.
		*   blue_star_percentage         :  Sets the percentage of blue stars.
		*   red_star_percentage          :  Sets the percentage of red stars.
		*   blinking_star_percentage     :  Sets the percentage of twinking stars.		
		*   star_red_color               :  Sets the red star color.
		*   star_blue_color				 :  Sets the blue star color.
		*
		*/			   
		public var star_chocker                 : Number;
		public var max_star_radius              : int = 2;
		public var star_transparency_percentage : int = 10;
		public var blue_star_percentage         : int = 10;
		public var red_star_percentage          : int = 10;
		public var blinking_star_percentage     : int = 10;		
		public var star_red_color               : int = 0xE74907;
		public var star_blue_color              : int = 0x8BAEFC;
	
		private var parent_sprite               : DisplayObjectContainer;
		private var simulator                   : Simulator;
		private var sky_index                   : int;
		private const SKY_DRIFT_VEL             : Number = -20;

		/**
         * CONSTRUCTOR
         * 
		 *   PARAMETERS:
		 *         parent_sprite :
		 *         simulator     : 
		 *         star_chocker  :  controls the number of stars on the stage
		 *
         *   COMMENTS:    below
         * 
         */
		public function Sky_Generator( parent_sprite : DisplayObjectContainer,
									   simulator     : Simulator,
									   star_chocker  : Number = 0.4 ) 
		{
			// Set the member variables.
			this.parent_sprite = parent_sprite;
			this.simulator     = simulator;
			this.star_chocker  = star_chocker;
			
			// Set the z-depth.
			///this.sky_index = this.parent_sprite.
			
			// First throw the stars randomly over the whole stage.
			for( var i:int=0; i< 50; i++ )
			{				
				// Put some stars on the stage. They shoudl be moving down.
				var a_star : Star = new Star( this.parent_sprite,
											  this.simulator,
										      new Point( Math.random() * this.parent_sprite.stage.stageWidth, 
										                 Math.random() * this.parent_sprite.stage.stageHeight ), // Randomize the star position.
										      new Vector( 0, this.SKY_DRIFT_VEL ),
										      this.blinking_star_percentage,
										      this.blue_star_percentage,
										      this.star_blue_color,
										      this.red_star_percentage,
										      this.star_red_color,
										      this.max_star_radius,
										      this.star_transparency_percentage );
			}  
		}
		
		/**
		 * start
		 * 
		 * PARAMETERS: none
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION
		 * 		This will start the on enter frame event.
		 */
		public function start() : void
		{
			this.parent_sprite.addEventListener( Event.ENTER_FRAME, this.throw_stars );
		}
		
		/**
		 * stop
		 * 
		 * PARAMETERS: none
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION
		 * 		This will stop the on enter frame event.
		 */
		public function stop() : void
		{
			this.parent_sprite.removeEventListener( Event.ENTER_FRAME, this.throw_stars );
		}
		
	   /**
		* throw_stars
		* 
		*   This draw stars on the stage.
		*
		*   Parameters
		*   star_chocker                 :  Number of stars to be put on the stage.
		*   max_star_radius              :  This sets max radius a star can have. Each star radius
		*                                   is random btwn 1 and max_star_radius.
		*   star_transparency_percentage :  Sets the percentage of transparent stars. Again each star
		*                                   transparency is random btwn 0 and 1.
		*   blue_star_percentage         :  Sets the percentage of blue stars.
		*   red_star_percentage          :  Sets the percentage of red stars.
		*   blinking_star_percentage     :  Sets the percentage of twinking stars.		
		*   star_red_color               :  Sets the red star color.
		*   star_blue_color				 :  Sets the blue star color.
		*
		*   Returns                      :  Nothing
		* 
		*   DESCRIPTION :
		*        Randomly throws stars somewhere above the stage and gives them all the same -y speed
		*        this simulates the moving star sky.            
		*/
		public function throw_stars( e : Event ) : void
		{
			
			// First let's make sure we don't have too many asteroids.
			if( Math.random() < this.star_chocker )
			{				
				// Put some stars on the stage. They shoudl be moving down.
				var a_star : Star = new Star( this.parent_sprite,
											  this.simulator,
										      new Point( Math.random() * this.parent_sprite.stage.stageWidth, 
										                 Math.random() * 100 + this.parent_sprite.stage.stageHeight ), // Randomize the star position.
										      new Vector( 0, this.SKY_DRIFT_VEL ),
										      this.blinking_star_percentage,
										      this.blue_star_percentage,
										      this.star_blue_color,
										      this.red_star_percentage,
										      this.star_red_color,
										      this.max_star_radius,
										      this.star_transparency_percentage );
			}
		}
	}
}
