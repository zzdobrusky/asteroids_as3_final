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
  import flash.media.Sound;
  import flash.media.SoundChannel;

    public class You_Made_It_Sound
   {
		 /**
		 * CLASS MEMBER VARIABLES
		 *   music        : Sound;
     	 *   music_channel: SoundChannel;
		 *
		 */
        private var music         : Sound;
        private var music_channel : SoundChannel;
        
        /**
	 	 * CONSTRUCTOR
	 	 *
	 	 *  Parameters   
	 	 *		none
	 	 */      
        public function You_Made_It_Sound()
        {            
            [Embed(source="you_made_it.mp3")]
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
          	this.music_channel = this.music.play();  // get the music channel
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
        	this.music_channel.stop();
        }         
    }
}

