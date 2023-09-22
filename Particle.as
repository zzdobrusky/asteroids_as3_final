/**
 *  Author:   Zbynek Dusatko  
 *  Date:     04/10/2008
 *  Course:   1410-EAE Asteroids - Final Project
 *  Partner:  None
 * 
 */

package Asteroids
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
     * CLASS Particle
     *
	 *  Description:
 	 *      This is main super class for any movable particle. Description below.
 	 * 
     */  
	public class Particle extends Sprite implements Movable
	{
		/**
         * OBJECT LEVEL VARIABLES
         *
		 *   simulator   	    :
		 *   location           : Current location of the particle.
		 *   velocity           : Current velocitiy of the particle.
		 *   inverse_mass       : equals 1 / mass
		 *   color              : 
         */
		public    var parent_sprite   : DisplayObjectContainer;
		public    var am_i_alive      : Boolean;
		
		protected var simulator       : Simulator;
		protected var location        : Point;
		protected var dir_vector      : Vector;	
		protected var velocity        : Vector;
		protected var angle_velocity  : Number;
		protected var inverse_mass    : Number;				
		protected var force_acting_on : Vector;
		
		/**
         * CONSTRUCTOR
         * 
		 *   PARAMETERS:
		 *                parent_sprite     : 
		 *                simulator         : 
		 *                init_loc          : Initial particle location.
		 *                init_vel          : Initial particle velocity.
		 *                mass          	: 
		 *                color             :
		 *
         *   COMMENTS:    below
         * 
         */
		public function Particle( parent_sprite  : DisplayObjectContainer,
								  simulator      : Simulator,
							  	  init_loc       : Point,
							  	  init_dir       : Vector, 
							  	  init_vel       : Vector,
							  	  init_angle_vel : Number, 
							 	  mass           : Number )
        {        	
        	this.parent_sprite = parent_sprite;
        	
        	// Add the particle to the parent object.
        	this.parent_sprite.addChild( this );
        	
        	// I am starting with beeing alive.
        	this.am_i_alive = true;
        	
        	// Set the current simulator and add me to it.
        	this.simulator = simulator;         	
        	this.simulator.add_object_to_simulation( this );
        	
	       	this.location       = init_loc;    // Set the location.
	       	this.dir_vector     = init_dir;    // Set the current direction.    	
        	this.velocity       = init_vel;    // Set the particle's velocity vector.
        	this.angle_velocity = init_angle_vel;      // Set the particle's angle velocity which is number.
        	
	      	// Set the mass.
        	this.inverse_mass = 1 / mass;
        	
        	// Set the force to be 0, 0 initially.
            this.force_acting_on = new Vector( 0, 0 );
        	
        	// Move the particle in the GUI.
        	this.update_gui(); 
        	
        	//trace( "I am inside Particle object" );
			//trace( "--------------------------------" );
			//trace( "this = " + this );
			//trace( "this.parent_sprite = " + this.parent_sprite );
			//trace( "this.parent_sprite.stage = " + this.parent_sprite.stage );
			//trace( "this.stage = " + this.stage );
			//trace( "And... this.parent = " + this.parent + "\n" );      	
        }
        
        /**
         * get_location
		 * 
		 * PARAMETERS: none
		 * 
		 * RETURNS:    Point
		 * 
		 * DESCRIPTION:
		 * 		returns the cloned location
		 */
        public function get_location() : Point
        {
        	return this.location.clone();
        }
        
        /**
         * get_velocity
		 * 
		 * PARAMETERS: none
		 * 
		 * RETURNS:    Vector
		 * 
		 * DESCRIPTION:
		 * 		returns the cloned velocity
		 */ 
        public function get_velocity() : Vector
        {
        	return this.velocity.clone();
        }
        
        /**
         * get_mass
		 * 
		 * PARAMETERS: none
		 * 
		 * RETURNS:    Number
		 * 
		 * DESCRIPTION:
		 * 		returns mass and checks if it is not zero.
		 */
		public function get_mass() : Number
		{
			// error check
			if( this.inverse_mass == 0 )
			{
				return Number.POSITIVE_INFINITY;
			}
          
			// add code for converting inverse_mass into mass and returning it
			return( 1 / this.inverse_mass );
		}
		
		/**
         * set_velocity
		 * 
		 * PARAMETERS: Vector
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		Changes the particles velocity
		 */
		public function set_velocity( vel : Vector ) : void
		{
			this.velocity = vel.clone(); 
		}
                     
		/**
         * add_force
		 * 
		 * PARAMETERS: 
		 *       f : represents force vector
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		adds force
		 */		 
		public function add_force( f : Vector ) : void
        {
			this.force_acting_on.add_to_me( f );
        }

		/**
         * clear_forces
		 * 
		 * PARAMETERS: none
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		nulls the final force vector
		 */
		public  function clear_forces() : void
        {
			this.force_acting_on.zero_me();
        }

		/**
         * move
		 * 
		 * PARAMETERS: duration
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		this is Physics engine of the whole game. below...
		 */
		public function move( duration : Number ) : void
        {
			// Checking for errors.
			if (duration <= 0.0) return;
          
			//1. location += velocity * duration;
			this.location.x += this.velocity.get_x() * duration;
			this.location.y += this.velocity.get_y() * duration;
			
			//trace( "duration = " + duration );
			
			//trace( "this.velocity.get_x() = " + this.velocity.get_x() );
			//trace( "this.velocity.get_y() = " + this.velocity.get_y() );
					
			//trace( "this.location.x = " + this.location.x );
			//trace( "this.location.y = " + this.location.y );
			
			//2. velocity += (force * duration) / mass;
			this.velocity.set_x( this.velocity.get_x() + this.force_acting_on.get_x() * duration * this.inverse_mass );
			this.velocity.set_y( this.velocity.get_y() + this.force_acting_on.get_y() * duration * this.inverse_mass );
			
			//trace( "force_acting_on.get_y() = " + this.force_acting_on.get_y() );
			//trace( "this.velocity.get_x() = " + this.velocity.get_x() );
			//trace( "this.velocity.get_y() = " + this.velocity.get_y() );
			
			// Update the particles angle in regards to its center.
			this.dir_vector.rotate_me( this.angle_velocity * duration );
			
			//4. update the gui to represent the physics
			this.update_gui();
			
			// Make sure our acter is not too far from stage.
			this.boundary_check();			
        }
        
        /**
         * hitTestObject
		 * 
		 * PARAMETERS: DisplayObject
		 * 
		 * RETURNS:    Boolean
		 * 
		 * DESCRIPTION:
		 * 		Just testing different hit test functions. The second one, probably takes into account
		 *      all pixels and alpha of two objects and tests if they overlaps, this turned out to be
		 *      to demanding on my CPU. 
		 */
        override public function hitTestObject( obj : DisplayObject ) : Boolean
        {
        	return super.hitTestObject( obj );
        	//return GUI_Collision_Detection.isColliding( this, obj, this.parent_sprite, true, 0 );
        }
        
		/**
         * boundary_check
		 * 
		 * PARAMETERS: none
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		This make sure that when any asteroid or star is too far away from the stage it
         *      automaticaly removes itself.
		 */
        public function boundary_check() : void
        {
        	// 
			if( ( this.x < -120 ) || 
        		( this.x > this.parent_sprite.stage.stageWidth + 120 ) ||
        		( this.y < -200 ) || 
        		( this.y > this.parent_sprite.stage.stageHeight + 120 ) )
        	{
        		this.remove_me();	
        	}
        }
        
        /**
         * remove_me
		 * 
		 * PARAMETERS: none
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		Will remove the particle from Logic and GUI.
		 */
        public function remove_me() : void
        {
        	//trace( "I was just removed! And I am = " + this.toString() );
        	 
        	// From GUI.
        	this.parent.removeChild( this );
        	
        	// From logic.
        	this.simulator.remove_object_from_simulation( this );
        	
        	// Let me know that I am dead.
        	this.am_i_alive = false;
        }
                
        /**
         * update_gui
		 * 
		 * PARAMETERS: none
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		this represents the GUI, utilizes the Logic parameters of the particle, its location
		 *      and velocity
		 */
		public function update_gui() : void
		{
          // Update location.
          this.x = this.location.x;
          //this.y = this.stage.stageHeight - this.location.y;
          this.y = this.parent_sprite.stage.stageHeight - this.location.y;
          //this.y = this.location.y;
          
          // Update rotation angle.
          this.rotation = this.dir_vector.get_angle();          
          
          //trace( "particle.x = " + this.x );
          //trace( "particle.y = " + this.y ); 
        }
	}
}