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
	import flash.geom.Point;
	
	/**
     * CLASS Laser
     *
	 *  Description:
 	 *     This is explodable particle. It simulates the firing of the laser gun by creating
 	 *     a long and narrow shape. It needs to be put directly on the stage and move exacly as the
 	 *     ship moves ( passsing ships location vector as a reference ). If it were put on the ship's
 	 *     sprite it would create a ray with the same length but with the ship's width.
 	 * 
     */  
	public class Laser extends Particle implements Explodable
	{
		/**
         * OBJECT LEVEL VARIABLES
         *
		 *   life_time              : sets the timeout
		 *   laser_rigged_position  : location in regards to the ship
		 *   laser_sound            : 
         */
		private var life_time             : Number;
		private var laser_rigged_position : Point;
		private var laser_sound           : Laser_Sound;
		
		/**
		 * CONSTRUCTOR
		 * 
		 * 
		 * PARAMETERS:
		 *     laser_rigged_position : 
		 *     parent_sprite         :  
		 *     simulator             : 
		 *     loc                   : 
		 *     dir                   :  
		 *     vel                   :  
		 *     angle_vel             :
		 * 
		 * DESCRIPTION:
		 * 
		 */
		public function Laser( laser_rigged_position : Point,
							   parent_sprite         : DisplayObjectContainer, 
			       			   simulator             : Simulator, 
			       			   loc                   : Point,
						       dir                   : Vector, 
						       vel                   : Vector, 
						       angle_vel             : Number )
		{    
			// Set life time.
			this.life_time = 1;	
			
			// Load laser sound and start to play.
            this.laser_sound = new Laser_Sound();
			this.laser_sound.music_play();	
		    
		    // Set the rigging position of the laser on the ship body.
		    this.laser_rigged_position = laser_rigged_position.clone();
		    
		    // Call Particle's super.
			super( parent_sprite, 
			       simulator, 
			       loc,
			       dir, 
			       vel, 
			       angle_vel,
			       5 );
			       
			//trace( "laser.x, laser.y = " + this.x + ", " + this.y );
			
			// Draw the laser ray.
		    this.create_display_list();
		    
		    //this.update_gui();
		}
		
		/**
		 * create_display_list
		 * 
		 *   PARAMETERS:   none
		 * 
		 *   RETURNS:      none
		 *
         *   COMMENTS:     below
         * 
         */
		private function create_display_list() : void
		{
			// It will draw a rectancle around the (0, 0) on x coordinate.
			this.graphics.beginFill( 0x33FF00 );
			this.graphics.drawRect( 0, -1, 450, 2 );
			this.graphics.endFill();
		}
		
		/**
		 * move
		 * 
		 *   PARAMETERS:   duration
		 * 
		 *   RETURNS:      none
		 *
         *   COMMENTS:     below
         * 
         */
		override public function move( duration : Number ) : void
		{			 
            // We don't move just give it a lifetime.
            this.life_time -= duration;
            
            if( this.life_time < 0 )
            {
            	this.remove_me();
            }
				          
			this.update_gui();
		}
		
		/**
         * explode
		 * 
		 * PARAMETERS: none
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		non functional
		 */
		public function explode() : void
		{
			// just fake to make laser not to explode...			
		}
		
		/**
         * update_gui
		 * 
		 * PARAMETERS: none
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		Needs to override the particle's function so it takes into account the ships location.
		 *      This represents the GUI, utilizes the Logic parameters of the particle, its location
		 *      and velocity
		 */
		override public function update_gui() : void
		{
          // Update location. Also take into account the rigoffshift of the laser in regards to the ship.
          this.x = this.location.x + this.laser_rigged_position.x;;
          //this.y = this.stage.stageHeight - this.location.y;
          this.y = this.parent_sprite.stage.stageHeight - this.location.y - this.laser_rigged_position.y;
          //this.y = this.location.y;
          
          //trace( "this.laser_rigged_position = " + this.laser_rigged_position.toString() );
          
          // Update rotation angle.
          this.rotation = this.dir_vector.get_angle();          
          
          //trace( "particle.x = " + this.x );
          //trace( "particle.y = " + this.y ); 
        }		
	}
}