/**
 *  Author:   Zbynek Dusatko  
 *  Date:     04/10/2008
 *  Course:   1410-EAE Asteroids - Final Project
 *  Partner:  None
 * 
 *  Description:
 * 
 *      Creates the button on the stage. It has rollover effect and when clicked it
 *      executes the function passed to button object. Also each button identifies 
 *      itself by its id # which is preserved as its member variable.
 */

package Asteroids
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
     * CLASS Button
     *
	 *  Description:
 	 * 		The call back function is modified so that it doesn't require the e:MouseEvent argument.
     */     
	public class Button extends Sprite
	{
		/**
         * OBJECT LEVEL VARIABLES
         *
         *   my_title  :       A button label.
		 *   my_value  :       Identifies a button. Outsider can use get_value() function to obtain it.
         *   
         */
		private var my_title : String;
		private var my_value : int = 0;
		private var parent_display_container : DisplayObjectContainer;
		private var call_back : Function;
		
		/**
         * CONSTRUCTOR
         *   
		 *   my_title   :      A button label. 
		 *   my_id      :      Identifies a button. Outsider can use get_value() function to obtain it.
		 *   my_width   :      Button width.
		 *   my_height  :      Button height.
		 *   call_back  :      This is the function that is executed when button is clicked.
         *   
		 *   COMMENTS:
         *       Height and width will also change the size of text label.
         */
		public function Button( parent_display_container : DisplayObjectContainer,
								my_title  : String, 
							    my_id     : int, 
								my_width  : int,
								my_height : int,
								x         : Number,
								y         : Number,
								call_back : Function )
		{
			parent_display_container.addChild( this );
			this.parent_display_container = parent_display_container;
			
			this.call_back = call_back;
			
			this.x = x - my_width / 2;
			this.y = y - my_height / 2;
			
			this.my_title  = my_title;
			this.my_value  = my_id;

			this.addEventListener( MouseEvent.MOUSE_DOWN, create_mouse_down_display_list );
			this.addEventListener( MouseEvent.MOUSE_UP,   create_mouse_over_display_list );
			this.addEventListener( MouseEvent.ROLL_OVER,  create_mouse_over_display_list );
			this.addEventListener( MouseEvent.ROLL_OUT,   create_default_display_list );
			this.addEventListener( MouseEvent.CLICK,      this.mouse_click_handler );

			this.create_default_display_list( null );
			this.create_title_display_list();

			this.scaleX = my_width / 100;
			this.scaleY = my_height / 50;
		}
		
		/**
         * mouse_click_handler
		 *
		 *   PARAMETERS:  event
		 *
		 *   RETURNS:     none      
		 *  
         *   COMMENTS:    Just passes the function to the mouse event listener.
         */
		public function mouse_click_handler( event : MouseEvent ) : void
		{
			this.call_back();
		}
		
		/**
         * SET METHODS
         *   set_value
		 *
		 *   PARAMETERS:  the_value  :     This will identify the button.
		 *
		 *   RETURNS:     none      
		 *  
         *   COMMENTS:    Sets the button id.
         */
		public function set_value( the_value : int ) : void
		{
			this.my_value = the_value;
		}

		/**
         * GET METHODS
		 *   get_value
		 *
		 *   PARAMETERS:   none
		 *
		 *   RETURNS:      The button id.
		 *
         *   COMMENTS:
         *   	Gets the button id.
         */
		public function get_value() : int
		{
			return this.my_value;
		}
		
		/**
         * remove_me
         * 
		 *   PARAMETERS: 
		 *
		 *   RETURNS:    
		 *
         *   COMMENTS:   Removes from stage.  
         */
		public function remove_me() : void
		{
			this.parent_display_container.removeChild( this );
		}
		
		
		/**
         * create_default_display_list
         * 
		 *   PARAMETERS: e  :     mouse event
		 *
		 *   RETURNS:    none
		 *
         *   COMMENTS:   This is default graphic, when mouse off and created initally.  
         */
		private function create_default_display_list( e : MouseEvent ) : void
		{
			this.graphics.clear();
			
			this.graphics.lineStyle( 2, 0xCCCCCC );

			var colors:Array = [ 0xF0D0D0, 0xA01030 ];
			var alphas:Array = [ 100, 100 ];
			var ratios:Array = [ 0, 255 ];

			this.graphics.beginGradientFill( "linear", colors, alphas, ratios );
			this.graphics.drawRoundRect( 0, 0, 100, 50, 40 );
			this.graphics.endFill();
		}
		
		/**
		 * create_mouse_down_display_list
		 *
		 *   PARAMETERS: e  :     mouse event
		 *
		 *   RETURNS:    none
		 *
         *   COMMENTS:   Mouse down graphic.
		 */
		private function create_mouse_down_display_list( e : MouseEvent ) : void
		{
			this.graphics.clear();
			
			this.graphics.lineStyle( 2, 0xCCCCCC );

			var colors : Array = [ 0xFAD4DB * .9, 0xEC748B * .9, 0xC13A59 * .9, 0xA81230 * .9 ];
			var alphas : Array = [ 100, 100, 100, 100 ];
			var ratios : Array = [ 0, 126, 127, 255 ];

			this.graphics.beginGradientFill( "radial", colors, alphas, ratios );
			this.graphics.drawRoundRect( 0, 0, 100, 50, 40 );
			this.graphics.endFill();
		}
		
		/**
	 	 * create_mouse_over_display_list
		 *
		 *   PARAMETERS: e  :     mouse event
		 *
		 *   RETURNS:    none
		 *
         *   COMMENTS:   Mouse over graphic.
		 */
		private function create_mouse_over_display_list( e : MouseEvent ) : void
		{
			this.graphics.clear();
			
			this.graphics.lineStyle( 3, 0x000000 );

			var colors : Array = [ 0xD0D0D0, 0x901030 ];
			var alphas : Array = [ 100, 100 ];
			var ratios : Array = [ 0, 255 ];

			this.graphics.beginGradientFill( "linear", colors, alphas, ratios );
			this.graphics.drawRoundRect( 0, 0, 100, 50, 40 );
			this.graphics.endFill();
		}
		
		/**
		 * create_title_display_list
		 *
		 *   PARAMETERS: none
		 *
		 *   RETURNS:    none
		 *
         *   COMMENTS:   Creates button label.
		 */
		private function create_title_display_list() : void
		{
			var my_text   : TextField  = new TextField();
			var my_format : TextFormat = new TextFormat();

			my_text.width  = this.width;
			my_text.height = this.height;

			my_format.align = "center";
			my_format.font  = "Tahoma";
			my_format.size  = 24;
			my_format.color = 0xFFFFFF;

			my_text.text          = this.my_title;
			my_text.selectable    = false;
			my_text.antiAliasType = "advanced";
			my_text.setTextFormat( my_format );
			my_text.y = 10; // Center vertically.

			this.addChild( my_text );
		}
	}
}