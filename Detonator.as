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
	import flash.display.GradientType;
	import flash.geom.Matrix;
	import flash.geom.Point;

	/**
     * CLASS Detonator
     *
	 *  Description:
 	 *     This is explodable particle. It creates a circle shape with radial gradient and starts the timer.
 	 *     When times is up it simulates the explosion by changing its scale gradually and then also changing
 	 *     its alpha gradually.
 	 * 
     */  
	public class Detonator extends Particle implements Explodable
	{
		/**
         * OBJECT LEVEL VARIABLES
         *
		 *   current_life_time         : this times the remaining lifetime of the detonator
		 *   racket_rigged_position    : location in regards to the ship
		 *   am_i_detonated            : 
		 *   am_i_hit                  : 
		 *   detonator_sound           : 
		 *   life_time                 : this sets the whole lifetime from launching to diminishing
		 *   fuse_time                 : if detonator doesn't hit anything it selfexplodes 
		 *                               after this period
		 *   die_out_time              : this times the time the detonator diminishes
		 *   color                     : 
		 *   on_remove_fce             : when detonator diminishes it calls this functions. Good for
		 *                               exploding the ship and call game_over function.		
		 *   explode_time              : this times the time the detonator expands itself
         */
		private var current_life_time      : Number;
		private var racket_rigged_position : Point;
		private var am_i_detonated         : Boolean;
		private var am_i_hit               : Boolean;
		private var detonator_sound        : Detonator_Sound;
		private var life_time              : Number;
		private var fuse_time              : Number;		
		private var die_out_time           : Number;
		private var color                  : uint;
		private var on_remove_fce          : Function;
		
		private var explode_time           : Number = 0.4;
		/**
		 * CONSTRUCTOR
		 * 
		 * PARAMETERS:
		 *     racket_rigged_position   : 
		 *     parent_sprite  			: 
		 *     simulator                : 
		 *     init_loc                 : 
		 *     init_dir      			: 
		 *     init_vel       			: 
		 *     life_time      			: 
		 *     fuse_time      			: 						  
		 *     explode_time   			: 
		 *     die_out_time   			: 			      
		 *     color          			: 
		 *     on_remove_fce  			:
		 * 
		 * DESCRIPTION:
		 * 
		 */
		public function Detonator( racket_rigged_position : Point,
								   parent_sprite          : DisplayObjectContainer, 
							       simulator              : Simulator, 
							       init_loc               : Point,
							       init_dir               : Vector, 
							       init_vel               : Vector,
							       life_time              : Number = 13,
							       fuse_time              : Number = 7,							  
							       explode_time           : Number = 0.4,
							       die_out_time           : Number = 6.6,							      
							       color                  : uint = 0xFF3300,
							       on_remove_fce          : Function = null )
		{		
			       
			// Set member variable.
			this.life_time         = life_time;
			this.current_life_time = this.life_time;
			this.fuse_time         = fuse_time;
			this.explode_time      = explode_time;
			this.die_out_time      = die_out_time;
			this.color             = color;
			this.on_remove_fce     = on_remove_fce;
			
			// Declare the detonation sound.
			this.detonator_sound = new Detonator_Sound;
			
			// Set detonation flag.
			this.am_i_detonated = false;
			this.am_i_hit = false;
			 
			// Set the rigging position of the laser on the ship body.
		    this.racket_rigged_position = racket_rigged_position.clone();      
			
		    //TODO: implement function
			super( parent_sprite, 
			       simulator, 
			       init_loc.clone(),
			       init_dir.clone(), 
			       init_vel.clone(), 
			       0,
			       5 );
			       
			// Draw the round.
		    this.create_display_list( new Array( 1, 0 ) );		    
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
		private function create_display_list( alphas: Array ) : void
		{
			// It will draw a rectancle around the (0, 0) on x coordinate.
			//this.graphics.beginFill( 0xFF0000 );
			var colors:Array = [ color, color ];//[0xFF4422, 0xFF4422 ];[ 0xFF33FF, 0xFF33FF ];//
			//var alphas:Array = [0,1];
			var ratios:Array = [0, 255];
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox( 20, 20, 0, -10, -10 );
			
			
			
			this.graphics.beginGradientFill(GradientType.RADIAL,
			                                colors,
			                                alphas,
			                                ratios,
			                                matrix);
			this.graphics.drawCircle( 0, 0, 20 );
			this.graphics.endFill();
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
		override public function move( duration : Number ) : void
        {
			// Checking for errors.
			if (duration <= 0.0) return;
			
			this.current_life_time -= duration;
			
			//trace( "this.die_out_time = " + this.die_out_time );
            
            // Explode the detonator when fuse out.
            if( this.current_life_time <= this.fuse_time && !this.am_i_detonated && !this.am_i_hit )
            {     	
            	//trace( "change detonator" );
            	
            	this.parent_sprite.removeChild( this );
            	this.create_display_list( new Array( 0, 0.2 ) );
            	this.parent_sprite.addChild( this );
            	this.velocity.zero_me();
            	
            	this.am_i_detonated = true;
            	this.am_i_hit = true;
            	
            	// Play the sound.
            	this.detonator_sound.music_play();
            	//var REST_OF_LIFE : Number = this.current_life_time;
            }
            
            // Explode.
            if( this.am_i_detonated && this.current_life_time > this.die_out_time )
            {
            	 this.scaleX *= 1.7;
            	 this.scaleY *= 1.7;
            	 
            }
          	
          	if( this.current_life_time < this.die_out_time )
            {
            	this.alpha = this.current_life_time / this.die_out_time;
            }
          	
          	if( this.current_life_time < 0 )
            {
            	this.remove_me();
            	//trace( "I am removed now!" );
            }
            
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
		override public function update_gui() : void
		{
          // Update location. Also take into account the rigoffshift of the laser in regards to the ship.
          this.x = this.location.x + this.racket_rigged_position.x;;
          //this.y = this.stage.stageHeight - this.location.y;
          this.y = this.parent_sprite.stage.stageHeight - this.location.y - this.racket_rigged_position.y;
          //this.y = this.location.y;
          
          //trace( "this.racket_rigged_position = " + this.racket_rigged_position.toString() );
          
          // Update rotation angle.
          this.rotation = this.dir_vector.get_angle();          
          
          //trace( "particle.x = " + this.x );
          //trace( "particle.y = " + this.y ); 
        }
		
		/**
         * explode
		 * 
		 * PARAMETERS: none
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		when hit it removes the fuse time and explodes instantly
		 */
		public function explode() : void
		{
			if( !this.am_i_hit )
			{
				this.current_life_time = this.fuse_time;
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
		 * 		overrides the particle's remove function in the way that it adds a function call.
		 *      Good when the ship is exploded and calls game_over function.
		 */
		override public function remove_me() : void
		{
			if( this.on_remove_fce != null )
			{
				this.on_remove_fce();
			}
						
			super.remove_me();			
		}		
	}
}