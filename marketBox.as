package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   
   [Embed(source="/_assets/assets.swf", symbol="marketBox")]
   public dynamic class marketBox extends MovieClip
   {
       
      
      public var editButton:SimpleButton;
      
      public var unlockDisplay:unlockDisplayMc;
      
      public var useDisplay:useDisplayMc;
      
      public var armedDisplay:armedDisplayMc;
      
      public var displayBox:MovieClip;
      
      public function marketBox()
      {
         super();
      }
   }
}
