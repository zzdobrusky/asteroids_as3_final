package Asteroids
{
    /**
     * Collision Detection Code provided by Troy Gilbert
     * 
     * This code tests if two graphic objects overlap and
     * considers the alpha.
     * 
     */
     
  import flash.display.BitmapData;
  import flash.display.BitmapDataChannel;
  import flash.display.BlendMode;
  import flash.display.DisplayObject;
  import flash.display.DisplayObjectContainer;
  import flash.geom.Matrix;
  import flash.geom.Point;
  import flash.geom.Rectangle;
   
  public class GUI_Collision_Detection
  {
     /**
      * This function is the only "interface" with the collision detection code.  All the other functions are private
      * 
      * NOTICE: This is a static function, so it "lives alone" meaning there is no
      *         object associated with it. 
      * 
      * The containingGUI is the sprite (etc) that holds both objects that we are
      * checking for collision.
      * 
      * Returns true if the two display objects are colliding (overlapping) 
      */
      public static function isColliding(target1:DisplayObject, target2:DisplayObject, containingGUI:DisplayObjectContainer, pixelPrecise:Boolean = true, tolerance:Number = 0):Boolean
        {
          var collisionRect:Rectangle = getCollisionRect(target1, target2, containingGUI, pixelPrecise, tolerance);
       
          if (collisionRect != null && collisionRect.size.length> 0) return true;
          else return false;
        }



      /**
       *  Get the collision rectangle between two display objects. 
       */
      private static function getCollisionRect(target1:DisplayObject, target2:DisplayObject, containgGUI:DisplayObjectContainer, pixelPrecise:Boolean = false, tolerance:Number = 0):Rectangle
        {
          // get bounding boxes in common parent's coordinate space
          var rect1:Rectangle = target1.getBounds(containgGUI);
          var rect2:Rectangle = target2.getBounds(containgGUI);
           
          // find the intersection of the two bounding boxes
          var intersectionRect:Rectangle = rect1.intersection(rect2);
           
          if (intersectionRect.size.length> 0)
            {
              if (pixelPrecise)
                {
                  // size of rect needs to integer size for bitmap data
                  intersectionRect.width = Math.ceil(intersectionRect.width);
                  intersectionRect.height = Math.ceil(intersectionRect.height);
                   
                  // get the alpha maps for the display objects
                  var alpha1:BitmapData = getAlphaMap(target1, intersectionRect, BitmapDataChannel.RED, containgGUI);
                  var alpha2:BitmapData = getAlphaMap(target2, intersectionRect, BitmapDataChannel.GREEN, containgGUI);
                   
                  // combine the alpha maps
                  alpha1.draw(alpha2, null, null, BlendMode.LIGHTEN);
                   
                  // calculate the search color
                  var searchColor:uint;
                  if (tolerance <= 0)
                    {
                      searchColor = 0x010100;
                    }
                  else
                    {
                      if (tolerance> 1) tolerance = 1;
                      var byte:int = Math.round(tolerance * 255);
                      searchColor = (byte <<16) | (byte <<8) | 0;
                    }
 
                  // find color
                  var collisionRect:Rectangle = alpha1.getColorBoundsRect(searchColor, searchColor);
                  collisionRect.x += intersectionRect.x;
                  collisionRect.y += intersectionRect.y;
                   
                  return collisionRect;
                }
              else
                {
                  return intersectionRect;
                }
            }
          else
            {
              // no intersection
              return null;
            }
        }
       
      /** Gets the alpha map of the display object and places it in the specified channel. **/
      private static function getAlphaMap(target:DisplayObject, rect:Rectangle, channel:uint, containingGUI:DisplayObjectContainer):BitmapData
        {
          // calculate the transform for the display object relative to the common parent
          var parentXformInvert:Matrix = containingGUI.transform.concatenatedMatrix.clone();
          parentXformInvert.invert();
          var targetXform:Matrix = target.transform.concatenatedMatrix.clone();
          targetXform.concat(parentXformInvert);
           
          // translate the target into the rect's space
          targetXform.translate(-rect.x, -rect.y);
           
          // draw the target and extract its alpha channel into a color channel
          var bitmapData:BitmapData = new BitmapData(rect.width, rect.height, true, 0);
          bitmapData.draw(target, targetXform);
          var alphaChannel:BitmapData = new BitmapData(rect.width, rect.height, false, 0);
          alphaChannel.copyChannel(bitmapData, bitmapData.rect, new Point(0, 0), BitmapDataChannel.ALPHA, channel);
           
          return alphaChannel;
        }
 
      /** 
       * Get the center of the collision's bounding box. 
       **/
      private static function getCollisionPoint(target1:DisplayObject, target2:DisplayObject, containingGUI:DisplayObjectContainer, pixelPrecise:Boolean = false, tolerance:Number = 0):Point
        {
          var collisionRect:Rectangle = getCollisionRect(target1, target2, containingGUI, pixelPrecise, tolerance);
       
          if (collisionRect != null && collisionRect.size.length> 0)
            {
              var x:Number = (collisionRect.left + collisionRect.right) / 2;
              var y:Number = (collisionRect.top + collisionRect.bottom) / 2;
       
              return new Point(x, y);
            }
       
          return null;
        }
       
  }
}
