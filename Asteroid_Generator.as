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
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
     * CLASS Asteroid_Generator
     *
	 *  Description:
 	 *      This generates asteroids somewhere above the visible stage box and as particles
 	 *      gives them random locations, speed ( in -y direction majority ) and rotations. 
 	 * 
     */
	public class Asteroid_Generator
	{
		/**
		 * MEMBER VARIABLES
		 */
		private var parent_sprite : DisplayObjectContainer;
		private var simulator : Simulator;
		private var asteroid_chocker : Number;
		
		private const ASTEROID_MIN_SIZE : Number = 0.15; // In scale relation 0-1.
		private const ASTEROID_DRIFT_VEL : Number = -50;
		
		public function Asteroid_Generator( parent_sprite : DisplayObjectContainer, 
		                                    simulator : Simulator,
		                                    asteroid_chocker : Number )
		{
			// Set member variables.
			this.parent_sprite = parent_sprite;
			this.simulator     = simulator;	
			this.asteroid_chocker = asteroid_chocker;
			
			// First trow stars randomly over the whole stage.	
		}
		
		/**
		 * start
		 * 
		 * DESCRIPTION
		 * 		This will start generating the asteroids randomly.
		 */
		public function start() : void
		{
			this.parent_sprite.addEventListener( Event.ENTER_FRAME, generate );
		}
		
		/**
		 * stop
		 */
		public function stop() : void
		{
			this.parent_sprite.removeEventListener( Event.ENTER_FRAME, generate );
		}
		
		/**
		 * generate
		 * 
		 * DESCRIPTION
		 * 		This will be called periodically.
		 */
		public function generate( event : Event ) : void
		{			
			// First let's make sure we don't have too many asteroids.
			if( Math.random() < this.asteroid_chocker )
			{
				// Generate random location x. y doesn't need to be randomized.
				var random_x : Number = -50 + Math.random() * ( this.parent_sprite.stage.stageWidth + 100 );
			
				// Generate random scale 
				var random_scale_x : Number = Math.random() * 1.3 + this.ASTEROID_MIN_SIZE;
				var random_scale_y : Number = Math.random() * 0.1 + random_scale_x;  
				
				// Generate random velocity
				var random_vel_x : Number = 10 - Math.random() * 20;
				var random_vel_y : Number = this.ASTEROID_DRIFT_VEL + Math.random() * 20 ; // Always down direction.
				
				// Generate random angle velocity in degrees / sec.
				var random_angle_vel : Number = 30 - Math.random() * 60;
				
				var asteroid : Asteroid = new Asteroid( this.parent_sprite, 
			                            			 	this.simulator, 
			                            			 	random_scale_x,
			                            			 	random_scale_y,
			                            			 	new Point( random_x, this.parent_sprite.stage.stageHeight + 190 ),
			                            			 	new Vector( 0, -1 ), 
			                            			 	new Vector( random_vel_x, random_vel_y ),
			                            			 	random_angle_vel, 
			                            			 	3,
			                            			 	true );
			                            			
			}			
		}
	}
}