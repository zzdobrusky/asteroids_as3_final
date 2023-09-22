/**
 *  Author:   Zbynek Dusatko  
 *  Date:     04/10/2008
 *  Course:   1410-EAE Asteroids - Final Project
 *  Partner:  None
 * 
 * 
 */
 
package Asteroids
{
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
     * CLASS Text_Message
     *
	 *  Description:
 	 *      This creates a simple text message with preset formatting and located 
 	 *      symetrically around its ( 0, 0 ).
 	 * 
     */	
	public class Text_Message
	{
		/**
		 * CLASS MEMBER VARIABLES
		 * 
		 *   my_text : TextField;
		 *   private var my_format : TextFormat;
		 *
		 */
		private var my_text : TextField;
		private var my_format : TextFormat;
		private var container_sprite : DisplayObjectContainer;
		 
		/**
		 * CONSTRUCTOR
		 *
		 *  PARAMETERS:
		 * 		container_sprite : Parent's object.				  
		 * 		txt              : Body of text message.
		 * 		x                : 
		 * 		y                : 
		 * 		color            : 
		 * 		text_size        :
		 *   
		 *  DESCRIPTION:
		 * 		Takes text and its parameters and centers it around 0,0.
		 */	 
		public function Text_Message( container_sprite : DisplayObjectContainer,				  
								      txt              : String, 
								      loc              : Point,
								      color            : uint = 0x000000,
								      text_size        : int  = 20 )
		{
			// Create text
	  		this.my_text = new TextField();	
			container_sprite.addChild( this.my_text );
			this.container_sprite = container_sprite;
			
			// Set formatting.
			this.my_format = new TextFormat();
			this.my_format.color = color;
			this.my_format.size = text_size;
			this.my_format.font = "Tahoma";
			this.my_format.align = "center";
			
	  		// Set other parameters.
	  		this.my_text.width = 400;
			this.my_text.autoSize = TextFieldAutoSize.CENTER;
	  		this.my_text.x     =  loc.x;
	  		this.my_text.y     =  loc.y;
	  		this.my_text.text  = txt;
	  		
	  		// Apply formatting.
	  		this.my_text.setTextFormat( this.my_format );
		}
		
		/**
		 * remove_me_from
		 *
		 *   PARAMETERS:  container_sprite : Parent's object.
		 *
		 *   RETURNS:     none
		 *
         *   COMMENTS:    Removes the text from the parent's stage.  
		 */
		public function remove_me() : void
		{
			this.container_sprite.removeChild( this.my_text );
		}		
		
     	/**
		 * update_text
		 *
		 *   PARAMETERS:  Text do display.
		 *
		 *   RETURNS:     none
		 *
         *   COMMENTS:    Resets the body of the text. 
		 */
		public function update_text( txt : String ) : void
		{
	  		// Update text.
	  		this.my_text.text = txt;
	  		this.my_text.setTextFormat( this.my_format );
     	}
     	
     	/**
		 * get_text
		 *
		 *   PARAMETERS:  none
		 *
		 *   RETURNS:     String
		 *
         *   COMMENTS:    Returns the containing text.
		 */
		public function get_text() : String
		{
	  		return this.my_text.text;
     	}
     	
     	/**
		 * get_text
		 *
		 *   PARAMETERS:  none
		 *
		 *   RETURNS:     String
		 *
         *   COMMENTS:    Returns the containing text.
		 */
		public function change_my_alpha( alpha : Number ) : void
		{
	  		this.my_text.alpha = alpha;
     	}
	}
}