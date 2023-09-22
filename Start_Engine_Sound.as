/** 
 * Author:  Zbynek Dusatko
 * Date:    03/11/2008
 * Course:  CS1410-EAE HW7
 * Partner: None
 *
 *   Looser_Sound class
 *  
 *
 */
package Asteroids
{
  import flash.events.Event;
  import flash.media.Sound;
  import flash.media.SoundChannel;

    public class Start_Engine_Sound
   {
		/**
		 * CLASS MEMBER VARIABLES
		 *   music              : Sound;
     	 *   music_channel      : SoundChannel;
		 */
        private var music             : Sound;
        private var music_channel     : SoundChannel;
        
        /**
	 	 * CONSTRUCTOR
	 	 *
	 	 *  Parameters   
	 	 *		none
	 	 */      
        public function Start_Engine_Sound()
        {            
            [Embed(source="start_engine.mp3")]
            var Sound_Class : Class;

            this.music = new Sound_Class();                        
        }
                
       /**
         * music_play
         * 
		 *   PARAMETERS:
		 *		none
		 * 	
		 *   RETURNS:
		 *		none
		 * 
         *   COMMENTS:
         */       
        public function music_play() : void
        {
          	// get the music channel and start playing the music
          	this.music_channel = this.music.play();  
        } 
        
        
        /**
         * music_stop
         * 
		 *   PARAMETERS:
		 *		none
		 * 	
		 *   RETURNS:
		 *		none
		 * 
         *   COMMENTS:
         */ 
        public function music_stop() : void
        {
        	
// UGLY: don't know better, throws error when music never played.

        	// If music channel is created stop the music.
        	if( this.music_channel != null )
        	{
        		this.music_channel.stop();
        	}        	
        }         
    }
}

