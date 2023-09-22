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
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;

	/**
     * CLASS Recharge_Strip
     *
	 *  Description:
 	 *      This simulates the power control desk. When any gun or force field is put to action it shows how
 	 *      it recharges.
 	 * 
     */
	public class Recharge_Strip extends Sprite
	{
		/**
         * OBJECT LEVEL VARIABLES
         *
		 *   color             : 
		 *   RECHARGE_TIME     :  the time period that takes to recharge
		 *   understrip_shape  :  holds the transparent strip below, good to see the current progress
		 *   strip_shape       :  holds the actual strip
         */	
		 private var color            : uint;
		 private var RECHARGE_TIME    : Number;
		 private var understrip_shape : Shape;
		 private var strip_shape      : Shape;
		
		/**
		 * CONSTRUCTOR
		 * 
		 * 
		 * PARAMETERS:
		 *     parent_sprite    : 
		 *     time_to_charge   : 
		 *     RECHARGE_TIME    : 
		 *     color            : 
		 *     init_loc         :
		 * 
		 * DESCRIPTION:
		 * 
		 */
		public function Recharge_Strip( parent_sprite    : DisplayObjectContainer,
										time_to_charge   : Number,
										RECHARGE_TIME    : Number,
										color            : uint,
										init_loc         : Point )
		{
			// Add me to the parent sprite.
			parent_sprite.addChild( this );			
			
			// Set members.
			this.understrip_shape = new Shape();
			this.strip_shape      = new Shape();
			this.RECHARGE_TIME = RECHARGE_TIME;
			this.color = color;
			this.x = init_loc.x;
			this.y = init_loc.y;
			
			// Add shapes to this sprite.
			this.addChild( this.understrip_shape );
			this.addChild( this.strip_shape );
			
			this.create_display_list();
		}
		
		/**
		 * create_display_list
		 * 
		 * PARAMETERS: none
		 * 
		 * RETURNS:    none
		 * 
		 */
		private function create_display_list() : void
		{
			// Understrip.
			this.understrip_shape.graphics.beginFill( this.color, 0.3 );
			this.understrip_shape.graphics.drawRect( -4, -50, 8, 50 );
			this.understrip_shape.graphics.endFill();
			
			// Strip.
			this.strip_shape.graphics.beginFill( this.color, 0.8 );
			this.strip_shape.graphics.drawRect( -4, -50, 8, 50 );
			this.strip_shape.graphics.endFill();			
		} 
		
	    /**
		 * update
		 * 
		 * PARAMETERS:   time_to_recharge
		 * 
		 * RETURNS:      none
		 * 
		 * DESCRIPTION : this updates the size of the strip by scaling it.
		 */
		public function update( time_to_recharge : Number ) : void
		{
			if( time_to_recharge >= 0 )
			{
				this.strip_shape.scaleY = 1 - time_to_recharge / this.RECHARGE_TIME;
			}
			else
			{
				this.strip_shape.scaleY = 1;
			}			
		}
	}
}