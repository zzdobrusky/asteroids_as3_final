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
	import flash.display.Shape;
	import flash.geom.Matrix;

	/**
     * CLASS Force_Field
     *
	 *  Description:
 	 *      This simulates the force field around the ship. 
 	 * 
     */
	public class Force_Field extends Shape
	{
		/**
         * OBJECT LEVEL VARIABLES
         *
		 *   am_i_on               : flag to tell if field is on or off;
		 *   time_to_turn_off      : this times when it turns off
		 *   FORCE_FIELD_OFF_TIME  : this sets the time when it turns off 
		 *   force_field_sound     :   
         */
		public var   am_i_on               : Boolean;
		public var   time_to_turn_off      : Number;
		public const FORCE_FIELD_OFF_TIME  : Number  = 2; 
		
		private var  force_field_sound     : Force_Field_Sound;
		
		
		/**
         * CONSTRUCTOR
         * 
		 *   PARAMETERS:
		 *                parent_sprite     : 
		 *                
		 *
         *   COMMENTS:    below
         * 
         */
		public function Force_Field( parent_sprite : DisplayObjectContainer )
		{
			parent_sprite.addChild( this );
			
			this.force_field_sound = new Force_Field_Sound;
			
			this.am_i_on = false;
			this.time_to_turn_off = 0;	
			
			this.x = 0;
			this.y = 0;			
		}
        
        /**
         * turn_me_on
		 * 
		 * PARAMETERS: none
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		calls the grpahics, sets the flag to true, assigns the timer its max value and play
		 *      the fx sound. 
		 */
        public function turn_me_on() : void
        {
        	this.create_display_list();
        	this.am_i_on = true;
        	
        	// Start the timing to turn it off.
        	this.time_to_turn_off = this.FORCE_FIELD_OFF_TIME;
        	
        	// Start the force field sound.
			this.force_field_sound.music_play();        	
        }
        
        /**
         * turn_me_off
		 * 
		 * PARAMETERS: none
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		clear the grpahics, sets the flag to false, assigns the timer 0. 
		 */
        public function turn_me_off() : void
        {
        	this.graphics.clear();
        	this.am_i_on = false;
        	
        	this.time_to_turn_off = 0;       	
        }
        
        /**
         * create_display_list
		 * 
		 * PARAMETERS: none
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		draws the force field as an ellipsoid with radial gradient in it. 
		 */
        public function create_display_list() : void
        {
			var colors:Array = [ 0xFFFFFF, 0xFFFFFF ];//[0xFF4422, 0xFF4422 ];[ 0xFF33FF, 0xFF33FF ];//
			var alphas:Array = [0,0.3];
			var ratios:Array = [0, 255];
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox( 90, 40, 0, -45, -20 );

			this.graphics.beginGradientFill(GradientType.RADIAL,
			                                			colors,
			                               				alphas,
			                               				ratios,
			                               				matrix);
			this.graphics.drawEllipse( -50, -22, 94, 44 );
			this.graphics.endFill();
        }	
	}
}