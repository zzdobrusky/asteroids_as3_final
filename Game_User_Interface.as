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
     * CLASS Game_User_Interface
     *
	 *  Description:
 	 *     This is a game interface. It needs to be communicating with ship object. If ship explodes the 
 	 *     ship's explode function calls the Game_User_Inteface's game_over function.
 	 *       
 	 * 
     */  
	public class Game_User_Interface extends Sprite
	{
		/**
         * OBJECT LEVEL VARIABLES
         *
		 *   clocker                  : this uses a real time
		 *   intro_page               : holds the intro page imported from Flash CS3
		 *   space_station            : holds the space station imported from Flash CS3, giving particle type
		 *                              so it can be moved on the stage.
		 *   ship                     : 
		 *   start_button             : 
		 *   play_again_button        :
		 *   game_over_text           : 
		 *   you_win_message          : 
		 *   simulator                : 
		 *   station_showtime_clocker : this uses a real time
		 *   sky_generator            : generates the stars
		 *   asteroid_generator       : generates the asteroids
		 *   GAME_TIME                : sets the duration of the game
		 *   ASTEROID_CHOCKER         : this controls the number of asteroids on the stage
		 *   STAR_CHOCKER             : this controls the number of stars on the stage
         */		              
        public  var clocker                  : Clocker;
        
        private var parent_sprite            : DisplayObjectContainer;
        private var intro_page               : Sprite;
        private var space_station            : Particle;
        private var ship                     : Ship;
        private var start_button             : Button;
        private var play_again_button        : Button;
        private var game_over_text           : Text_Message;
        private var you_win_message          : Text_Message;
        private var simulator                : Simulator;
        private var sky_generator            : Sky_Generator;
        private var asteroid_generator       : Asteroid_Generator;
        private var you_made_it_sound        : You_Made_It_Sound;
        
        private const GAME_TIME              : Number = 120;
        private const ASTEROID_CHOCKER       : Number = 0.08;
        private const STAR_CHOCKER           : Number = 0.20;
        private const FORCE_FIELD_MAX_COUNT  : Number = 6;
        private const SPACE_STATION_STOP_Y   : Number = 320;
         
		/**
         * CONSTRUCTOR
         * 
		 *   PARAMETERS:
		 *                parent_sprite     : 
		 *
         *   COMMENTS:    below
         * 
         */
		public function Game_User_Interface( parent_sprite : DisplayObjectContainer )
		{
			this.parent_sprite = parent_sprite;
			this.parent_sprite.addChild( this );
			
			this.you_made_it_sound = new You_Made_It_Sound();
		
			// Add intro page.
			[Embed(source="./Resources/galaxy_background.swf", symbol="background_mc")] 				
			var run_time_class_galaxy : Class; 			               
			this.intro_page = new run_time_class_galaxy();            
            this.addChild( this.intro_page );
            this.intro_page.x = this.parent_sprite.stage.stageWidth / 2;
			this.intro_page.y = this.parent_sprite.stage.stageHeight / 2;
		
			this.start_button = new Button( this, 
			                                "Start game", 
			                                1, 
			                                100, 
			                                40, 
			                                this.parent_sprite.stage.stageWidth / 2, 
			                                this.parent_sprite.stage.stageHeight - 45,
			                                this.start_game );                           			
			 
 		}
 		
 		/**
         * start_game
		 * 
		 * PARAMETERS: none
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		below
		 */
 		public function start_game( ) : void
 		{
 			trace( "inside start_game() " );
 			
 			// Start the clocker.
 			this.clocker = new Clocker( this.GAME_TIME, this.you_win ); 
 			
 			// Remove the button.
 			this.removeChild( this.start_button );
 			
 			// Remove the intro page.
 			this.removeChild( this.intro_page );
 			
 			// Start the time machine.
			this.simulator = new Simulator( this );
			this.simulator.start_simulation();
			
			// Create and start the sky generator. This should put some stars on the stage and start moving thme down.
			this.sky_generator = new Sky_Generator( this, this.simulator, this.STAR_CHOCKER );
			this.sky_generator.start();
			                            
			// Put the spaceship on the stage.
			this.ship = new Ship( this, 
			                            this.simulator, 
			                            this,
			                            new Point( this.parent_sprite.stage.stageWidth / 2, this.parent_sprite.stage.stageHeight / 2 ),
			                            new Vector( 0, -1 ), 
			                            new Vector( 0, 0 ),
			                            0, 
			                            5,
			                            this.FORCE_FIELD_MAX_COUNT );
			
			// Create and start the asteroid generator.                            
			this.asteroid_generator = new Asteroid_Generator( this, this.simulator, this.ASTEROID_CHOCKER );
			this.asteroid_generator.start(); 
 		}	
 		
 		/**
         * game_over
		 * 
		 * PARAMETERS: none
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		below
		 */
 		public function game_over() : void
 		{ 			
 			trace( "inside game_over() " );
 			
 			this.game_over_text = new Text_Message( this,
 													"GAME OVER!",
 													new Point( this.parent_sprite.stage.stageWidth / 2,
 													           this.parent_sprite.stage.stageHeight / 2.2),
 													 0x990000,
 													 50 );
 			
 			this.play_again_button = new Button( this, 
				                                "Play Again", 
				                                1, 
				                                100, 
				                                40, 
				                                this.parent_sprite.stage.stageWidth / 2, 
				                                this.parent_sprite.stage.stageHeight / 2.2 + 100,
				                                this.play_again ); 
			
			// Stop the generators.
			this.asteroid_generator.stop();
 		}	
 		
 		/**
         * play_again
		 * 
		 * PARAMETERS: none
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		below
		 */
 		public function play_again() : void
 		{
 			trace( "inside start_game() " );
 			
 			// Restart the clocker.
 			this.clocker = new Clocker( this.GAME_TIME, this.you_win ); 
 			
 			// Remove play button and message.
 			this.play_again_button.remove_me();
 			this.game_over_text.remove_me();
 			
 			// Remove all asteroids.
 			this.simulator.remove_objects( Asteroid );
 			
 			// Put the spaceship on the stage.
			this.ship = new Ship( this, 
			                            this.simulator, 
			                            this,
			                            new Point( this.parent_sprite.stage.stageWidth / 2, this.parent_sprite.stage.stageHeight / 2 ),
			                            new Vector( 0, -1 ), 
			                            new Vector( 0, 0 ),
			                            0, 
			                            5,
			                            this.FORCE_FIELD_MAX_COUNT );
			                            
			// Start the generators.
			this.asteroid_generator.start();				
 		}
 		
 		/**
         * you_win
		 * 
		 * PARAMETERS: none
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		below
		 */
 		private function you_win() : void
 		{
			// No need to remove the clocker?
			
			// Stop the asteroid generator.
 			this.asteroid_generator.stop();
  			
 			// Stop exploding.
 			this.simulator.stop_hit_test();   
 			
 			// Add the station and start moving it.
 			this.space_station = new Space_Station( this,
 													this,
 			                                        this.simulator,
 			                                        new Point( this.parent_sprite.stage.stageWidth / 2,
 			                                                   this.parent_sprite.stage.stageHeight + 199 ),
 			                                        new Vector(),
 			                                        new Vector( 0, -10 ),
 			                                        this.SPACE_STATION_STOP_Y );	
 			                                   
 			
            
            // Make a you made it sound (air control voice)
            this.you_made_it_sound.music_play();	
 		}
 		
 		/**
         * after_win_play_again
		 * 
		 * PARAMETERS: none
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		below
		 */
 		public function after_win_play_again() : void
 		{ 	
 			// Remove the ship.
 			this.ship.remove_me();	
 			
 			// Show the win message. 			
 			this.you_win_message = new Text_Message( this,
 													 "YOU MADE IT! YOU ARE A HERO!",
 													 new Point( this.parent_sprite.stage.stageWidth / 2,
 													            this.parent_sprite.stage.stageHeight / 1.2 - 20 ),
 													  0x990000,
 													  30 );
 													 
 			// Create play again button.
 			this.play_again_button = new Button( this, 
				                                 "Start over", 
				                                 1, 
				                                 100, 
				                                 40, 
				                                 this.parent_sprite.stage.stageWidth / 2, 
				                                 this.parent_sprite.stage.stageHeight / 1.2 + 50,
				                                 this.play_again_from_start ); 
 		}
 		
 		/**
         * play_again_from_start
		 * 
		 * PARAMETERS: none
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		below
		 */
 		private function play_again_from_start() : void
 		{
 			// Restart the clocker.
 			this.clocker = new Clocker( this.GAME_TIME, this.you_win ); 
 			
 			// Remove play button and message.
 			this.play_again_button.remove_me();
 			this.you_win_message.remove_me();
 			
 			// Remove all asteroids.
 			this.simulator.remove_objects( Asteroid );
 			
 			// Remove the space station.
 			this.space_station.remove_me();
 			
 			// Create a new ship on the stage.
			this.ship = new Ship( this, 
			                            this.simulator, 
			                            this,
			                            new Point( this.parent_sprite.stage.stageWidth / 2, this.parent_sprite.stage.stageHeight / 2 ),
			                            new Vector( 0, -1 ), 
			                            new Vector( 0, 0 ),
			                            0, 
			                            5,
			                            this.FORCE_FIELD_MAX_COUNT );
			                            
			// Start the generators.
			this.asteroid_generator.start();
			 
			// Enable explosions.
			this.simulator.enable_hit_test(); 
 		}
	}
}