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

	public class Space_Station extends Particle
	{
		/**
         * OBJECT LEVEL VARIABLES
         *
		 *   flame   	        :  this will contain the Flash CS3 artwork
		 *   engine_coeficient  :  coeficcient between graphic representaion (scale) and the ship thrust 
		 *                         force
         */
		private var stop_y             : Number;
		private var user_interface     : Game_User_Interface;
		private var is_it_already_done : Boolean;
		
		/**
         * CONSTRUCTOR
         * 
		 *   PARAMETERS:
		 *                parent_sprite     : 
		 *                simulator         : 
		 *                init_loc          : Initial station location.
		 * 				  init_dir          : Initial station angle.
		 *                init_vel          : Initial station velocity.
		 *                stop_y          	: 
		 *
         *   COMMENTS:    below
         * 
         */
		public function Space_Station( user_interface : Game_User_Interface,
									   parent_sprite  : DisplayObjectContainer, 
		                               simulator      : Simulator, 
		                               init_loc       : Point,
		                               init_dir       : Vector, 
		                               init_vel       : Vector,
		                               stop_y         : Number )
		{
			this.user_interface = user_interface;
			this.stop_y = stop_y;
			this.is_it_already_done = false;
			
			// Add the station and start moving it.
 			super( parent_sprite,
 			       simulator,
 			       init_loc,
 			       init_dir,
 			       init_vel,
 			       0,
 			       3 );	
			
			var flash_art : Sprite = new Sprite;

			[Embed(source="./Resources/docking_station_lib.swf", symbol="space_station_mc")] 				
			var run_time_class_station : Class; 			               
			flash_art = new run_time_class_station();
			            
            this.addChild( flash_art ); 
		}
		
		/**
         * boundary_check
		 * 
		 * PARAMETERS: none
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		below
		 */
		override public function boundary_check() : void
		{
			if( this.location.y < this.stop_y && !this.is_it_already_done )
			{
				// Stop me.
				this.velocity.set_y( 0 );
				
				// Call play again function inside user interface.
				this.user_interface.after_win_play_again();	
				
				// Set the flag.
				this.is_it_already_done = true;			
			}			
		}		
	}
}