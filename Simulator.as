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
  
  	/**
     * CLASS Simulator
     *
	 * DESCRIPTION:
 	 *     This is a time machine of the game with some physics in it.
 	 * 
     */      
	public class Simulator
  	{
        /**
         * OBJECT LEVEL VARIABLES
         *
         *   objects            : Represents particles
		 *   gravity     	    : Vector representing the constant gravity force.
		 *   duration           : Time interval between particle movements.
         */
      	public var   objects          : Array;
      	
      	private var  am_i_hit_testing : Boolean;
      	private var  duration         : Number;
      	private var parent_sprite     : DisplayObjectContainer;
      	
      	/**
         * CONSTRUCTOR
         * 
		 *   PARAMETERS:
		 *                parent_sprite     : 
		 *
         *   COMMENTS:    below
         * 
         */
      	public function Simulator( parent_sprite : DisplayObjectContainer )
      	{
      		this.objects = new Array();
      		this.parent_sprite = parent_sprite;
      		
      		this.am_i_hit_testing = true;
      		this.duration  = 0.1;
      	}       	 

      	/**
		 * start_simulation
		 * 
		 * PARAMETERS: parent_sprite
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		attaches the enter frame event to the parent sprite, each enter frame animate function 
		 *      is called
		 */
      	public function start_simulation() : void
      	{
          	this.parent_sprite.addEventListener( Event.ENTER_FRAME, animate );
      	}

      	/**
		 * stop_simulation
		 * 
		 * PARAMETERS: parent_sprite
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		stops the simulation by removing the enter frame event
		 */
      	public function stop_simulation() : void
      	{
        	this.parent_sprite.removeEventListener( Event.ENTER_FRAME, animate );
      	}

      	/**
		 *add_object_to_simulation
		 * 
		 * PARAMETERS: particle
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		adds the particle to objects array
		 */
      	public function add_object_to_simulation( particle : Particle ) : void
      	{
        	this.objects.push( particle );
      	}
      
      	/**
		 * remove_object_from_simulation
		 * 
		 * PARAMETERS: particle
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		removes the particle object from objects array by using splice function.
		 */  
      	public function remove_object_from_simulation( particle : Particle ) : void
      	{
      		// Also make sure to set the parent_sprite variable to null so 
      		// next it is reference it doesn't throw error.
      		//particle.parent_sprite = null;      
      		this.objects.splice( this.objects.indexOf( particle ), 1 );
      				
      	}
      	
      	/**
		 * remove_objects
		 * 
		 * PARAMETERS: Class
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		this is removes all objects of certain type
		 */
		 public function remove_objects( class_type : Class ) : void
		 {
		 	for( var i:int=0; i < this.objects.length; i++ )
		 	{
		 		var object : Particle = this.objects[ i ];
		 		if( object is class_type )
		 		{
		 			// Remove from Logic.
		 			this.remove_object_from_simulation( object );
		 			
		 			// Remove from GUI.
		 			( object as Particle ).remove_me();
		 		}
		 	} 
		 }
		 
		/**
		 * stop_hit_test
		 * 
		 * PARAMETERS: none
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		stops the hit testing
		 */
		public function stop_hit_test() : void
		{
			this.am_i_hit_testing = false;
		} 
		
		/**
		 * enable_hit_test
		 * 
		 * PARAMETERS: none
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		reenables the hit testing
		 */
		public function enable_hit_test() : void
		{
			this.am_i_hit_testing = true;
		} 
                
      	/**
		 * animate
		 * 
		 * PARAMETERS: event
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		this is our time machine
		 */
      	public function animate( e : Event ) : void
      	{
      		//trace( "animating..." );
      		
      		//trace( "Num of Objects in simulator = " + this.objects.length );
	  		
	  		// This should animate all objects at once.
	  		for( var i : int = 0; i < this.objects.length; i++ )
	  		{
	  			var current_object : Particle = this.objects[ i ];
	 	  			
	  			// Move the object.
	  			current_object.move( this.duration );
	  			
	  			
	  			if( this.am_i_hit_testing )
	  			{
	  				// Check if not hit. If yes explode.
		  			for( var j : int = 0; j < this.objects.length; j++ )
		  			{
		  				if( j != i )
		  				{
		  					var other_object : Particle = this.objects[ j ];
		  					
		  					if(	other_object.hitTestObject( current_object ) )
		  					{
		  						//trace( current_object.toString() + "just exploded!!!!" );
		  						
		  						// Lets explode both objects.
		  						// Make sure that ship doesn't explode when firing laser and detonator or 
		  						// when laser and detonator collide or detonator and detonator collide.
		  						// Also make sure that asteroids don't explode each other.
		  						if( !( current_object is Ship && other_object is Detonator ) &&
		  							!( current_object is Detonator && other_object is Ship ) &&
		  							!( current_object is Ship && other_object is Laser ) &&
		  							!( current_object is Laser && other_object is Ship ) &&
		  							!( current_object is Laser && other_object is Detonator ) &&
		  							!( current_object is Detonator && other_object is Laser ) && 
		  							!( current_object is Asteroid && other_object is Asteroid ) && 
		  							!( current_object is Star || other_object is Star ) &&
		  							( ( current_object as Particle ).am_i_alive && ( other_object as Particle ).am_i_alive ) )
		  						{
		  							( current_object as Explodable ).explode();
		  							( other_object as Explodable ).explode();	
		  						}				  						
		  					}
		  				}	  				
	  				}	
	  			}
	  			
	  			
	  			// Clear all the forces.
	  			current_object.clear_forces();
	  		}
        }
  	}
}












