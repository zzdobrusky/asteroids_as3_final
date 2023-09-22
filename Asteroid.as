/**
 *  Author:   Zbynek Dusatko   
 *  Date:     04/10/2008
 *  Course:   1410-EAE Asteroids
 *  Partner:  None
 * 
 */

package Asteroids
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;

	/**
     * CLASS Asteroid
     *
	 *  Description:
 	 *     This is explodable particle. It imports the flash CS3 art that is basically a shape.
 	 * 
     */     
	public class Asteroid extends Particle implements Explodable
	{
		/**
         * OBJECT LEVEL VARIABLES
         *
		 *   do_i_explode       : sets if asteroid actually exploits, if not set to false for
		 *                        children if would create endless loop
		 *   scale_x            : 
		 *   scale_y            : 		
		 *   ASTEROID_MIN_SIZE  : Minimum scale of the asteroid child after explosion
		 *   MAX_CHILD_VELOCITY : Maximum magnitude of velocity the asteroid child after explosion
         */	
		private var   do_i_explode       : Boolean;
		private var   scale_x            : Number;
		private var   scale_y            : Number;		
		private const ASTEROID_MIN_SIZE  : Number = 0.15;
		private const MAX_CHILD_VELOCITY : Number = 100;
		
		/**
		 * CONSTRUCTOR
		 * 
		 * PARAMETERS:
		 *   parent_sprite  : 
		 *   simulator      : 
		 *   scale_x        : 
		 *   scale_y        : 
		 *   init_loc       : 
		 *   init_dir       : 
		 *   init_vel       : 
		 *   init_angle_vel :  initial rotation of the asteroid
		 *   mass           : 
		 *   do_i_explode   :  sets if asteroid exploits or not
		 * 
		 * DESCRIPTION:
		 * 
		 */
		public function Asteroid( parent_sprite  : DisplayObjectContainer, 
							  	  simulator      : Simulator,
							  	  scale_x        : Number,
							  	  scale_y        : Number,
							  	  init_loc       : Point,
							  	  init_dir       : Vector,
							  	  init_vel       : Vector,
							  	  init_angle_vel : Number,
							  	  mass           : Number,
							  	  do_i_explode   : Boolean )
		{
			// Set the flag for explosion.
			this.do_i_explode = do_i_explode;
			
			// Add flash CS3 artwork.
			[Embed(source="./Resources/asteroid_lib.swf", symbol="asteroid_mc")] 				
			var run_time_class : Class; 			               
			var asteroid : Sprite = new run_time_class();            
            this.addChild( asteroid ); // Add it to this Asteroid class. This should center it around (0,0).
			
			// Call the super constructor of Particle class.
			super( parent_sprite,
				   simulator,
				   init_loc.clone(),
				   init_dir.clone(), 
				   init_vel.clone(), 
				   init_angle_vel,
				   mass );	
            
            // Set the scale.
            this.scale_x = scale_x;
            this.scale_y = scale_y;
            
            // Scale it.
            asteroid.scaleX = this.scale_x; 
            asteroid.scaleY = this.scale_y;
		}
		
		/**
         * explode
		 * 
		 * PARAMETERS: none
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		Will explode the particle. Each child has to implement its own way 
		 *      of exploding.
		 */
        public function explode() : void
        {
        	//trace( "this.do_i_explode = " + this.do_i_explode );
       	
        	// Lest split.
        	if( this.do_i_explode )
        	{  		
        		// Lets make the payload after explosion random.
        		var payload : int = Math.random() * 5 + 2;
				for( var i:int=0; i < payload; i++ )
				{
					// Randomize the velocity.
					var child_vel : Vector = new Vector( Math.random() * this.MAX_CHILD_VELOCITY + 5, 0.0 );
					child_vel.rotate_me( Math.random() * 360.0 ); // Randomize the angle.
				
					//trace( " inside explode, scale = " + this.scale );
					
					var average_scale : Number = ( this.scale_x + this.scale_y ) / 2;
					
					var scale_x : Number = Math.random() * average_scale / payload + this.ASTEROID_MIN_SIZE;
					var scale_y : Number = Math.random() * 0.1 * average_scale / payload + scale_x;
					
					var after_explode_location : Point = this.location.clone();
					
					// Jump away after explosion.
					after_explode_location.x += child_vel.get_x()/Math.abs( child_vel.get_x() ) * 5;
					after_explode_location.y += child_vel.get_y()/Math.abs( child_vel.get_y() ) * 5;
					
					// Randomize the angle velocity.
					var angle_vel : Number = 150 - Math.random() * 300;	
				
					//trace( "child_vel = " + child_vel.toString() );				    
				     
					var child_asteroid : Asteroid = new Asteroid ( this.parent_sprite, 
							  	  							   	   this.simulator,
							  	  							   	   scale_x,
							  	  							   	   scale_y,
							  	  							   	   after_explode_location,
							  	  							   	   new Vector(),
							  	  							       child_vel,
							  	  							       angle_vel,
							  	  							       4,
							  	  							       false );	// Make sure that next generation doesn't explode
				
				}
        	}
        
			// This removes from GUI and Logic.
        	super.remove_me();        	
        }
	}
}