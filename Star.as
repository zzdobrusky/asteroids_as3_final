/**
 *  Author:   Zbynek Dusatko  
 *  Date:     04/10/2008
 *  Course:   1410-EAE Asteroids - Final Project
 *  Partner:  None
 * 
 * 
 *  This creates a single star (a circle) on the stage at position (0, 0). We can set the color, 
 *  the star radius, its transparency, if it si twinking or not and the period.
 */

package Asteroids
{
	import flash.display.DisplayObjectContainer;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	                 
	public class Star extends Particle
	{
		/**
		* Class Member Variables
		*
		*   star_color          :  Default star color is white.
		*   star_radius         :  Star radius.
		*   star_transparency   :  Star transparency.
		*   is_it_blinking      :  Sets if the star is twinking or not.
		*   blink_period        :  Sets the blinking interval.
		*
		*/
		public var star_color          : int = 0xFFFFFF;  // Default color is white.
		public var star_radius         : int = 5;
		public var star_transparency   : Number = 1;      // Default no transparency. 
		public var is_it_blinking      : Boolean = false; // Default is not blinking.
		public var blink_period        : int = 3000;      // default is 3 seconds.
		public var my_timer            : Timer;
			   
	   /**
         * CONSTRUCTOR
         * 
		 *   PARAMETERS:
		 *       parent_sprite                : 
		 *       simulator                    : 
		 *       init_loc                     : 
		 *       init_vel                     :
		 *       blinking_star_percentage     :
		 *       blue_star_percentage         : 
		 *       star_blue_color              : 
		 *       red_star_percentage          : 
		 *       star_red_color               : 
		 *       max_star_radius              : 
		 *       star_transparency_percentage :
		 *
         *   COMMENTS:    below
         * 
         */
	    public function Star( parent_sprite            : DisplayObjectContainer,
							  simulator                : Simulator,
							  init_loc                 : Point,
							  init_vel                 : Vector,
							  blinking_star_percentage : Number,
							  blue_star_percentage     : Number,
							  star_blue_color          : uint,
							  red_star_percentage      : Number,
							  star_red_color           : uint,
							  max_star_radius          : Number,
							  star_transparency_percentage : Number )
		{
			super( parent_sprite,
				   simulator,
				   init_loc.clone(),
				   new Vector(), 
				   init_vel.clone(),
				   0, 
				   20 );
			        	
        	// Add the particle to the parent object. 
        	// And lets try to override Particle's addChild( this ).
        	this.parent_sprite.addChildAt( this, 0 );
        		   
			// Make certain percentage of stars blinking and also randomize its period.
			if( Math.random() > ( 1 - blinking_star_percentage / 100 ) )
			{
				this.is_it_blinking = true; // Allow blinking for the star.
				this.blink_period = Math.random() * 3000 + 100; //  Also randomize the blink period.
			}
			
			// Make certain percentage of stars blue.
			if( Math.random() > ( 1 - blue_star_percentage / 100 ) )
			{
				// Set the star color.
				this.star_color = star_blue_color;
			}
			
			// Make certain percentage of stars red.
			if( Math.random() > ( 1 - red_star_percentage / 100 ) )
			{
				// Set the star color.
				this.star_color = star_red_color;
			}
			
			// Randomize each star radius.
			this.star_radius = Math.random() * max_star_radius + 1;	
			
			// Randomize star transparency.
			if( Math.random() > ( 1 - star_transparency_percentage / 100 ) )
			{
					this.star_transparency = Math.random();
			}			
				   
			this.create_display_list();
		}	
		
		/**
		* Create_Display_List function
		* 
		*   This draw a sinle star as a circle.
		*
		*   Parameters
		*   star_color          :  Default star color is white.
		*   star_radius         :  Star radius.
		*   star_transparency   :  Star transparency.
		*   is_it_blinking      :  Sets if the star is twinking or not.
		*   blink_period        :  Sets the blinking interval.
		*
		*   Returns             :  nothing
		*/
		public function create_display_list() : void
		{
			//this.graphics.clear();
			this.graphics.beginFill( star_color, star_transparency );
			this.graphics.drawCircle( 0, 0, star_radius );
			this.graphics.endFill();
			
			// For each star set the timer only if it is allowed to.
			if( is_it_blinking ) 
			{
				this.my_timer = new Timer( blink_period );
            	this.my_timer.addEventListener(  "timer", timerHandler);
            	this.my_timer.start();
			}
			
		}
		
		/**
		* timeHandler function
		* 
		*   THis is called periodicaly and switches the star visibility.
		*
		*   Parameters
		*
		*   Returns             :  nothing
		*/
		public function timerHandler( event : TimerEvent ) : void 
		{
			if ( this.visible )
			{
				this.visible = false;
			}
			else
			{
				this.visible = true;
			}
        }
	}
}