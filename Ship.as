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
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;

	/**
     * CLASS Ship
     *
	 *  Description:
	 *      The ship has a lot of parts hence why there are so many variables.
 	 *      This imports a ship's MovieClip from Flash CS3 and builds a various parts around it.
 	 * 		Since this is to simulate the spaceship it has a changing nozzle flames (in regards to the
 	 *      thrust forces), fires the laser and seismic charges, when beeing hit it creates a protectin
 	 *      force field around itself, gun's and force field control strips. Finaly when the force field 
 	 *      is exhausted and being hit by asteroid it explodes (reuses detonator class and removes itself)
 	 *      and calls the Game_User_Interface's game_over function. 
 	 * 
     */
	public class Ship extends Particle implements Explodable
	{
		/**
         * OBJECT LEVEL VARIABLES
         *
		 *   user_interface             : needs the reference so it can call its game_over function
		 *   mouse_vector               : 
		 *   thrust_force               : vector representing the trust force
		 *   time_to_charge_laser       : 
		 *   time_to_charge_detonator   : 
		 *   force_field                :
		 *   force_field_count          : holds the current number of hits to the force field
		 *   private var alarm_sound    :
		 *   nozzle_main                : holds the flames
		 *   nozzle_main_left           : 
		 *   nozzle_main_right          : 
		 *   nozzle_nose_left           : 
		 *   nozzle_nose_right          : 
		 *   nozzle_side_left           : 
		 *   nozzle_side_right 		    : 
		 *   laser_recharge_strip       : 
		 *   detonator_recharge_strip   : 
		 *   force_field_recharge_strip : 
		 *   ship_hit_counter           : holds all hits that ships encounters
		 *   alarm_message              : 
		 *   ENGINE_COEFICIENT          : this relates the mouse vector to the thrust vector, the actual
		 *                                mouse vector is too big
		 *   LASER_RECHARGE_TIME        : 
		 *   DETONATOR_RECHARGE_TIME    : 
		 *   MESSAGE_PULSE_TIME         : alarm message was supposed to blink
		 *   FORCE_FIELD_MAX_COUNT      : max of hits before the force field is turned off
		 *   THRUST_ENHANCER            : 
		 *   MAX_THRUST                 : this limits the max of thrust force
		 *   FRICTION                   : this represents the friction, it lessens the velocity vector
		 *                                if not used the ship would be like on a spring and would never 
		 *                                actually stop when mouse not moving.
         */
		private var user_interface             : Game_User_Interface;
		private var mouse_vector               : Vector;
		private var thrust_force               : Vector;
		private var time_to_charge_laser       : Number;
		private var time_to_charge_detonator   : Number;
		private var alarm_sound                : Alarm_Sound;
		private var start_engine_sound         : Start_Engine_Sound;
		private var is_start_engine_sound_played            : Boolean;
		private var force_field                : Force_Field;
	    private var force_field_count          : Number;	
		private var nozzle_main                : Engine_Flame;
		private var nozzle_main_left           : Engine_Flame;
		private var nozzle_main_right          : Engine_Flame;
		private var nozzle_nose_left           : Engine_Flame;
		private var nozzle_nose_right          : Engine_Flame;
		private var nozzle_side_left           : Engine_Flame;
		private var nozzle_side_right 		   : Engine_Flame;
		private var laser_recharge_strip       : Recharge_Strip;
		private var detonator_recharge_strip   : Recharge_Strip;
		private var force_field_recharge_strip : Recharge_Strip;
		private var ship_hit_counter           : uint;
		private var alarm_message              : Text_Message;
		private var force_field_max_count      : Number;
		
		private const ENGINE_COEFICIENT        : Number = 0.006;
		private const LASER_RECHARGE_TIME      : Number = 7; 
		private const DETONATOR_RECHARGE_TIME  : Number = 30;
		private const MESSAGE_PULSE_TIME       : Number = 6; 
		private const THRUST_ENHANCER          : Number = 2.3;
		private const MAX_THRUST               : Number = 300;
		private const FRICTION                 : Number = 8; // Friction in %.
		
		/**
		 * CONSTRUCTOR
		 * 
		 * 
		 * PARAMETERS:
		 *    parent_sprite  : 
		 *    simulator      : 
		 *    user_interface : 
		 *    init_loc       : 
		 *    init_dir       : 
		 *    init_vel       : 
		 *    init_angle_vel : 
		 *    mass           : 
		 * 
		 * DESCRIPTION:
		 * 
		 */
		public function Ship( parent_sprite  		: DisplayObjectContainer, 
							  simulator      		: Simulator,
							  user_interface 		: Game_User_Interface,
							  init_loc       		: Point,
							  init_dir       		: Vector,
							  init_vel       		: Vector,
							  init_angle_vel 		: Number,
							  mass           		: Number,
							  force_field_max_count : Number )
		{
			// Call the super constructor of Particle class.
			super( parent_sprite,
				   simulator,
				   init_loc.clone(),
				   init_dir.clone(), 
				   init_vel.clone(),
				   init_angle_vel, 
				   mass );	
				   
			// Set member variables.
			this.user_interface           = user_interface;
			this.force_field              = new Force_Field( this );
			this.force_field_count        = 0;
			this.time_to_charge_laser     = 0;
			this.time_to_charge_detonator = 0;
			this.ship_hit_counter         = 0; 
			this.force_field_max_count    = force_field_max_count;
			this.alarm_sound              = new Alarm_Sound();
			this.start_engine_sound       = new Start_Engine_Sound();
			this.is_start_engine_sound_played          = false;
			
			// Create recharge strips.
			this.laser_recharge_strip = new Recharge_Strip( parent_sprite,
															0,
															this.LASER_RECHARGE_TIME,
															0x00FF00,
															new Point( 15, parent_sprite.stage.stageHeight - 10 ) ); 
			this.detonator_recharge_strip = new Recharge_Strip( parent_sprite,
															    0,
															    this.DETONATOR_RECHARGE_TIME,
															    0xFF0000,
															    new Point( 28, parent_sprite.stage.stageHeight - 10 ) );
			this.force_field_recharge_strip = new Recharge_Strip( parent_sprite,
															      0,
															      this.force_field_max_count,
															      0xFFFFFF,
															      new Point( 41, parent_sprite.stage.stageHeight - 10 ) );										
			
			// Main thrust engine.
			this.nozzle_main = new Engine_Flame( this,
			                                     new Point( -45, 0 ),
			                                     0,
			                                     0.15,
			                                     0.15,
			                                     this.ENGINE_COEFICIENT );
			                                     
			// Next to main thrust engine.
			this.nozzle_main_left = new Engine_Flame( this,
			                                     	  new Point( -33, -13 ),
			                                          0,
			                                          0.08,
			                                          0.07,
			                                          this.ENGINE_COEFICIENT );
			this.nozzle_main_right = new Engine_Flame( this,
			                                     	   new Point( -33, 13 ),
			                                           0,
			                                           0.08,
			                                           0.07,
			                                           this.ENGINE_COEFICIENT );
			                                     
			// Break thrust engines.
			this.nozzle_nose_left = new Engine_Flame( this,
			                                     	  new Point( 34, -7 ),
			                                          160,
			                                          0.08,
			                                          0.06,
			                                          this.ENGINE_COEFICIENT );
			this.nozzle_nose_right = new Engine_Flame( this,
			                                           new Point( 34, 7 ),
			                                           -160,
			                                           0.08,
			                                           0.06,
			                                           this.ENGINE_COEFICIENT );
			                                     
			// Side thrust engines.
			this.nozzle_side_left = new Engine_Flame( this,
			                                          new Point( 3, -15 ),
			                                          90,
			                                          0.08,
			                                          0.06,
			                                          this.ENGINE_COEFICIENT );                   
			this.nozzle_side_right = new Engine_Flame( this,
			                                           new Point( 3, 15 ),
			                                           -90,
			                                           0.08,
			                                           0.06,
			                                           this.ENGINE_COEFICIENT );
			
			
			// Add flash CS3 artwork.
			[Embed(source="./Resources/spaceship_lib.swf", symbol="spaceship_mc")] 				
			var run_time_class : Class; 			               
			var ship : Sprite  = new run_time_class();            
            this.addChild( ship ); // Add it to this Ship class. This should center it around (0,0).						
			
			// Declare the thrust and break forces.
			this.thrust_force = new Vector( 0, 0 );
			
			// Declare the mouse vector.
			this.mouse_vector = new Vector( 0, 0 );
            
            // Scale it.
            ship.scaleX = .2; 
            ship.scaleY = .2;
     			        		
	        // Start listener for pressed keyboard keys.
	        this.parent.stage.addEventListener(	KeyboardEvent.KEY_DOWN, this.key_down_handler );
	        // Start listener for left mouse down.
	        this.parent.stage.addEventListener( MouseEvent.MOUSE_DOWN,  this.mouse_down_handler );
		}
		
		/**
         * key_down_handler
		 * 
		 * PARAMETERS: event
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		launches the detonator (seismic charges)
		 */
		private function key_down_handler( event : KeyboardEvent ) : void
		{
			// Launching the detonator. Lets make sure it is charged.
			if( event.keyCode == Keyboard.SPACE && this.time_to_charge_detonator <= 0 )
			{
				this.launch_detonator();
				this.time_to_charge_detonator = this.DETONATOR_RECHARGE_TIME;
			}
		}
		
		/**
         * mouse_down_handler
		 * 
		 * PARAMETERS: event
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		fires the laser
		 */
		private function mouse_down_handler( event : MouseEvent ) : void
		{													      
			// First make sure the laser is charged
			if( this.time_to_charge_laser <= 0 )
			{
				this.fire_laser();
				this.time_to_charge_laser = this.LASER_RECHARGE_TIME;
			}
												   
		}
		
		/**
         * launch_detonator
		 * 
		 * PARAMETERS: none
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		launches the detonator (seismic charges)
		 */
		private function launch_detonator() : void
		{			
			// Add the ships's velocity to racket's.
			var detonator_vel : Vector = this.dir_vector.clone();
			detonator_vel.scale_me( -50 );
			
			detonator_vel.add_to_me( this.velocity );
			
			// Set the location where to shoot from.
			var racket_rigged_position : Point = new Point( 0, 50 );
			
			var racket : Detonator = new Detonator( racket_rigged_position,
											  this.parent_sprite, 
										   	  this.simulator, 
										      this.location.clone(),
										      this.dir_vector.clone(), 
										      detonator_vel );
			
			//trace( "Racket just launched! racket.x , racket.y = " + racket.x + ", " + racket.y );
		}
		
		/**
         * fire_laser
		 * 
		 * PARAMETERS: none
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		fires the laser
		 */
		private function fire_laser() : void
		{			
			// Rig the laser to the nose of the ship.
			var laser_rigged_position : Point = new Point( 0, 50 );
			
			// Create the laser and shoot.
			var laser : Laser = new Laser( laser_rigged_position,
										   this.parent_sprite, 
										   this.simulator, 
										   this.location,
										   this.dir_vector, 
										   this.velocity.clone(),
										   this.angle_velocity );
										   
		    //trace( "Laser just fired! Laser.x , Laser.y = " + laser.x + ", " + laser.y );
		}
		
		/**
		 * update_thrust_force
		 * 
		 *   PARAMETERS:   none
		 * 
		 *   RETURNS:      none
		 *
         *   COMMENTS:     below
         * 
         */
        public function update_thrust_force() : void
        {            
          		// Create two vectors representing directions of the ship and the mouse vector in relation to
          			// the logic origin (0,0).   
                	this.mouse_vector = new Vector( this.parent_sprite.mouseX, 
                									this.parent.stage.stageHeight - this.parent_sprite.mouseY ); 
	                this.thrust_force.set_x( this.location.x );
	                this.thrust_force.set_y( this.location.y );
	                
	                this.thrust_force.subtract_from_me( this.mouse_vector );
	                this.thrust_force.scale_me( - this.THRUST_ENHANCER ); 
	                
	                // Check if not bigger and if yes set to max thrust.
	                if( this.thrust_force.get_magnitude() > this.MAX_THRUST )
	                {
	                	this.thrust_force.normalize();
	                	this.thrust_force.scale_me( this.MAX_THRUST );
	                } 
	                
	                // Change the nozzle fires accordingly. 
	                // Main nozzles.
	                this.nozzle_main.fire_me( this.thrust_force.get_y() );
	                this.nozzle_main_left.fire_me( this.thrust_force.get_y() );
	                this.nozzle_main_right.fire_me( this.thrust_force.get_y() );	
	                
	                // Main nozzles.
	                this.nozzle_nose_left.fire_me( -this.thrust_force.get_y() );
	                this.nozzle_nose_right.fire_me( -this.thrust_force.get_y() );
	                
	                // Main nozzles.
	                this.nozzle_side_left.fire_me( this.thrust_force.get_x() );
	                this.nozzle_side_right.fire_me( -this.thrust_force.get_x() );
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
		override public function move( duration:Number ) : void
		{			 
            // Only if mouse not over the ship.
            if( this.mouseX > this.width/2 ||
                this.mouseX < -this.width/2 ||
                this.mouseY > this.height/2 ||
                this.mouseY < -this.height/2 )
            {
                // Calculate and add the thrust force.                       	
            	this.add_force( this.thrust_force );  
            	this.update_thrust_force(); 
            	
            	// Play the start engine sound. 
            	if( !this.is_start_engine_sound_played ) 
            	{
            		this.is_start_engine_sound_played = true;
            		this.start_engine_sound.music_play();
            	}          	                   	
            } 
            else
            {
            	// Set the thrust force to 0.
            	this.thrust_force.zero_me();
            	this.update_thrust_force();
            	
            	// Stop any start engine sound if not played.
            	if( this.is_start_engine_sound_played )
            	{
            		this.is_start_engine_sound_played = false;
            		this.start_engine_sound.music_stop();
            	} 
            	
            	// Play the stop engine sound. 
            }
            
            // Laser is recharging
            if( this.time_to_charge_laser > 0 )
            {
            	this.time_to_charge_laser -= duration;
            	// Also update the laser strip.
            	this.laser_recharge_strip.update( this.time_to_charge_laser );
            }
			
			// Detonator is recharging.
			if( this.time_to_charge_detonator > 0 )
			{
				this.time_to_charge_detonator -= duration;
				// Also update the detonator strip.
            	this.detonator_recharge_strip.update( this.time_to_charge_detonator );
			} 
			
			// Force field.
			if( this.force_field.am_i_on )
			{
				this.force_field.time_to_turn_off -= duration;
			}
			
			if( this.force_field.time_to_turn_off <= 0 )
			{
				this.force_field.turn_me_off();
				
			}
					
 			//trace( "time_to_charge_laser, time_to_charge_detonator = " + this.time_to_charge_laser + ", " + this.time_to_charge_detonator );
            
            // Introduce friction. Reduce the velocity in the X and Y direction by %.
            // This will keep the ship selfstabilizing.
			this.velocity.set_x( ( 1 - this.FRICTION / 100 ) * this.velocity.get_x() );
			this.velocity.set_y( ( 1 - this.FRICTION / 100 ) * this.velocity.get_y() );
            
            // Call Particle's super move.
			super.move( duration );
		}
		
		/**
         * explode
		 * 
		 * PARAMETERS: none
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		checks if force field is on and counts and checks the number of hits
		 *      and branches the decisions from there.
		 */
		public function explode() : void
		{						
			trace( "hit counter = " + this.ship_hit_counter );
			
			if( !this.force_field.am_i_on )
			{				
				// Track the number of hits.
				this.ship_hit_counter++;
				
				if( this.force_field_count < this.force_field_max_count )
				{
					this.force_field.turn_me_on();
					// Also update the force field strip.
					this.force_field_count++;
					trace( "force_field_count = " + force_field_count );				
	            	this.force_field_recharge_strip.update( this.force_field_count );   
				}	
				
				if( this.ship_hit_counter == this.force_field_max_count )
				{
					this.create_alarm();
				}
				
				if( this.ship_hit_counter > this.force_field_max_count )
				{
					this.explode_ship();
				}					         	
			}				
		}

		
		/**
         * create_alarm
		 * 
		 * PARAMETERS: none
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		creates green alarm message at the buttom of the stage
		 */
		private function create_alarm() : void
		{			
			trace( "inside create_alarm()" );
			
			// Create alarm message and set its alpha to 0;												      
			this.alarm_message = new Text_Message( this.parent_sprite,
			                                       "Warning! No force field!",
			                                       new Point( this.parent_sprite.stage.stageWidth / 2,
			                                                  this.parent_sprite.stage.stageHeight - 40 ),
			                                       0x00AA00,
			                                       20 );
			
			// Start the sound alarm also.
			this.alarm_sound.music_play(); 	                                                        
			
		}
		
		/**
         * explode_ship
		 * 
		 * PARAMETERS: none
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		explodes the ship if over specific number of hits by calling the white colored
		 *      detonator and removing the ship. When detonator is finished it calls the 
		 *      Game_user_interface's game_over function.
		 */
		private function explode_ship() : void
		{				 			
 			// First remove the game user interface clocker.
 			this.user_interface.clocker.remove_me();
			
			// Reuse the detonator for explosion.
			var racket : Detonator = new Detonator( new Point( 0, 0 ),
											  	    this.parent_sprite, 
										   	  		this.simulator, 
										      		this.location.clone(),
										      		this.dir_vector.clone(), 
										      		this.velocity.clone(),
										      		5,
										      		5,
										      		0.4,
										      		4,
										      		0xCCDDFF,
										      		this.user_interface.game_over );
			
			// Remove ship from GUI and LOGIC.
			this.remove_me();
			
			//trace( "Racket just launched! racket.x , racket.y = " + racket.x + ", " + racket.y );
		}
		
		/**
         * remove_me
		 * 
		 * PARAMETERS: none
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		overrides the Particle's remove function, the ship has more stuff to remove like listeners,
		 *      power strips and possible alarm messages.
		 */
		override public function remove_me() : void
		{
			// Remove event listeners.
	        this.parent.stage.removeEventListener( KeyboardEvent.KEY_DOWN, this.key_down_handler );
	        this.parent.stage.removeEventListener( MouseEvent.MOUSE_DOWN,  this.mouse_down_handler );
			
			// Remove recharge strips.
			this.parent_sprite.removeChild( this.laser_recharge_strip );
			this.parent_sprite.removeChild( this.detonator_recharge_strip );
			this.parent_sprite.removeChild( this.force_field_recharge_strip );

// UGLY: don't know better, message can be there or not.
		
			// Remvoe message no force field if any.
			if( this.alarm_message != null )
			{
				this.alarm_message.remove_me();
			}
			
			// Stop the alarm sound if any.
			this.alarm_sound.music_stop();
			
			// Stop the engine sounds if any.
			this.start_engine_sound.music_stop();
						
			super.remove_me();			
		}		
	}
}