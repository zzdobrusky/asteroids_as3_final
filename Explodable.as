/**
 *  Author:   Zbynek Dusatko  
 *  Date:     04/10/2008
 *  Course:   1410-EAE Asteroids - Final Project
 *  Partner:  None
 * 
 */

package Asteroids
{
	import flash.display.DisplayObject;
	
	/**
     * INTERFACE Explodable
     *
	 *  Description:
 	 *     This makes sure that particles that are explodable have appropriate functions.
 	 * 
     */  
	public interface Explodable
	{
		/**
         * hitTestObject
         * 
		 *   PARAMETERS:
		 *		obj : DisplayObject
		 * 
		 *   RETURNS:
		 *		Boolean
		 * 
         *   COMMENTS:
         * 		All collidable objects returns true if hits by obj.
         */
		function hitTestObject( obj : DisplayObject ) : Boolean;
		
		/**
         * explode
         * 
		 *   PARAMETERS:
		 *		 none
		 * 
		 *   RETURNS:
		 *		 none
		 * 
         *   COMMENTS:
         * 		Explodes the object.
         */
		function explode() : void;
	}
}