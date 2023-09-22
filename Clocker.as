/**
 *  Author:   Zbynek Dusatko  
 *  Date:     04/10/2008
 *  Course:   1410-EAE Asteroids - Final Project
 *  Partner:  None
 * 
 */

package Asteroids
{
    import flash.events.TimerEvent;
    import flash.utils.Timer;

	/**
     * CLASS Clocker
     *
	 *  Description:
 	 *      This creates a one time timing event, after finishing it executes the call back function
 	 *      and removes the listener.
 	 * 
     */     
    public class Clocker
    {
        /**
         * OBJECT LEVEL VARIABLES
         *
		 *   time_out_fce  : Function
         *   fuse_timer    : waiting period before calling time_out_fce
         */ 
        private var time_out_fce  : Function;
        private var fuse_timer    : Timer;
        
        /**
         * CONSTRUCTOR
         * 
		 *   PARAMETERS:
		 *   	time_out_fce  : Function
         *   	fuse_timer    : waiting period before calling time_out_fce
		 *
         *   COMMENTS:    below
         * 
         */
        public function Clocker( fuse_time : Number, time_out_fce : Function ) 
        {
            // Set the member.
            this.time_out_fce = time_out_fce;
            
            //trace( "Inside Fuse class" );
            
            if( fuse_time > 0 )
            {
            	// Creates a new Timer, calls on_timer_complete after fuse_time secs.
            	this.fuse_timer = new Timer( 1000 * fuse_time, 1 );
            
            	// Designates listeners for completion event.
            	this.fuse_timer.addEventListener( TimerEvent.TIMER, on_timer_complete );

            	// Starts the timer ticking.
            	this.fuse_timer.start();
            }            
        }
        
		/**
         * on_timer_complete
		 * 
		 * PARAMETERS: event
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		Just passes the function call
		 */
        public function on_timer_complete( event : TimerEvent ) : void
        {
            this.time_out_fce();
            //trace("Time's Up!");      
        }
        
        /**
         * remove_me
 		 *
 		 * PARAMETERS: none
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		Just removes the timer listener.
		 */
		public function remove_me() : void
		{
			 // Remove the listener 
            this.fuse_timer.removeEventListener( TimerEvent.TIMER, on_timer_complete );    
		}
    }
}
