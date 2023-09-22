package Asteroids
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;


	/**
     * CLASS Preloader
     *
	 *  Description:
 	 *      Preloads the main movie clip and puts it on the stage.
 	 * 
     */
	public class Preloader
	{
		
		var my_request    : URLRequest;
		// The loader is a built in ActionScript class which contains the necessary 
		// functionality to load files via the URL created above.
		var my_loader     : Loader;
		var my_movie_clip : MovieClip;
		var preloader_GUI : MovieClip;
		
		public function Preloader( parent_sprite : DisplayObjectContainer,
		                           path : String )
		{
			parent_sprite.addChild( this );
			
			// Import the preloader GUI.
			// Add flash CS3 artwork.
			[Embed(source="./Resources/loader_lib.swf", symbol="preloader")] 				
			var run_time_class : Class; 			               
			this.preloader_GUI  = new run_time_class();            
            this.addChild( preloader_GUI ); // Add it to this Ship class. This should center it around (0,0).
			
			// Initialize member variables.
			this.my_request = new URLRequest( path );
			this.my_loader  = new Loader();
			
			this.configure_listeners( this.my_loader.contentLoaderInfo );

			this.my_loader.load( this.my_request ); // load the request
		}
		
		/** 
		 * configure_listeners
		 *
		 * ARGUMENTS:
		 *		dispatcher : IEventDispatcher
		 *
		 * RETURNS:
		 *      none
		 *
		 * DESCRIPTION:
		 * 		Function that adds event listeners for progress, input output error, 
		 *      and complete events 
		 */
		private function configure_listeners( dispatcher : IEventDispatcher ) : void 
		{
			dispatcher.addEventListener( Event.COMPLETE,         this.complete_handler );
			dispatcher.addEventListener( IOErrorEvent.IO_ERROR,  this.io_error_handler  );
			dispatcher.addEventListener( ProgressEvent.PROGRESS, this.progress_handler );
		}

		/** 
		 * progress_handler
		 *
		 * ARGUMENTS:
		 *		event : ProgressEvent
		 *
		 * RETURNS:
		 *      none
		 *
		 * DESCRIPTION:
		 * 		function that handles the loading progress 
		 */
		private function progress_handler( event : ProgressEvent ) : void 
		{
			// first calculate how much of this image is loaded relative to its percentage of the queue 
			var percent_of_file_loaded : Number = ( event.bytesLoaded / event.bytesTotal ) * 100;
			
			this.update_preloader_GUI( percent_of_file_loaded );
		}

		/** 
		 * complete_handler
		 *
		 * ARGUMENTS:
		 *		event : Event
		 *
		 * RETURNS:
		 *      none
		 *
		 * DESCRIPTION:
		 * 		Function to handle when an image is completely loaded 
		 */ 
		private function complete_handler( event : Event ) : void 
		{ 
		   // First remove the preloader and error message text.
		   this.removeChild( this.preloader_GUI );
		   this.removeChild( this.error_text );
		   
		   // add the loaded movie clip to the parent object (=this)
		   my_movie_clip = ( MovieClip )( event.target.content ) 
		   this.addChild( my_movie_clip ); 
		   
		   // Center it on the stage.
		   my_movie_clip.x = this.stage.stageWidth / 2;
		   my_movie_clip.y = this.stage.stageHeight / 2;
		}

		/** 
		 * io_error_handler
		 *
		 * ARGUMENTS:
		 *		event : IOErrorEvent
		 *
		 * RETURNS:
		 *      none
		 *
		 * DESCRIPTION:
		 * 		function that handles any loading errors that might come up
		 */ 
		private function io_error_handler( event : IOErrorEvent ) : void
		{
		    trace( "io_error_handler: " + event );
		    // print the error to the textfield placed on the stage 
		    // with the "error_text" instance name
		    this.error_text.text = event.toString();
		}

		/** 
		 * update_preloader_GUI
		 *
		 * ARGUMENTS:
		 *		percent: the percentage of the total movie that is loaded
		 *
		 * RETURNS:
		 *      none
		 *
		 * DESCRIPTION:
		 * 		Function that updates the preloader graphic. 
		 */
		private function update_preloader_GUI( percent : Number ) : void 
		{
			// preloader is the preloader MovieClip from the main time line which also has  
			// a graphic preload_bar with an instance name of preload_bar  
			// the graphic is 100 pixels wide so we can set its width to be whatever the percentage  
			// loaded is. 
			// I will use just text preloader.
			this.preloader_GUI.preload_text.text = "" + Math.round( percent );
		}
	}
}