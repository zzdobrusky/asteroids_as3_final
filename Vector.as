/** 
 *  Author:   Zbynek Dusatko  
 *  Date:     04/10/2008
 *  Course:   1410-EAE Asteroids
 *  Partner:  None
 *
 *   DESCRIPTION:
 *  
 *   This class creates basic properties and methods to create, change position, rotate,
 *   add, change length of and zero 2D vectors. These vectors are considered to 
 *   have the same behavior as defined in regular 2D vector math. 
 *   I am assuming that all start at 0, 0.
 *
 */
	 
package Asteroids
{
	/**
     * CLASS Vector
     *
	 *  Description:
 	 *   	If any function returns a vector type it is not a reference to the original one.
 	 * 
     */     
	 public class Vector
	 {
		 /**
		  * CLASS MEMBER VARIABLES
		  *   
		  *   x_loc :    x coordinate of the vector.
		  *   y_loc :    y coordinate of the vector.
		  *
		  */
		  private var x_loc : Number;
		  private var y_loc : Number;
		  
		 /**
		  * CONSTRUCTOR
		  *  
		  *  The vector should be set to the "unit vector" - magnitute 1. 
		  *  The angle parameter should have a default value of 0.
		  *          y
		  *           |
		  *           |
		  *        00 |--->---- default unit vector at x = 1, y = 0
		  *               1   x
		  *
		  *
		  *  Parameters   
		  *  angle :    This is an angle in degrees.
		  *
		  */
		 public function Vector( x : Number = 1, y : Number = 0)
		 {
			 this.x_loc = x;
		     this.y_loc = y;
		 }
		 
		 /**
		  * GET METHODS
		  *
		  *
		  *   This returns the x coordinate of the vector
		  */
		 public function get_x() : Number
		 {
			 return this.x_loc;			 
		 }
		 
		 /**
		  *   This returns the y coordinate of the vector
		  */
		 public function get_y() : Number
		 {
			 return this.y_loc;			 
		 }
		 
		 /**
		  *  This returns the current vector angle in degrees.
		  */
		 public function get_angle() : Number
		 {
			 return Vector.radians_to_degrees( Math.atan2( this.y_loc, this.x_loc ) );
		 }
		 
		 /**
		  *  This returns the length (magnitude) of the vector
		  */
		 public function get_magnitude() : Number
		 {
			 return Math.sqrt( ( this.x_loc * this.x_loc ) + ( this.y_loc * this.y_loc ) );			 
		 }
		 
		 /**
         * get_angle_between
         * 
         * PARAMETERS: 
         * 		vector1
         *      vector2
         * 
         * RETURNS:    
         * 		Number
         * 
         * DESCRIPTION:
         * 		Returns angle between in degrees.
         */
         public function get_angle_between( vector : Vector ) : Number
         {
         	var vector1 : Vector = this.clone();
         	var vector2 : Vector = vector.clone();
         	
         	// Normalize both vectors.
         	vector1.normalize();
         	vector2.normalize();
         	
         	// Get the dot product and arccos it and return as an angle between in degrees .
         	return Vector.radians_to_degrees( Math.acos( vector1.dot_product( vector2 ) ) );
         }	
		 
		 /**
		  * STATIC METHODS
		  *
		  *  This converts degrees to radians.
		  */
		 public static function degrees_to_radians( degrees : Number ) : Number
		 {
			// The angle can be positive, negative or 0. 
			return( degrees * Math.PI / 180 );
		 }
		 
	    /**
         * get_smaller_angle
         * 
         * PARAMETERS: 
         * 		alpha
         * 		beta
         * 
         * RETURNS:    
         * 		Number
         * 
         * DESCRIPTION:
         * 		Calculates the smaller difference between two angles. Direction is
         *      set by the angle difference sign.
         */
         public static function get_smaller_angle( alpha : Number, beta : Number ) : Number
         {
         	var angle_difference : Number = Vector.get_full_angle( alpha ) - Vector.get_full_angle( beta );
         	
         	if( angle_difference > 180 )
         	{
         		angle_difference = 360 - angle_difference;
         	}
         	
         	if( angle_difference < -180 )
         	{
         		angle_difference = -360 - angle_difference;
         	}
         	
        	return angle_difference;
         }	
        
        /**
         * get_full_angle
         * 
         * PARAMETERS: Number
         * 
         * RETURNS:    Number
         * 
         * DESCRIPTION: 
         * 		 Calculates the full angle. AS is using <0, 180), <-180, 0> ranges. 
         *       This just returns angle if in (0, 180) range and 
         *       (360 - angle) if it is <-180, 0>. 
         * 
         */ 
         public static function get_full_angle( angle : Number ) : Number
         {
        	 if( angle >= 0 )
        	 {
        		 return angle;
        	 }
        	 else
        	 {
        		 return( 360 + angle );
        	 }
         }
         
		 /**
		  *  This converts radians to degrees.
		  */
		 public static function radians_to_degrees( radians : Number ) : Number
		 {
			 // The angle can positive, negative or 0. 
			return( radians * 180 / Math.PI );
		 }
		 
		 /**
		  * add_to_me
		  *
		  *
		  *  This adds a vector to the current one.
		  */
		  public function add_to_me( vector_b : Vector ) : void
		  {
			  this.x_loc += vector_b.get_x();
			  this.y_loc += vector_b.get_y();			  
		  }
		  
		 /**
		  * subtract_from_me
		  *
		  *
		  *  This subtracts a vector from the current one.
		  */
		  public function subtract_from_me( vector_b : Vector ) : void
		  {
			  this.x_loc -= vector_b.get_x();
			  this.y_loc -= vector_b.get_y();			  
		  }
		  
		  /**
		   *  This scales the current vector
		   */
		  public function scale_me( scale_scalar : Number ) : Vector
		  {
			  // scale_scalar can be positive, negative or 0.
			  this.x_loc *= scale_scalar;
			  this.y_loc *= scale_scalar;
			  
			  return this;			  
		  }
		  
		  /**
		   *  This will normalize the length of the vector to 1 but will keep the direction
		   */
		   public function normalize() : void
		   {
				// Store current magnitude first. It would get overwritten.	
				var my_current_magnitude : Number = this.get_magnitude();
				
				// Vector length must be positive.
				if( my_current_magnitude > 0 ) 
				{
					this.x_loc = this.x_loc / my_current_magnitude;
					this.y_loc = this.y_loc / my_current_magnitude;   
				}
				else
				{
					trace("Error: function get_magnitude() returns number <= 0 !");
				}
		   }		
		   
		  /**
		   *  This will calculate new coordinates after rotating the vector by angle_in_degrees
		   */
		   public function rotate_me( angle_in_degrees : Number ) : void 
		   {
			   var angle_in_radians : Number = Vector.degrees_to_radians( angle_in_degrees );
			   var old_x            : Number = this.x_loc;
			   var old_y            : Number = this.y_loc;
			   this.x_loc = Math.cos( angle_in_radians ) * old_x - Math.sin( angle_in_radians ) * old_y;
			   this.y_loc = Math.sin( angle_in_radians ) * old_x + Math.cos( angle_in_radians ) * old_y;			   
		   }
		   
		  /**
		   * This will set x coordinate.
		   */
		  public function set_x( x : Number ) : void
		  {
		  	   this.x_loc = x;
		  } 
		  
		  /**
		   * This will set y coordinate.
		   */
		  public function set_y( y : Number ) : void
		  {
		  	   this.y_loc = y;
		  } 
		   
		  /** 
		   *  This will set the current vector to 0.
		   */
		  public function zero_me() : void
		  {
			  this.x_loc = 0;
			  this.y_loc = 0;
		  }
		   
		  /**
		   * This will project the vector to certain angle.
		   * 
		   * 
		   * DESCRIPTION:
		   * 	project v onto u = (u • v) u; where u is the unit vector
		   */
		  public function get_my_projection_on( projecting_vector : Vector ) : Vector
		  {
		      // First lets make sure that projecting vector is normalized
		      // First clone the parameter.
		      var projecting_vector_normalized : Vector = new Vector();		      
		      projecting_vector_normalized = projecting_vector.clone();
		      
		      // Then normalize.
		      projecting_vector_normalized.normalize();
		      
		      var projected_vector : Vector = new Vector( projecting_vector.x_loc, projecting_vector.y_loc );
		      
		      // Scale the projected vector to the dot product = u • v.
		      projected_vector.scale_me( this.dot_product( projecting_vector_normalized ) );		      
		      
		      return projected_vector;
		  } 
		  
		  /**
		   * clone
		   */
		  public function clone() : Vector
		  {
		  	  // Create a brand new vector with the same angle.
		  	  var cloned_vector : Vector = new Vector( this.x_loc, this.y_loc );
		  	  
		  	  //trace( "Inside Vector cloned_vector = " + cloned_vector.toString() );
		  	  
		  	  return cloned_vector;
		  } 		
		  
		  /**
		   * dot_product
		   */
		  public function dot_product( second_vector : Vector ) : Number
		  {
		      return( this.x_loc * second_vector.x_loc + this.y_loc * second_vector.y_loc );		  	
		  } 
		   
		  /**
		   *  This will be used to print the content of the vector
		   */			
		   public function toString() : String
		   {
			   return( "x, y, angle = " + this.x_loc + ", " + this.y_loc + ", " + this.get_angle() );
		   }   
	 }	
}


